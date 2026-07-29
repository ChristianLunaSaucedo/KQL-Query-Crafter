# ECS Schema Processing Pipeline

## Overview

The ECS schema processing pipeline transforms YAML schema definitions into various output formats (Elasticsearch templates, Beats configs, markdown docs, etc.). It's a multi-stage pipeline where each stage has a specific responsibility.

**Pipeline Stages:**
```
┌─────────────┐
│ YAML Schema │  Raw schema files in schemas/*.yml
│   Files     │
└──────┬──────┘
       │
       v
┌─────────────┐
│   loader.py │  Load & nest: YAML → deeply nested dict
└──────┬──────┘
       │
       v
┌─────────────┐
│  cleaner.py │  Validate, normalize, apply defaults
└──────┬──────┘
       │
       v
┌─────────────┐
│finalizer.py │  Perform field reuse, calculate names
└──────┬──────┘
       │
       v          (Optional filters)
┌─────────────┐  ┌────────────────┐
│subset_filter│─>│exclude_filter  │
│    .py      │  │      .py       │
└──────┬──────┘  └────────┬───────┘
       │                  │
       v                  v
┌─────────────────────────────┐
│   intermediate_files.py     │  Generate flat & nested YAML
└──────────────┬──────────────┘
               │
               v
     ┌────────────────────┐
     │    Generators      │
     ├────────────────────┤
     │ • es_template.py   │  Elasticsearch templates
     │ • beats.py         │  Beats field definitions
     │ • csv_generator.py │  CSV field export
     │ • markdown_fields  │  Markdown documentation
     └────────────────────┘
```

## Quick Reference

### Field Reuse Cheat Sheet

| Concept | What | When to Use | Example |
|---------|------|-------------|---------|
| **Foreign Reuse** | Copy fieldset to different location | Same fields needed elsewhere | `user` → `destination.user` |
| **Transitive** | Reuse carries nested reuses | Automatic composition | If `group` in `user`, `destination.user` gets `group` too |
| **Self-Nesting** | Copy fieldset into itself | Parent/child relationships | `process` → `process.parent` |
| **Non-Transitive** | Self-nesting stays local | Avoid unwanted propagation | `process.parent` NOT at `source.process.parent` |
| **order: 1** | High priority reuse | Has dependencies | `group` reused before `user` |
| **order: 2** | Default priority | Most fieldsets | Standard reuse timing |

**Quick Syntax:**
```yaml
# Foreign reuse (goes to other fieldsets)
fieldset:
  reusable:
    expected:
      - destination  # Simple: reuse as same name
      - at: process  # Complex: reuse with different name
        as: parent

# Self-nesting (stays in same fieldset)  
process:
  reusable:
    expected:
      - at: process  # ← Same name as fieldset = self-nesting
        as: parent
```

### Subset Definition Cheat Sheet

| Syntax | Meaning | Result |
|--------|---------|--------|
| `fields: '*'` | Include all fields | Every field in fieldset |
| `fields: { field: {} }` | Include specific field | Just that one field |
| `fields: { parent: { fields: '*' }}` | Include all nested | All fields under parent |
| `index: false` | Don't index field | Field exists but not searchable |
| `docs_only: true` | Documentation only | In docs, not in artifacts |

**Quick Syntax:**
```yaml
name: my_subset
fields:
  base:
    fields: '*'                    # All base fields
  
  http:
    fields:
      request:
        fields:
          method: {}               # Just this field
      response:
        fields: '*'                # All response fields
  
  destination:
    fields:
      user:                        # Reused fieldset
        fields:
          name: {}                 # Specific user fields
```

### Common Patterns

#### Pattern 1: Network Endpoint Fields (Foreign Reuse)

**Problem:** Need same fields for source, destination, client, server

**Solution:** Create reusable fieldset, reuse at all locations
```yaml
# In geo schema
geo:
  reusable:
    top_level: false  # Only via reuse
    expected:
      - client
      - destination  
      - host
      - observer
      - server
      - source
  fields:
    - name: city_name
    - name: country_name
    - name: location  # latitude/longitude
```

**Result:** `source.geo.city_name`, `destination.geo.city_name`, etc.

#### Pattern 2: Parent-Child Hierarchy (Self-Nesting)

**Problem:** Need to represent parent process, effective user, session leader

**Solution:** Self-nesting
```yaml
process:
  reusable:
    expected:
      - at: process
        as: parent
      - at: process
        as: session_leader
  fields:
    - name: pid
    - name: name
```

**Result:** `process.pid`, `process.parent.pid`, `process.session_leader.pid`

#### Pattern 3: Minimal Web Subset

**Problem:** Only need basic HTTP fields for web logs

**Solution:**
```yaml
name: web_minimal
fields:
  base: { fields: '*' }
  http:
    fields:
      request: { fields: { method: {}, bytes: {} }}
      response: { fields: { status_code: {}, bytes: {} }}
  url: { fields: { domain: {}, path: {} }}
```

**Result:** ~10-15 fields instead of 850

#### Pattern 4: Security Monitoring Subset

**Problem:** Need security-relevant fields only

**Solution:**
```yaml
name: security
fields:
  base: { fields: '*' }
  event: { fields: { action: {}, category: {}, type: {}, outcome: {} }}
  source: { fields: { ip: {}, port: {}, user: { fields: { name: {} }}}}
  destination: { fields: { ip: {}, port: {} }}
  process: 
    fields:
      name: {}
      pid: {}
      parent: { fields: { name: {}, pid: {} }}
  file:
    fields:
      path: {}
      hash: { fields: { sha256: {} }}
```

