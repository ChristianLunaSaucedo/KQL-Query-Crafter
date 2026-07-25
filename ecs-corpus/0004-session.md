# 0004: Session
<!--^ The ECS team will assign a unique, contiguous RFC number upon merging the initial stage of this RFC, taking care not to conflict with other RFCs.-->

- Stage: **0 (strawperson)** <!-- Update to reflect target stage -->
- Date: 7/30/2020 <!-- Update to reflect date of most recent stage advancement -->

> **Status (process transition, April 2026):** The proposed fields were never merged into the ECS schema. The multi-stage RFC process has been retired in favor of the single-stage Proposal process. This RFC is considered inactive. If there is continued interest in these fields, a new proposal can be submitted under the current process.

<!--
Stage 0: Provide a high level summary of the premise of these changes. Briefly describe the nature, purpose, and impact of the changes. ~2-5 sentences.
-->

## Fields
This RFC calls for the addition of session fields to describe events related to various types of "sessions" reported by appliances, security devices, systems, management portals, applications, etc.

| Field | Description |
| ----- | ----------- |
|session.kind:            | local, remote, network
|session.authorization:   | user, admin, service
|session.type:            | system, virtual, application, wired, wireless, vpn
|session.name             | locally relevant name if available (e.g. HQ Client VPN, Win19-VDI, FIN-EXCEL-vApp)
|session.id               | session id provided by server or custom fingerprint



## Fields (yaml)
```yaml
