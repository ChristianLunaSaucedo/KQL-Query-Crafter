# 0002: Service Environment Field
<!--^ The ECS team will assign a unique, contiguous RFC number upon merging the initial stage of this RFC, taking care not to conflict with other RFCs.-->

- Stage: **2 (candidate)** <!-- Update to reflect target stage -->
- Date: **2021-07-28** <!-- Update to reflect date of most recent stage advancement -->

> **Status (process transition, April 2026):** The fields proposed in this RFC have been merged into the ECS schema as **beta**. This RFC was not formally advanced through the remaining stages before the multi-stage RFC process was retired in favor of the single-stage Proposal process. No further action is needed on this RFC. Beta fields will be evaluated for GA promotion under the field lifecycle process.

<!--
Stage 0: Provide a high level summary of the premise of these changes. Briefly describe the nature, purpose, and impact of the changes. ~2-5 sentences.
-->

## Fields

<!--
Stage: 1: Describe at a high level how this change affects fields. Which fieldsets will be impacted? How many fields overall? Are we primarily adding fields, removing fields, or changing existing fields? The goal here is to understand the fundamental technical implications and likely extent of these changes. ~2-5 sentences.
-->

This RFC calls for the addition in ECS of one field to describe the environment ("production", "staging", "qa"...) from which an event of a component of the application layer (service, application or function) is emitted.

We propose to standardise the environment field to qualify a service using the field already used by Elastic APM: `service.environment`.

No existing ECS field is impacted as no ECS field relates to this concept of "environment".

The `service.environment` field will supplement the existing fields of the [`service.*` namespace](https://www.elastic.co/guide/en/ecs/master/ecs-service.html) such as `service.name` and `service.version`.

<!--
Stage 2: Include new or updated yml field definitions for all of the essential fields in this draft. While not exhaustive, the fields documented here should be comprehensive enough to deeply evaluate the technical considerations of this change. The goal here is to validate the technical details for all essential fields and to provide a basis for adding experimental field definitions to the schema. Use GitHub code blocks with yml syntax formatting.
-->

## Fields (yaml)

```
