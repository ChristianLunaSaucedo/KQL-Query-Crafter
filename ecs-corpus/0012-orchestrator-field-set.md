# 0012: Orchestrator field set creation

- Stage: **3 (finished)** <!-- Update to reflect target stage. See https://elastic.github.io/ecs/stages.html -->
- Date: **2021-05-14** <!-- The ECS team sets this date at merge time. This is the date of the latest stage advancement. -->

There is currently no ECS field set for container orchestration engines. There is an example of an ECS
[use-case][0] for Kubernetes, but it largely relies on other ECS field sets, and doesn't cover all of the
potential fields relevant to typical orchestrators. The purpose of this RFC is to propose some improvements to
the existing use-case and then turn it into a full-featured ECS field set, with a larger number of
fields that describe orchestrator-specific primitives which are currently missing (such as cluster names or
resource types, for example).

One use case for this is to allow easier work with [Kubernetes audit logs][1]. Consistent
field definitions will allow teams working with Kubernetes audit logs to share and correlate
data/alerts/visualisations far more easily than currently possible.

There should not be any breaking impact as a result of this change, due to the fact that it should solely
add a new schema rather than change existing material.

## Fields

The proposed change adds nine fields, as described below:

```
