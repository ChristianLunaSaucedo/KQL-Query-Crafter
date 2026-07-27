# 0040: Volume device
<!-- Leave this ID at 0000. The ECS team will assign a unique, contiguous RFC number upon merging the initial stage of this RFC. -->

- Stage: **3 (finished)** <!-- Update to reflect target stage. See https://elastic.github.io/ecs/stages.html -->
- Date: **2023-12-12** <!-- The ECS team sets this date at merge time. This is the date of the latest stage advancement. -->

<!--
As you work on your RFC, use the "Stage N" comments to guide you in what you should focus on, for the stage you're targeting.
Feel free to remove these comments as you go along.
-->

<!--
Stage 0: Provide a high level summary of the premise of these changes. Briefly describe the nature, purpose, and impact of the changes. ~2-5 sentences.
-->

This RFC propose adding the volume device fieldset to describe volume storage devices such as hard disks, removable USB, mountable virtual disks such as ISO.

 * volume.mount_name
 * volume.device_name
 * volume.dos_name
 * volume.nt_name
 * volume.bus_type
 * volume.writable
 * volume.default_access
 * volume.file_system_type
 * volume.product_id
 * volume.product_name
 * volume.vendor_id
 * volume.vendor_name
 * volume.serial_number
 * volume.device_type
 * volume.size
 * volume.removable

<!--
Stage 1: If the changes include field additions or modifications, please create a folder titled as the RFC number under rfcs/text/. This will be where proposed schema changes as standalone YAML files or extended example mappings and larger source documents will go as the RFC is iterated upon.
-->

<!--
Stage X: Provide a brief explanation of why the proposal is being marked as abandoned. This is useful context for anyone revisiting this proposal or considering similar changes later on.
-->

## Fields

<!--
Stage 1: Describe at a high level how this change affects fields. Include new or updated yml field definitions for all of the essential fields in this draft. While not exhaustive, the fields documented here should be comprehensive enough to deeply evaluate the technical considerations of this change. The goal here is to validate the technical details for all essential fields and to provide a basis for adding experimental field definitions to the schema. Use GitHub code blocks with yml syntax formatting, and add them to the corresponding RFC folder.
-->
Details of the proposed fields:

```