**Result:** Security-focused field set


## Understanding Subset Definitions

A subset definition is a YAML file that mirrors the field structure, but only includes what you want:

### Basic Subset Structure

```yaml
name: minimal                # Subset name (used for output directory)
fields:                      # Top-level: list fieldsets to include
  base:                      # Fieldset name
    fields: '*'              # '*' = include ALL fields in this fieldset
  
  http:                      # Another fieldset
    fields:                  # Specify which fields to include
      request:               # Nested field
        fields:              # Go deeper
          method: {}         # Include this field
          bytes: {}          # Include this field
      response:
        fields: '*'          # Include ALL response fields
```

### Visual Representation

**Before Subset (Full ECS):**
```
base
├─ @timestamp
├─ message
├─ tags
└─ labels

http
├─ request
│   ├─ method
│   ├─ bytes
│   ├─ referrer
│   └─ body
└─ response
    ├─ status_code
    ├─ bytes
    └─ body

user
├─ name
├─ email
└─ id
```

**Subset Definition:**
```yaml
name: minimal
fields:
  base:
    fields: '*'              # All base fields
  http:
    fields:
      request:
        fields:
          method: {}         # Just method
          bytes: {}          # Just bytes
```

**After Subset:**
```
base                    ✓ (all fields kept)
├─ @timestamp
├─ message
├─ tags
└─ labels

http                    ✓ (partially kept)
├─ request
│   ├─ method          ✓ (explicitly included)
│   ├─ bytes           ✓ (explicitly included)
│   ├─ referrer        ✗ (not in subset)
│   └─ body            ✗ (not in subset)
└─ response            ✗ (entire section excluded)

user                    ✗ (not in subset at all)
```


## Multiple Subsets (Union)

You can specify multiple subset files - they're merged together:

```bash
python generator.py \
  --subset subsets/base.yml subsets/web.yml \
  --semconv-version v1.24.0
```

**Merging Logic:**
- Field in ANY subset → Included in result
- `enabled: false` in subset A, `enabled: true` in subset B → Result: `enabled: true`
- Union operation: More permissive wins

**Example:**

`subsets/base.yml`:
```yaml
fields:
  base:
    fields: '*'
  http:
    fields:
      request:
        fields:
          method: {}
```

`subsets/security.yml`:
```yaml
fields:
  http:
    fields:
      request:
        fields:
          bytes: {}    # Different field
  source:
    fields:
      ip: {}
```

**Merged Result:**
```
base.*                    (from base.yml)
http.request.method       (from base.yml)
http.request.bytes        (from security.yml)
source.ip                 (from security.yml)
```


## Subset Best Practices

1. **Start with base:** Almost always include `base: {fields: '*'}`
2. **Be specific:** Only include fields you actually use
3. **Test thoroughly:** Generate and verify the output
4. **Document why:** Add comments explaining the subset purpose
5. **Version control:** Keep subset definitions in git
6. **Iterate:** Start small, add fields as needed


### Field Reuse Troubleshooting

#### Problem: Field not appearing where expected

**Symptom:** Expected `destination.user.group.id` but it doesn't exist

**Cause:** Reuse order is wrong - `group` not reused into `user` before `user` reused into `destination`

**Solution:**
```yaml
# Ensure correct order
group:
  reusable:
    order: 1  # ← FIRST
    expected:
      - user

user:
  reusable:
    order: 2  # ← SECOND
    expected:
      - destination
```

**How to verify:**
```python
# Check what's in destination.user
from schema import visitor

def show_fields(details):
    if 'flat_name' in details['field_details']:
        name = details['field_details']['flat_name']
        if name.startswith('destination.user'):
            print(name)

visitor.visit_fields(fields, field_func=show_fields)
```

#### Problem: Self-nesting appearing in reused locations

**Symptom:** Expected `source.process.parent` NOT to exist, but it does

**Cause:** Something went wrong with non-transitive logic, or it's actually foreign reuse

**Solution:**
1. Check if `process.parent` is foreign reuse (wrong) or self-nesting (correct):
```yaml
process:
  reusable:
    expected:
      - at: process     # ← Self-nesting (correct)
        as: parent
      - source          # ← Foreign reuse
```

2. If it's self-nesting, it should NOT appear at `source.process.parent`
3. If you WANT it everywhere, change to foreign reuse:
```yaml
# Create separate parent_process fieldset
parent_process:
  reusable:
    order: 1
    expected:
      - at: process
        as: parent
```

#### Problem: Reused fields have wrong OTel mappings

**Symptom:** `destination.user.name` has different OTel mapping than `user.name`

**Cause:** Need to use `otel_reuse` for location-specific mappings

**Solution:**
```yaml
# In user schema
- name: name
  otel_reuse:
    - ecs: destination.user.name     # ← Specific location
      mapping:
        relation: equivalent
        attribute: destination.user.name
    - ecs: source.user.name
      mapping:
        relation: equivalent
        attribute: source.user.name
```

#### Problem: Can't reuse fieldset

**Symptom:** `ValueError: Schema X has attribute root=true and cannot be reused`

**Cause:** Trying to reuse a root fieldset (`base`, etc.)

**Why:** Root fieldsets have fields at document root level. Can't nest them.

**Solution:** Don't reuse root fieldsets. If you need similar functionality, create a new non-root fieldset.


### Strict Mode Issues

If `--strict` fails with warnings:
- Review the warning messages
- Fix schema YAMLs to meet requirements
- Or run without `--strict` (warnings only)
