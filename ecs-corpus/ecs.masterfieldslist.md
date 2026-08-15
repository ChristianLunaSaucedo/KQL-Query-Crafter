# ECS 9.4.0 Field Reference - Optimized for LLM Processing

## Core Metadata Fields

| Field Name | Type            | Description                                 | Example                                         | Valid Values         |
| ---------- | --------------- | ------------------------------------------- | ----------------------------------------------- | -------------------- |
| @timestamp | date            | Date/time when event occurred (REQUIRED)    | 2016-05-23T08:05:34.853Z                        | timestamp (ISO 8601) |
| labels     | object          | Custom key/value pairs for meta information | {"application": "foo-bar", "env": "production"} | JSON object          |
| message    | match_only_text | Log message field, optimized for viewing    | Hello World                                     | string               |
| tags       | keyword         | List of keywords used to tag each event     | ["production", "env2"]                          | string               |

---

## Agent Fields

Agent information about software that collects, detects, or observes events.

| Field Name           | Type    | Description                                | Example                          | Valid Values |
| -------------------- | ------- | ------------------------------------------ | -------------------------------- | ------------ |
| agent.build.original | keyword | Extended build information                 | metricbeat version 7.6.0 (amd64) | string       |
| agent.ephemeral_id   | keyword | Ephemeral identifier (changes on restart)  | 8a4f500f                         | string       |
| agent.id             | keyword | Unique identifier of agent                 | 8a4f500d                         | string       |
| agent.name           | keyword | Custom name of agent                       | foo                              | string       |
| agent.type           | keyword | Type of agent (stays same across restarts) | filebeat                         | string       |
| agent.version        | keyword | Version of agent                           | 6.0.0-rc2                        | string       |

---

## Autonomous System (AS) Fields

Information about Autonomous Systems (IP routing collections).

| Field Name           | Type    | Description          | Example    | Valid Values |
| -------------------- | ------- | -------------------- | ---------- | ------------ |
| as.number            | long    | Unique ASN number    | 15169      | integer      |
| as.organization.name | keyword | AS organization name | Google LLC | string       |

---

## Client Fields

Information about the initiator of a network connection.

| Field Name                  | Type      | Description                                | Example                               | Valid Values         |
| --------------------------- | --------- | ------------------------------------------ | ------------------------------------- | -------------------- |
| client.address              | keyword   | Raw client address (IP, domain, or socket) | -                                     | string               |
| client.as.number            | long      | Client ASN number                          | 15169                                 | integer              |
| client.as.organization.name | keyword   | Client AS organization                     | Google LLC                            | string               |
| client.bytes                | long      | Bytes sent from client to server           | 184                                   | integer              |
| client.domain               | keyword   | Client domain name                         | foo.example.com                       | string               |
| client.geo.city_name        | keyword   | Client city                                | Montreal                              | string               |
| client.geo.continent_code   | keyword   | Client continent code                      | NA                                    | string               |
| client.geo.continent_name   | keyword   | Client continent name                      | North America                         | string               |
| client.geo.country_iso_code | keyword   | Client country ISO code                    | CA                                    | string               |
| client.geo.country_name     | keyword   | Client country name                        | Canada                                | string               |
| client.geo.location         | geo_point | Client longitude and latitude              | {"lon": -73.614830, "lat": 45.505918} | latitude,longitude   |
| client.geo.name             | keyword   | User-defined location description          | boston-dc                             | string               |
| client.geo.postal_code      | keyword   | Client postal code                         | -                                     | string               |
| client.geo.region_iso_code  | keyword   | Client region ISO code                     | CA-QC                                 | string               |
| client.geo.region_name      | keyword   | Client region name                         | Quebec                                | string               |
| client.geo.timezone         | keyword   | Client timezone                            | America/Chicago                       | string               |
| client.ip                   | ip        | Client IP address                          | 192.168.1.1                           | IPv4 or IPv6 address |
| client.mac                  | keyword   | Client MAC address                         | 00:00:5E:00:53:00                     | string               |
| client.nat.ip               | ip        | Translated/NAT IP if applicable            | 192.0.2.0                             | IPv4 or IPv6 address |
| client.nat.port             | long      | Translated/NAT port if applicable          | 8080                                  | integer              |
| client.packets              | long      | Packets sent from client                   | 10                                    | integer              |
| client.port                 | long      | Client port number                         | 8080                                  | integer              |
| client.registered_domain    | keyword   | Registered domain (base domain)            | example.com                           | string               |
| client.subdomain            | keyword   | Subdomain if present                       | www                                   | string               |
| client.top_level_domain     | keyword   | Top level domain                           | com                                   | string               |
| client.user.domain          | keyword   | Client user domain                         | DOMAIN                                | string               |
| client.user.email           | keyword   | Client user email                          | user@example.com                      | string               |
| client.user.full_name       | keyword   | Client user full name                      | John Doe                              | string               |
| client.user.group.domain    | keyword   | Client user group domain                   | -                                     | string               |
| client.user.group.id        | keyword   | Client user group ID                       | S-1-5-21-1234567890                   | string               |
| client.user.group.name      | keyword   | Client user group name                     | Administrators                        | string               |
| client.user.id              | keyword   | Client user ID/SID                         | S-1-5-21-0000000000                   | string               |
| client.user.name            | keyword   | Client username                            | john                                  | string               |

---

## Cloud Fields

Cloud platform/provider information.

| Field Name              | Type    | Description             | Example             | Valid Values |
| ----------------------- | ------- | ----------------------- | ------------------- | ------------ |
| cloud.account.id        | keyword | Cloud account ID        | 123456789           | string       |
| cloud.account.name      | keyword | Cloud account name      | my-account          | string       |
| cloud.availability_zone | keyword | Cloud availability zone | us-east-1a          | string       |
| cloud.instance.id       | keyword | Cloud instance ID       | i-1234567890abcdef0 | string       |
| cloud.instance.name     | keyword | Cloud instance name     | web-server-01       | string       |
| cloud.machine.type      | keyword | Cloud machine type      | m5.large            | string       |
| cloud.project.id        | keyword | Cloud project ID        | my-project          | string       |
| cloud.project.name      | keyword | Cloud project name      | My Project          | string       |
| cloud.provider          | keyword | Cloud provider name     | aws, azure, gcp     | string       |
| cloud.region            | keyword | Cloud region            | us-east-1           | string       |
| cloud.service.name      | keyword | Cloud service name      | EC2, Azure VMs      | string       |

---

## Code Signature Fields

Digital code signing information.

| Field Name                | Type    | Description                         | Example                  | Valid Values             |
| ------------------------- | ------- | ----------------------------------- | ------------------------ | ------------------------ |
| code_signature.exists     | boolean | Code signature exists               | true                     | true, false              |
| code_signature.signing_id | keyword | Identifier for signing entity       | -                        | string                   |
| code_signature.status     | keyword | Signature status                    | valid, invalid, unsigned | valid, invalid, unsigned |
| code_signature.subject    | keyword | Signing certificate subject         | Example Organization     | string                   |
| code_signature.team_id    | keyword | Team identifier from signature      | -                        | string                   |
| code_signature.timestamp  | date    | Signature timestamp                 | 2020-01-01T00:00:00Z     | timestamp (ISO 8601)     |
| code_signature.trusted    | boolean | Signature is from trusted authority | true                     | true, false              |
| code_signature.valid      | boolean | Signature validity                  | true                     | true, false              |

---

## Container Fields

Container/containerization information.

| Field Name                                 | Type         | Description                          | Example                          | Valid Values   |
| ------------------------------------------ | ------------ | ------------------------------------ | -------------------------------- | -------------- |
| container.command                          | keyword      | Container command                    | /bin/sh                          | string         |
| container.cpu.usage                        | scaled_float | Container CPU usage percentage       | 25.5                             | decimal number |
| container.disk.read.bytes                  | long         | Container disk read bytes            | 1048576                          | integer        |
| container.disk.write.bytes                 | long         | Container disk write bytes           | 2097152                          | integer        |
| container.engine.runtime                   | keyword      | Container engine runtime             | docker                           | string         |
| container.id                               | keyword      | Unique container identifier          | 8f2fb01e623f5ca1a97a9c2da0f4f7f3 | string         |
| container.image.hash.all                   | keyword      | All hash algorithms for image        | ["sha256:abc123"]                | string         |
| container.image.name                       | keyword      | Container image name                 | nginx                            | string         |
| container.image.tag                        | keyword      | Container image tag                  | latest                           | string         |
| container.labels                           | object       | Container custom labels              | {"app": "web"}                   | JSON object    |
| container.memory.usage                     | scaled_float | Memory usage percentage              | 50.0                             | decimal number |
| container.name                             | keyword      | Container name                       | web-server                       | string         |
| container.network.ingress.bytes            | long         | Ingress bytes                        | 1024                             | integer        |
| container.network.egress.bytes             | long         | Egress bytes                         | 2048                             | integer        |
| container.privileged                       | boolean      | Container running in privileged mode | false                            | true, false    |
| container.runtime                          | keyword      | Runtime name                         | docker                           | string         |
| container.security_context.privileged      | boolean      | Privileged security context          | false                            | true, false    |
| container.security_context.run_as_non_root | boolean      | Non-root execution                   | true                             | true, false    |
| container.security_context.run_as_user     | keyword      | User to run as                       | 1000                             | string         |

---

## Destination Fields

Information about the destination of a network connection.

| Field Name                       | Type      | Description                      | Example                            | Valid Values         |
| -------------------------------- | --------- | -------------------------------- | ---------------------------------- | -------------------- |
| destination.address              | keyword   | Raw destination address          | 192.168.1.100                      | string               |
| destination.as.number            | long      | Destination ASN                  | 15169                              | integer              |
| destination.as.organization.name | keyword   | Destination AS organization      | Google LLC                         | string               |
| destination.bytes                | long      | Bytes sent to destination        | 500                                | integer              |
| destination.domain               | keyword   | Destination domain               | example.com                        | string               |
| destination.geo.city_name        | keyword   | Destination city                 | San Francisco                      | string               |
| destination.geo.continent_code   | keyword   | Destination continent code       | NA                                 | string               |
| destination.geo.continent_name   | keyword   | Destination continent            | North America                      | string               |
| destination.geo.country_iso_code | keyword   | Destination country ISO          | US                                 | string               |
| destination.geo.country_name     | keyword   | Destination country              | United States                      | string               |
| destination.geo.location         | geo_point | Destination coordinates          | {"lon": -122.4194, "lat": 37.7749} | latitude,longitude   |
| destination.geo.name             | keyword   | Destination location description | -                                  | string               |
| destination.geo.postal_code      | keyword   | Destination postal code          | -                                  | string               |
| destination.geo.region_iso_code  | keyword   | Destination region ISO           | US-CA                              | string               |
| destination.geo.region_name      | keyword   | Destination region               | California                         | string               |
| destination.geo.timezone         | keyword   | Destination timezone             | America/Los_Angeles                | string               |
| destination.ip                   | ip        | Destination IP address           | 192.168.1.100                      | IPv4 or IPv6 address |
| destination.mac                  | keyword   | Destination MAC address          | 00:00:5E:00:53:01                  | string               |
| destination.nat.ip               | ip        | Destination NAT/translated IP    | -                                  | IPv4 or IPv6 address |
| destination.nat.port             | long      | Destination NAT/translated port  | -                                  | integer              |
| destination.packets              | long      | Packets sent to destination      | 20                                 | integer              |
| destination.port                 | long      | Destination port number          | 443                                | integer              |
| destination.registered_domain    | keyword   | Destination registered domain    | example.com                        | string               |
| destination.subdomain            | keyword   | Destination subdomain            | www                                | string               |
| destination.top_level_domain     | keyword   | Destination TLD                  | com                                | string               |
| destination.user.domain          | keyword   | Destination user domain          | -                                  | string               |
| destination.user.email           | keyword   | Destination user email           | -                                  | string               |
| destination.user.full_name       | keyword   | Destination user full name       | -                                  | string               |
| destination.user.group.domain    | keyword   | Destination user group domain    | -                                  | string               |
| destination.user.group.id        | keyword   | Destination user group ID        | -                                  | string               |
| destination.user.group.name      | keyword   | Destination user group name      | -                                  | string               |
| destination.user.id              | keyword   | Destination user ID              | -                                  | string               |
| destination.user.name            | keyword   | Destination username             | -                                  | string               |

---

## DNS Fields

Domain Name System query/response information.

| Field Name                     | Type    | Description                 | Example                              | Valid Values                         |
| ------------------------------ | ------- | --------------------------- | ------------------------------------ | ------------------------------------ |
| dns.additional                 | object  | Additional DNS records      | -                                    | JSON object                          |
| dns.additional_count           | long    | Count of additional records | 0                                    | integer                              |
| dns.answers                    | object  | DNS answer records          | -                                    | JSON object                          |
| dns.answers.class              | keyword | Answer record class         | IN                                   | string                               |
| dns.answers.data               | keyword | Answer record data          | 8.8.8.8                              | string                               |
| dns.answers.name               | keyword | Answer domain name          | example.com                          | string                               |
| dns.answers.ttl                | long    | Time-to-live in seconds     | 3600                                 | integer                              |
| dns.answers.type               | keyword | Answer record type          | A, AAAA, CNAME, MX, TXT, NS          | A, AAAA, CNAME, MX, TXT, NS          |
| dns.answers_count              | long    | Number of answer records    | 1                                    | integer                              |
| dns.authority                  | object  | Authority records           | -                                    | JSON object                          |
| dns.authority_count            | long    | Authority records count     | 0                                    | integer                              |
| dns.flags                      | keyword | DNS flags                   | ["rd", "ra"]                         | string                               |
| dns.header_flags               | keyword | DNS header flags            | -                                    | string                               |
| dns.id                         | keyword | DNS message ID              | -                                    | string                               |
| dns.op_code                    | keyword | DNS operation code          | QUERY, UPDATE, IQUERY                | string                               |
| dns.question.class             | keyword | Question class              | IN                                   | string                               |
| dns.question.name              | keyword | Domain queried (FQDN)       | example.com                          | string                               |
| dns.question.registered_domain | keyword | Registered domain queried   | example.com                          | string                               |
| dns.question.subdomain         | keyword | Subdomain queried           | www                                  | string                               |
| dns.question.top_level_domain  | keyword | TLD queried                 | com                                  | string                               |
| dns.question.type              | keyword | Query type                  | A, AAAA, CNAME, MX, TXT, NS, SOA     | A, AAAA, CNAME, MX, TXT, NS, SOA     |
| dns.response_code              | keyword | Response code               | NOERROR, NXDOMAIN, SERVFAIL, REFUSED | NOERROR, NXDOMAIN, SERVFAIL, REFUSED |

---

## Email Fields

Email/message information.

| Field Name                         | Type    | Description              | Example                     | Valid Values         |
| ---------------------------------- | ------- | ------------------------ | --------------------------- | -------------------- |
| email.attachments.file.hash.md5    | keyword | Attachment MD5 hash      | -                           | string               |
| email.attachments.file.hash.sha1   | keyword | Attachment SHA1 hash     | -                           | string               |
| email.attachments.file.hash.sha256 | keyword | Attachment SHA256 hash   | -                           | string               |
| email.attachments.file.mime_type   | keyword | Attachment MIME type     | application/pdf             | string               |
| email.attachments.file.name        | keyword | Attachment filename      | document.pdf                | string               |
| email.attachments.file.size        | long    | Attachment size in bytes | 102400                      | integer              |
| email.bcc.address                  | keyword | BCC recipient addresses  | user@example.com            | string               |
| email.cc.address                   | keyword | CC recipient addresses   | user@example.com            | string               |
| email.delivery_timestamp           | date    | Email delivery time      | 2020-01-01T00:00:00Z        | timestamp (ISO 8601) |
| email.direction                    | keyword | Email direction          | inbound, outbound, internal | string               |
| email.from.address                 | keyword | From email address       | sender@example.com          | string               |
| email.local_id                     | keyword | Email local identifier   | -                           | string               |
| email.message_id                   | keyword | Email message ID         | <abc@example.com>           | string               |
| email.origination_timestamp        | date    | Email origination time   | 2020-01-01T00:00:00Z        | timestamp (ISO 8601) |
| email.reply_to.address             | keyword | Reply-to address         | replyto@example.com         | string               |
| email.sender.address               | keyword | Sender email address     | sender@example.com          | string               |
| email.subject                      | text    | Email subject line       | Important Update            | string               |
| email.to.address                   | keyword | To recipient addresses   | recipient@example.com       | string               |
| email.x_mailer                     | keyword | X-Mailer header value    | Mozilla Thunderbird         | string               |

---

## Event Fields

Event classification and metadata.

| Field Name            | Type         | Description                      | Example                                          | Valid Values                                                                                                                                                                                  |
| --------------------- | ------------ | -------------------------------- | ------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| event.action          | keyword      | Specific action performed        | added, removed, modified, allowed, denied        | added, removed, modified, allowed, denied, executed, installed                                                                                                                                |
| event.category        | keyword      | Event category                   | network, process, file, registry, authentication | api, authentication, configuration, database, driver, email, file, host, iam, intrusion_detection, library, malware, network, package, process, registry, session, threat, vulnerability, web |
| event.code            | keyword      | Event code (Windows Event ID)    | 4624, 4625, 11, 13                               | string                                                                                                                                                                                        |
| event.created         | date         | When event was created           | 2020-01-01T00:00:00Z                             | timestamp (ISO 8601)                                                                                                                                                                          |
| event.dataset         | keyword      | Dataset name                     | -                                                | string                                                                                                                                                                                        |
| event.duration        | long         | Event duration in nanoseconds    | 1000000                                          | integer                                                                                                                                                                                       |
| event.end             | date         | Event end time                   | 2020-01-01T00:00:01Z                             | timestamp (ISO 8601)                                                                                                                                                                          |
| event.hash            | keyword      | Event hash                       | -                                                | string                                                                                                                                                                                        |
| event.id              | keyword      | Unique event ID                  | -                                                | string                                                                                                                                                                                        |
| event.ingested        | date         | When ingested into Elasticsearch | 2020-01-01T00:00:02Z                             | timestamp (ISO 8601)                                                                                                                                                                          |
| event.kind            | keyword      | Kind of event                    | event, pipeline_error, signal, state             | alert, asset, enrichment, event, metric, state, pipeline_error, signal                                                                                                                        |
| event.module          | keyword      | Module name                      | -                                                | string                                                                                                                                                                                        |
| event.original        | keyword      | Original event data              | -                                                | string                                                                                                                                                                                        |
| event.outcome         | keyword      | Event outcome                    | success, failure, unknown                        | failure, success, unknown                                                                                                                                                                     |
| event.provider        | keyword      | Event provider name              | -                                                | string                                                                                                                                                                                        |
| event.reason          | keyword      | Reason for event                 | -                                                | string                                                                                                                                                                                        |
| event.reference       | keyword      | Event reference                  | -                                                | string                                                                                                                                                                                        |
| event.risk_score      | scaled_float | Risk score 0-100                 | 75.5                                             | decimal number                                                                                                                                                                                |
| event.risk_score_norm | scaled_float | Normalized risk 0.0-1.0          | 0.755                                            | decimal number                                                                                                                                                                                |
| event.sequence        | long         | Event sequence number            | 1                                                | integer                                                                                                                                                                                       |
| event.severity        | long         | Event severity                   | 0, 1, 2, 3                                       | integer                                                                                                                                                                                       |
| event.start           | date         | Event start time                 | 2020-01-01T00:00:00Z                             | timestamp (ISO 8601)                                                                                                                                                                          |
| event.timezone        | keyword      | Event timezone                   | America/New_York                                 | string                                                                                                                                                                                        |
| event.type            | keyword      | Event type                       | start, stop, creation, deletion, change          | access, admin, allowed, change, connection, creation, deletion, denied, device, end, error, group, indicator, info, installation, protocol, start, user                                       |
| event.url             | keyword      | Event URL                        | https://example.com                              | string                                                                                                                                                                                        |

---

## File Fields

File and filesystem information.

| Field Name                            | Type      | Description                   | Example                                  | Valid Values             |
| ------------------------------------- | --------- | ----------------------------- | ---------------------------------------- | ------------------------ |
| file.accessed                         | date      | File last accessed time       | 2020-01-01T00:00:00Z                     | timestamp (ISO 8601)     |
| file.attributes                       | keyword   | File attributes               | Hidden, System, ReadOnly, Archive        | string                   |
| file.code_signature.digest_algorithm  | keyword   | Code signature hash algorithm | sha256                                   | string                   |
| file.code_signature.exists            | boolean   | Code signature exists         | true                                     | true, false              |
| file.code_signature.signing_id        | keyword   | Signing identifier            | -                                        | string                   |
| file.code_signature.status            | keyword   | Signature status              | valid, invalid, unsigned                 | valid, invalid, unsigned |
| file.code_signature.subject           | keyword   | Certificate subject           | Example Organization                     | string                   |
| file.code_signature.team_id           | keyword   | Team ID from signature        | -                                        | string                   |
| file.code_signature.timestamp         | date      | Signature timestamp           | 2020-01-01T00:00:00Z                     | timestamp (ISO 8601)     |
| file.code_signature.trusted           | boolean   | Trusted signature             | true                                     | true, false              |
| file.code_signature.valid             | boolean   | Valid signature               | true                                     | true, false              |
| file.created                          | date      | File creation time            | 2020-01-01T00:00:00Z                     | timestamp (ISO 8601)     |
| file.ctime                            | date      | Inode change time (Unix)      | 2020-01-01T00:00:00Z                     | timestamp (ISO 8601)     |
| file.device                           | keyword   | Device ID (Unix)              | -                                        | string                   |
| file.directory                        | keyword   | Directory path                | /home/user                               | string                   |
| file.drive_letter                     | keyword   | Drive letter (Windows)        | C                                        | string                   |
| file.elf.arch                         | keyword   | ELF architecture              | x86-64                                   | string                   |
| file.elf.byte_order                   | keyword   | ELF byte order                | Little Endian                            | string                   |
| file.elf.cpu_type                     | keyword   | ELF CPU type                  | -                                        | string                   |
| file.elf.creation_date                | date      | ELF creation date             | -                                        | timestamp (ISO 8601)     |
| file.elf.exports                      | flattened | ELF exports                   | -                                        | JSON object              |
| file.elf.go_import_path               | keyword   | Go import path                | -                                        | string                   |
| file.elf.go_stripped                  | boolean   | Go stripped from ELF          | false                                    | true, false              |
| file.elf.header.abi_version           | keyword   | ABI version                   | -                                        | string                   |
| file.elf.header.class                 | keyword   | ELF class                     | 32-bit, 64-bit                           | string                   |
| file.elf.header.data                  | keyword   | ELF data encoding             | -                                        | string                   |
| file.elf.header.entrypoint            | long      | Entry point address           | -                                        | integer                  |
| file.elf.header.os_abi                | keyword   | OS/ABI                        | UNIX System V                            | string                   |
| file.elf.header.type                  | keyword   | ELF header type               | -                                        | string                   |
| file.elf.header.version               | keyword   | ELF header version            | -                                        | string                   |
| file.elf.imports                      | flattened | ELF imports                   | -                                        | JSON object              |
| file.elf.sections                     | nested    | ELF sections                  | -                                        | array of objects         |
| file.elf.segments                     | nested    | ELF segments                  | -                                        | array of objects         |
| file.elf.shared_libraries             | keyword   | ELF shared libraries          | -                                        | string                   |
| file.elf.telfhash                     | keyword   | TELFHASH hash of ELF          | -                                        | string                   |
| file.extension                        | keyword   | File extension                | exe, dll, txt, pdf                       | string                   |
| file.fork_name                        | keyword   | Fork name (macOS)             | -                                        | string                   |
| file.gid                              | keyword   | File group ID (Unix)          | 0                                        | string                   |
| file.group                            | keyword   | File group name (Unix)        | root                                     | string                   |
| file.hash.md5                         | keyword   | MD5 hash                      | d41d8cd98f00b204e9800998ecf8427e         | string                   |
| file.hash.sha1                        | keyword   | SHA-1 hash                    | da39a3ee5e6b4b0d3255bfef95601890afd80709 | string                   |
| file.hash.sha256                      | keyword   | SHA-256 hash                  | e3b0c44298fc1c149afbf4c8996fb924         | string                   |
| file.hash.sha512                      | keyword   | SHA-512 hash                  | -                                        | string                   |
| file.hash.ssdeep                      | keyword   | SSDEEP fuzzy hash             | -                                        | string                   |
| file.hash.tlsh                        | keyword   | TLSH hash                     | -                                        | string                   |
| file.inode                            | keyword   | Inode number (Unix)           | 12345                                    | string                   |
| file.mime_type                        | keyword   | MIME type                     | application/pdf, text/plain              | string                   |
| file.mode                             | keyword   | Unix file permissions         | 0755                                     | string                   |
| file.mtime                            | date      | File modification time        | 2020-01-01T00:00:00Z                     | timestamp (ISO 8601)     |
| file.name                             | keyword   | Filename only                 | document.pdf                             | string                   |
| file.owner                            | keyword   | File owner username           | root                                     | string                   |
| file.path                             | keyword   | Full file path                | /home/user/document.pdf                  | string                   |
| file.path.text                        | text      | Full file path (text field)   | -                                        | string                   |
| file.pe.architecture                  | keyword   | PE architecture               | x86, x86-64, ARM                         | string                   |
| file.pe.company                       | keyword   | PE company name               | Microsoft Corporation                    | string                   |
| file.pe.description                   | keyword   | PE file description           | Notepad                                  | string                   |
| file.pe.file_version                  | keyword   | PE file version               | 10.0.19041                               | string                   |
| file.pe.imphash                       | keyword   | PE import hash                | -                                        | string                   |
| file.pe.original_file_name            | keyword   | PE original filename          | notepad.exe                              | string                   |
| file.pe.product                       | keyword   | PE product name               | Microsoft Windows                        | string                   |
| file.pe.sections                      | nested    | PE sections                   | -                                        | array of objects         |
| file.size                             | long      | File size in bytes            | 102400                                   | integer                  |
| file.target_path                      | keyword   | Target path for symlinks      | /path/to/target                          | string                   |
| file.temp                             | boolean   | Temporary file flag           | false                                    | true, false              |
| file.type                             | keyword   | File type                     | file, dir, symlink                       | string                   |
| file.uid                              | keyword   | File owner UID (Unix)         | 0                                        | string                   |
| file.x509.alternative_names           | keyword   | x509 alternative names        | \*.example.com                           | string                   |
| file.x509.issuer.common_name          | keyword   | x509 issuer CN                | Example CA                               | string                   |
| file.x509.issuer.country              | keyword   | x509 issuer country           | US                                       | string                   |
| file.x509.issuer.distinguished_name   | keyword   | x509 issuer DN                | -                                        | string                   |
| file.x509.issuer.locality             | keyword   | x509 issuer locality          | -                                        | string                   |
| file.x509.issuer.organization         | keyword   | x509 issuer organization      | -                                        | string                   |
| file.x509.issuer.organizational_unit  | keyword   | x509 issuer OU                | -                                        | string                   |
| file.x509.issuer.state_or_province    | keyword   | x509 issuer state             | -                                        | string                   |
| file.x509.not_after                   | date      | x509 certificate expiry       | 2025-01-01T00:00:00Z                     | timestamp (ISO 8601)     |
| file.x509.not_before                  | date      | x509 certificate start        | 2020-01-01T00:00:00Z                     | timestamp (ISO 8601)     |
| file.x509.public_key_algorithm        | keyword   | x509 public key algorithm     | RSA                                      | string                   |
| file.x509.public_key_curve            | keyword   | x509 curve name               | nistp256                                 | string                   |
| file.x509.public_key_exponent         | long      | x509 public key exponent      | 65537                                    | integer                  |
| file.x509.public_key_size             | long      | x509 key size in bits         | 2048                                     | integer                  |
| file.x509.serial_number               | keyword   | x509 serial number            | 123456                                   | string                   |
| file.x509.signature_algorithm         | keyword   | x509 signature algorithm      | SHA256-RSA                               | string                   |
| file.x509.subject.common_name         | keyword   | x509 subject CN               | example.com                              | string                   |
| file.x509.subject.country             | keyword   | x509 subject country          | US                                       | string                   |
| file.x509.subject.distinguished_name  | keyword   | x509 subject DN               | -                                        | string                   |
| file.x509.subject.locality            | keyword   | x509 subject locality         | -                                        | string                   |
| file.x509.subject.organization        | keyword   | x509 subject organization     | -                                        | string                   |
| file.x509.subject.organizational_unit | keyword   | x509 subject OU               | -                                        | string                   |
| file.x509.subject.state_or_province   | keyword   | x509 subject state            | -                                        | string                   |
| file.x509.version_number              | keyword   | x509 version                  | 3                                        | string                   |

---

## Group Fields

User group information.

| Field Name   | Type    | Description  | Example             | Valid Values |
| ------------ | ------- | ------------ | ------------------- | ------------ |
| group.domain | keyword | Group domain | DOMAIN              | string       |
| group.id     | keyword | Group ID/SID | S-1-5-21-0000000000 | string       |
| group.name   | keyword | Group name   | Administrators      | string       |

---

## Host Fields

Host/system information.

| Field Name                   | Type         | Description                | Example                            | Valid Values              |
| ---------------------------- | ------------ | -------------------------- | ---------------------------------- | ------------------------- |
| host.arch                    | keyword      | System architecture        | x86_64, arm64, i386                | string                    |
| host.boot.id                 | keyword      | Boot identifier            | -                                  | string                    |
| host.cpu.cores               | long         | Number of CPU cores        | 4                                  | integer                   |
| host.cpu.logical_cores       | long         | Number of logical cores    | 8                                  | integer                   |
| host.cpu.usage               | scaled_float | CPU usage percentage       | 25.5                               | decimal number            |
| host.cpu.vendor.name         | keyword      | CPU vendor                 | GenuineIntel                       | string                    |
| host.disk.read.bytes         | long         | Disk read bytes            | 1048576                            | integer                   |
| host.disk.write.bytes        | long         | Disk write bytes           | 2097152                            | integer                   |
| host.domain                  | keyword      | Host domain name           | example.com                        | string                    |
| host.geo.city_name           | keyword      | Host city                  | San Francisco                      | string                    |
| host.geo.continent_code      | keyword      | Host continent code        | NA                                 | string                    |
| host.geo.continent_name      | keyword      | Host continent             | North America                      | string                    |
| host.geo.country_iso_code    | keyword      | Host country ISO           | US                                 | string                    |
| host.geo.country_name        | keyword      | Host country               | United States                      | string                    |
| host.geo.location            | geo_point    | Host coordinates           | {"lon": -122.4194, "lat": 37.7749} | latitude,longitude        |
| host.geo.name                | keyword      | Host location description  | -                                  | string                    |
| host.geo.postal_code         | keyword      | Host postal code           | -                                  | string                    |
| host.geo.region_iso_code     | keyword      | Host region ISO            | US-CA                              | string                    |
| host.geo.region_name         | keyword      | Host region                | California                         | string                    |
| host.geo.timezone            | keyword      | Host timezone              | America/Los_Angeles                | string                    |
| host.hostname                | keyword      | Short hostname             | web-server                         | string                    |
| host.id                      | keyword      | Unique host ID             | abc-123-def                        | string                    |
| host.ip                      | ip           | Host IP address(es)        | 192.168.1.1                        | IPv4 or IPv6 address      |
| host.mac                     | keyword      | Host MAC address           | 00:00:5E:00:53:00                  | string                    |
| host.memory.total            | long         | Total memory in bytes      | 8589934592                         | integer                   |
| host.memory.usage            | scaled_float | Memory usage percentage    | 50.0                               | decimal number            |
| host.name                    | keyword      | Hostname or FQDN           | web-server.example.com             | string                    |
| host.network.direction       | keyword      | Network direction          | ingress, egress, internal          | ingress, egress, internal |
| host.network.ingress.bytes   | long         | Ingress bytes              | 1024                               | integer                   |
| host.network.ingress.packets | long         | Ingress packets            | 10                                 | integer                   |
| host.network.egress.bytes    | long         | Egress bytes               | 2048                               | integer                   |
| host.network.egress.packets  | long         | Egress packets             | 20                                 | integer                   |
| host.os.build                | keyword      | OS build                   | 19041                              | string                    |
| host.os.codename             | keyword      | OS codename                | focal                              | string                    |
| host.os.family               | keyword      | OS family                  | windows, linux, macos              | windows, linux, macos     |
| host.os.full                 | keyword      | Full OS description        | Ubuntu 20.04.1 LTS                 | string                    |
| host.os.full.text            | text         | Full OS (text field)       | -                                  | string                    |
| host.os.kernel.name          | keyword      | Kernel name                | Linux                              | string                    |
| host.os.kernel.release       | keyword      | Kernel release             | 5.4.0-42-generic                   | string                    |
| host.os.kernel.version       | keyword      | Kernel version             | 5.4.0                              | string                    |
| host.os.name                 | keyword      | OS name                    | Windows, Linux, macOS              | string                    |
| host.os.platform             | keyword      | Platform                   | windows, linux, macos              | windows, linux, macos     |
| host.os.type                 | keyword      | OS type                    | Windows, Linux, etc.               | string                    |
| host.os.version              | keyword      | OS version                 | 10.0.19041                         | string                    |
| host.pid_ns_inum             | keyword      | PID namespace inode        | -                                  | string                    |
| host.risk.calculated_level   | keyword      | Risk level                 | critical, high, medium, low        | string                    |
| host.risk.static_level       | keyword      | Static risk level          | critical, high, medium, low        | string                    |
| host.speed                   | long         | Host speed in MB/s         | -                                  | integer                   |
| host.type                    | keyword      | Host type                  | vm, bare-metal, server             | string                    |
| host.uptime                  | long         | Host uptime in nanoseconds | -                                  | integer                   |

---

## HTTP Fields

HTTP request/response information.

| Field Name                       | Type     | Description           | Example                      | Valid Values                                 |
| -------------------------------- | -------- | --------------------- | ---------------------------- | -------------------------------------------- |
| http.request.body.bytes          | long     | Request body size     | 1024                         | integer                                      |
| http.request.body.content        | wildcard | Request body content  | -                            | string (supports \*)                         |
| http.request.id                  | keyword  | Request ID            | -                            | string                                       |
| http.request.method              | keyword  | HTTP method           | GET, POST, PUT, DELETE, HEAD | GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS |
| http.request.mime_type           | keyword  | Request MIME type     | application/json             | string                                       |
| http.request.referrer            | keyword  | Referrer header       | https://example.com          | string                                       |
| http.request.user_agent          | keyword  | User-Agent header     | Mozilla/5.0                  | string                                       |
| http.request.user_agent.name     | keyword  | Browser name          | Chrome                       | string                                       |
| http.request.user_agent.original | keyword  | Original User-Agent   | Mozilla/5.0                  | string                                       |
| http.response.body.bytes         | long     | Response body size    | 2048                         | integer                                      |
| http.response.body.content       | wildcard | Response body content | -                            | string (supports \*)                         |
| http.response.mime_type          | keyword  | Response MIME type    | text/html                    | string                                       |
| http.response.status_code        | long     | HTTP status code      | 200, 404, 500                | integer                                      |
| http.version                     | keyword  | HTTP version          | 1.0, 1.1, 2.0, 3.0           | string                                       |

---

## HTTPS/TLS Fields

HTTPS/TLS/SSL connection information.

| Field Name             | Type    | Description                      | Example                               | Valid Values |
| ---------------------- | ------- | -------------------------------- | ------------------------------------- | ------------ |
| https.cipher           | keyword | TLS cipher suite                 | TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 | string       |
| https.client.x509.\*   | -       | Client certificate (x509 fields) | -                                     |              |
| https.curve            | keyword | Elliptic curve                   | P-256                                 | string       |
| https.established      | boolean | TLS connection established       | true                                  | true, false  |
| https.ja3              | keyword | JA3 TLS fingerprint              | -                                     | string       |
| https.ja3s             | keyword | JA3S TLS fingerprint (server)    | -                                     | string       |
| https.next_protocol    | keyword | Next protocol (ALPN)             | h2, http/1.1                          | string       |
| https.protocol_version | keyword | Protocol version                 | TLS 1.2, TLS 1.3                      | string       |
| https.resumed          | boolean | Session resumed                  | false                                 | true, false  |
| https.server.x509.\*   | -       | Server certificate (x509 fields) | -                                     |              |

---

## Log Fields

Structured log information.

| Field Name                 | Type    | Description             | Example                             | Valid Values |
| -------------------------- | ------- | ----------------------- | ----------------------------------- | ------------ |
| log.file.path              | keyword | Log file path           | /var/log/syslog                     | string       |
| log.level                  | keyword | Log level               | debug, info, notice, warning, error | string       |
| log.logger                 | keyword | Logger name             | org.elasticsearch.core              | string       |
| log.origin.file.line       | integer | Source file line number | 42                                  | integer      |
| log.origin.file.name       | keyword | Source file name        | App.java                            | string       |
| log.origin.function        | keyword | Source function name    | parseQuery                          | string       |
| log.syslog.facility.code   | long    | Syslog facility code    | 3                                   | integer      |
| log.syslog.facility.name   | keyword | Syslog facility name    | daemon                              | string       |
| log.syslog.hostname        | keyword | Syslog hostname         | -                                   | string       |
| log.syslog.priority        | long    | Syslog priority         | -                                   | integer      |
| log.syslog.procid          | keyword | Syslog process ID       | 1234                                | string       |
| log.syslog.severity.code   | long    | Syslog severity code    | 3                                   | integer      |
| log.syslog.severity.name   | keyword | Syslog severity name    | error                               | string       |
| log.syslog.structured_data | keyword | Syslog structured data  | -                                   | string       |

---

## Network Fields

General network information.

| Field Name              | Type    | Description                | Example                   | Valid Values                                 |
| ----------------------- | ------- | -------------------------- | ------------------------- | -------------------------------------------- |
| network.application     | keyword | Application layer protocol | http, ssh, dns            | string                                       |
| network.bytes           | long    | Total bytes transferred    | 2048                      | integer                                      |
| network.community_id    | keyword | Community ID flow hash     | -                         | string                                       |
| network.direction       | keyword | Network direction          | ingress, egress, internal | ingress, egress, inbound, outbound, internal |
| network.forwarded_ip    | ip      | Forwarded/proxy IP         | 10.1.1.1                  | IPv4 or IPv6 address                         |
| network.iana_number     | keyword | IANA protocol number       | 6 (TCP), 17 (UDP)         | string                                       |
| network.inner.vlan.id   | keyword | Inner VLAN ID              | -                         | string                                       |
| network.inner.vlan.name | keyword | Inner VLAN name            | -                         | string                                       |
| network.name            | keyword | Network name               | Guest                     | string                                       |
| network.packets         | long    | Total packets              | 30                        | integer                                      |
| network.protocol        | keyword | Protocol name              | tcp, udp, icmp            | string                                       |
| network.session_id      | keyword | Network session ID         | -                         | string                                       |
| network.transport       | keyword | Transport layer            | tcp, udp                  | string                                       |
| network.type            | keyword | Network type               | ipv4, ipv6                | string                                       |
| network.vlan.id         | keyword | VLAN ID                    | -                         | string                                       |
| network.vlan.name       | keyword | VLAN name                  | -                         | string                                       |

---

## Observability Fields

Observability/monitoring information.

| Field Name           | Type    | Description                   | Example | Valid Values |
| -------------------- | ------- | ----------------------------- | ------- | ------------ |
| obs.event_name       | keyword | Event name                    | -       | string       |
| obs.span.duration_us | long    | Span duration in microseconds | -       | integer      |

---

## Observer Fields

Information about the entity observing the network/logs.

| Field Name                       | Type      | Description             | Example              | Valid Values         |
| -------------------------------- | --------- | ----------------------- | -------------------- | -------------------- |
| observer.egress.interface.alias  | keyword   | Egress interface alias  | eth0                 | string               |
| observer.egress.interface.name   | keyword   | Egress interface name   | eth0                 | string               |
| observer.egress.vlan.id          | keyword   | Egress VLAN ID          | -                    | string               |
| observer.egress.vlan.name        | keyword   | Egress VLAN name        | -                    | string               |
| observer.egress.zone             | keyword   | Egress zone             | dmz                  | string               |
| observer.geo.city_name           | keyword   | Observer city           | -                    | string               |
| observer.geo.country_iso_code    | keyword   | Observer country ISO    | -                    | string               |
| observer.geo.location            | geo_point | Observer coordinates    | -                    | latitude,longitude   |
| observer.geo.region_name         | keyword   | Observer region         | -                    | string               |
| observer.hostname                | keyword   | Observer hostname       | -                    | string               |
| observer.ingress.interface.alias | keyword   | Ingress interface alias | eth1                 | string               |
| observer.ingress.interface.name  | keyword   | Ingress interface name  | eth1                 | string               |
| observer.ingress.vlan.id         | keyword   | Ingress VLAN ID         | -                    | string               |
| observer.ingress.vlan.name       | keyword   | Ingress VLAN name       | -                    | string               |
| observer.ingress.zone            | keyword   | Ingress zone            | external             | string               |
| observer.ip                      | ip        | Observer IP             | 192.168.1.50         | IPv4 or IPv6 address |
| observer.mac                     | keyword   | Observer MAC            | -                    | string               |
| observer.name                    | keyword   | Observer name           | IDS01                | string               |
| observer.os.name                 | keyword   | Observer OS             | Linux                | string               |
| observer.os.version              | keyword   | Observer OS version     | -                    | string               |
| observer.product                 | keyword   | Observer product        | Snort                | string               |
| observer.serial_number           | keyword   | Observer serial number  | -                    | string               |
| observer.type                    | keyword   | Observer type           | firewall, ids, proxy | string               |
| observer.vendor                  | keyword   | Observer vendor         | Suricata             | string               |
| observer.version                 | keyword   | Observer version        | 1.0.0                | string               |

---

## OS Fields

Operating system information.

| Field Name        | Type    | Description    | Example               | Valid Values |
| ----------------- | ------- | -------------- | --------------------- | ------------ |
| os.family         | keyword | OS family      | windows, linux, macos | string       |
| os.kernel.name    | keyword | Kernel name    | Linux                 | string       |
| os.kernel.version | keyword | Kernel version | 5.4.0                 | string       |
| os.name           | keyword | OS name        | Windows, Linux, macOS | string       |
| os.platform       | keyword | Platform       | windows, linux, macos | string       |
| os.type           | keyword | OS type        | Windows, Linux, etc.  | string       |
| os.version        | keyword | OS version     | 10.0.19041            | string       |

---

## Package Fields

Software package information.

| Field Name            | Type    | Description           | Example              | Valid Values         |
| --------------------- | ------- | --------------------- | -------------------- | -------------------- |
| package.architecture  | keyword | Package architecture  | x86_64, arm64        | string               |
| package.build_scope   | keyword | Build scope           | source, binary       | string               |
| package.checksum      | keyword | Package checksum      | -                    | string               |
| package.description   | keyword | Package description   | Secure Shell Client  | string               |
| package.install_scope | keyword | Install scope         | system, user         | string               |
| package.installed     | date    | Installation date     | 2020-01-01T00:00:00Z | timestamp (ISO 8601) |
| package.license       | keyword | Package license       | MIT, GPL, Apache     | string               |
| package.name          | keyword | Package name          | openssh-client       | string               |
| package.path          | keyword | Package path          | /usr/bin/ssh         | string               |
| package.reference     | keyword | Package reference     | -                    | string               |
| package.release       | keyword | Package release       | 1                    | string               |
| package.size          | long    | Package size in bytes | 1048576              | integer              |
| package.type          | keyword | Package type          | rpm, deb, exe        | string               |
| package.version       | keyword | Package version       | 7.4p1                | string               |

---

## PE (Portable Executable) Fields

Windows Portable Executable format information.

| Field Name            | Type    | Description       | Example               | Valid Values     |
| --------------------- | ------- | ----------------- | --------------------- | ---------------- |
| pe.architecture       | keyword | PE architecture   | x86, x86-64           | string           |
| pe.company            | keyword | Company name      | Microsoft Corporation | string           |
| pe.description        | keyword | File description  | Notepad               | string           |
| pe.file_version       | keyword | File version      | 10.0.19041            | string           |
| pe.imphash            | keyword | Import hash       | -                     | string           |
| pe.original_file_name | keyword | Original filename | notepad.exe           | string           |
| pe.product            | keyword | Product name      | Microsoft Windows     | string           |
| pe.sections           | nested  | PE sections       | -                     | array of objects |

---

## Process Fields

Process execution information.

| Field Name                        | Type         | Description                  | Example                     | Valid Values         |
| --------------------------------- | ------------ | ---------------------------- | --------------------------- | -------------------- |
| process.args                      | keyword      | Array of command arguments   | ["-c", "whoami"]            | string               |
| process.args_count                | long         | Count of arguments           | 2                           | integer              |
| process.call_stack                | nested       | Call stack frames            | -                           | array of objects     |
| process.code_signature.\*         | -            | Code signature fields        | -                           |                      |
| process.command_line              | wildcard     | Full command line            | powershell.exe -enc SGVs... | string (supports \*) |
| process.cpu.pct                   | scaled_float | CPU usage percentage         | 25.5                        | decimal number       |
| process.end                       | date         | Process end time             | 2020-01-01T00:00:01Z        | timestamp (ISO 8601) |
| process.env_vars                  | keyword      | Environment variables        | {"PATH": "/usr/bin"}        | string               |
| process.executable                | keyword      | Executable path              | C:\Windows\System32\cmd.exe | string               |
| process.exit_code                 | long         | Exit/return code             | 0, 1, -1                    | integer              |
| process.group_leader.entity_id    | keyword      | Group leader entity ID       | -                           | string               |
| process.group_leader.pid          | long         | Group leader PID             | -                           | integer              |
| process.group_leader.start        | date         | Group leader start time      | -                           | timestamp (ISO 8601) |
| process.hash.\*                   | keyword      | Process hash values          | md5, sha1, sha256           | string               |
| process.io.max_rss_bytes          | long         | Max resident set size        | -                           | integer              |
| process.io.reads                  | long         | Disk read count              | -                           | integer              |
| process.io.writes                 | long         | Disk write count             | -                           | integer              |
| process.name                      | keyword      | Process name only            | cmd.exe                     | string               |
| process.parent.args               | keyword      | Parent command arguments     | -                           | string               |
| process.parent.args_count         | long         | Parent args count            | -                           | integer              |
| process.parent.code_signature.\*  | -            | Parent code signature        | -                           |                      |
| process.parent.command_line       | wildcard     | Parent command line          | -                           | string (supports \*) |
| process.parent.elf.\*             | -            | Parent ELF fields            | -                           |                      |
| process.parent.end                | date         | Parent end time              | -                           | timestamp (ISO 8601) |
| process.parent.entity_id          | keyword      | Parent entity ID             | -                           | string               |
| process.parent.executable         | keyword      | Parent executable path       | -                           | string               |
| process.parent.exit_code          | long         | Parent exit code             | -                           | integer              |
| process.parent.group_leader.pid   | long         | Parent's group leader PID    | -                           | integer              |
| process.parent.hash.\*            | keyword      | Parent hash values           | -                           | string               |
| process.parent.name               | keyword      | Parent process name          | explorer.exe                | string               |
| process.parent.pe.\*              | -            | Parent PE fields             | -                           |                      |
| process.parent.pgid               | long         | Parent group ID              | -                           | integer              |
| process.parent.pid                | long         | Parent PID                   | 1234                        | integer              |
| process.parent.ppid               | long         | Parent's parent PID          | -                           | integer              |
| process.parent.start              | date         | Parent start time            | 2020-01-01T00:00:00Z        | timestamp (ISO 8601) |
| process.parent.thread.\*          | -            | Parent thread info           | -                           |                      |
| process.parent.title              | keyword      | Parent window title          | -                           | string               |
| process.parent.uptime             | long         | Parent uptime in nanoseconds | -                           | integer              |
| process.parent.vpid               | long         | Virtual parent PID           | -                           | integer              |
| process.parent.working_directory  | keyword      | Parent working directory     | C:\                         | string               |
| process.pe.\*                     | -            | Process PE fields            | -                           |                      |
| process.pgid                      | long         | Process group ID             | -                           | integer              |
| process.pid                       | long         | Process ID                   | 5678                        | integer              |
| process.ppid                      | long         | Parent PID                   | 1234                        | integer              |
| process.previous.args             | keyword      | Previous process arguments   | -                           | string               |
| process.previous.executable       | keyword      | Previous executable          | -                           | string               |
| process.session_leader.entity_id  | keyword      | Session leader entity ID     | -                           | string               |
| process.session_leader.pid        | long         | Session leader PID           | -                           | integer              |
| process.session_leader.start      | date         | Session leader start time    | -                           | timestamp (ISO 8601) |
| process.start                     | date         | Process start time           | 2020-01-01T00:00:00Z        | timestamp (ISO 8601) |
| process.target.args               | keyword      | Target process arguments     | -                           | string               |
| process.target.command_line       | wildcard     | Target process command line  | -                           | string (supports \*) |
| process.target.executable         | keyword      | Target executable            | -                           | string               |
| process.target.name               | keyword      | Target process name          | lsass.exe                   | string               |
| process.target.pid                | long         | Target PID                   | -                           | integer              |
| process.target.ppid               | long         | Target parent PID            | -                           | integer              |
| process.target.title              | keyword      | Target process title         | -                           | string               |
| process.target.working_directory  | keyword      | Target working directory     | -                           | string               |
| process.thread.capabilities.names | keyword      | Thread capabilities          | -                           | string               |
| process.thread.id                 | long         | Thread ID                    | -                           | integer              |
| process.thread.name               | keyword      | Thread name                  | -                           | string               |
| process.title                     | keyword      | Process window title         | -                           | string               |
| process.uptime                    | long         | Uptime in nanoseconds        | -                           | integer              |
| process.vpid                      | long         | Virtual process ID           | -                           | integer              |
| process.working_directory         | keyword      | Working directory            | C:\Windows                  | string               |

---

## Registry Fields (Windows)

Windows Registry information.

| Field Name            | Type    | Description          | Example                          | Valid Values |
| --------------------- | ------- | -------------------- | -------------------------------- | ------------ |
| registry.data.bytes   | keyword | Binary registry data | -                                | string       |
| registry.data.strings | keyword | String registry data | Value123                         | string       |
| registry.data.type    | keyword | Data type            | REG_SZ, REG_DWORD, REG_BINARY    | string       |
| registry.hive         | keyword | Registry hive        | HKEY_LOCAL_MACHINE               | string       |
| registry.key          | keyword | Registry key         | Software\Microsoft\Windows       | string       |
| registry.path         | keyword | Full registry path   | HKLM:\Software\Microsoft\Windows | string       |
| registry.value        | keyword | Registry value name  | Version                          | string       |

---

## Server Fields

Server information (similar to client but for server side).

| Field Name                  | Type    | Description              | Example     | Valid Values         |
| --------------------------- | ------- | ------------------------ | ----------- | -------------------- |
| server.address              | keyword | Server address           | -           | string               |
| server.as.number            | long    | Server ASN               | -           | integer              |
| server.as.organization.name | keyword | Server AS organization   | -           | string               |
| server.bytes                | long    | Bytes sent to client     | -           | integer              |
| server.domain               | keyword | Server domain            | example.com | string               |
| server.geo.\*               | -       | Server geolocation       | -           |                      |
| server.ip                   | ip      | Server IP                | -           | IPv4 or IPv6 address |
| server.mac                  | keyword | Server MAC               | -           | string               |
| server.nat.ip               | ip      | Server NAT IP            | -           | IPv4 or IPv6 address |
| server.nat.port             | long    | Server NAT port          | -           | integer              |
| server.packets              | long    | Packets sent to client   | -           | integer              |
| server.port                 | long    | Server port              | 443         | integer              |
| server.registered_domain    | keyword | Server registered domain | -           | string               |
| server.subdomain            | keyword | Server subdomain         | -           | string               |
| server.top_level_domain     | keyword | Server TLD               | -           | string               |
| server.user.\*              | -       | Server user fields       | -           |                      |

---

## Service Fields

Service/application information.

| Field Name           | Type    | Description          | Example                | Valid Values |
| -------------------- | ------- | -------------------- | ---------------------- | ------------ |
| service.address      | keyword | Service address      | -                      | string       |
| service.environment  | keyword | Service environment  | production             | string       |
| service.ephemeral_id | keyword | Service ephemeral ID | -                      | string       |
| service.id           | keyword | Service ID           | -                      | string       |
| service.name         | keyword | Service name         | web-server             | string       |
| service.node.name    | keyword | Service node name    | -                      | string       |
| service.state        | keyword | Service state        | running, stopped       | string       |
| service.type         | keyword | Service type         | database, cache, queue | string       |
| service.version      | keyword | Service version      | 1.0.0                  | string       |

---

## Source Fields

Source network information (detailed list similar to destination).

| Field Name                  | Type    | Description              | Example            | Valid Values         |
| --------------------------- | ------- | ------------------------ | ------------------ | -------------------- |
| source.address              | keyword | Raw source address       | 192.168.1.1        | string               |
| source.as.number            | long    | Source ASN               | 12345              | integer              |
| source.as.organization.name | keyword | Source AS organization   | ISP Company        | string               |
| source.bytes                | long    | Bytes sent from source   | 1024               | integer              |
| source.domain               | keyword | Source domain            | client.example.com | string               |
| source.geo.\*               | -       | Source geolocation       | -                  |                      |
| source.ip                   | ip      | Source IP address        | 192.168.1.1        | IPv4 or IPv6 address |
| source.mac                  | keyword | Source MAC               | 00:11:22:33:44:55  | string               |
| source.nat.ip               | ip      | Source NAT IP            | -                  | IPv4 or IPv6 address |
| source.nat.port             | long    | Source NAT port          | -                  | integer              |
| source.packets              | long    | Packets from source      | 15                 | integer              |
| source.port                 | long    | Source port              | 54321              | integer              |
| source.registered_domain    | keyword | Source registered domain | -                  | string               |
| source.subdomain            | keyword | Source subdomain         | -                  | string               |
| source.top_level_domain     | keyword | Source TLD               | -                  | string               |
| source.user.\*              | -       | Source user fields       | -                  |                      |

---

## Threat Fields

Threat intelligence and indicators.

| Field Name                              | Type    | Description              | Example                     | Valid Values         |
| --------------------------------------- | ------- | ------------------------ | --------------------------- | -------------------- |
| threat.framework                        | keyword | Framework                | MITRE ATT&CK                | string               |
| threat.group.alias                      | keyword | Threat group alias       | -                           | string               |
| threat.group.id                         | keyword | Threat group ID          | G0001                       | string               |
| threat.group.name                       | keyword | Threat group name        | APT1                        | string               |
| threat.group.reference                  | keyword | Threat group reference   | -                           | string               |
| threat.indicator.as.number              | long    | Indicator ASN            | -                           | integer              |
| threat.indicator.as.organization.name   | keyword | Indicator AS org         | -                           | string               |
| threat.indicator.confidence             | keyword | Indicator confidence     | high, medium, low           | string               |
| threat.indicator.description            | keyword | Indicator description    | -                           | string               |
| threat.indicator.email.address          | keyword | Email indicator          | attacker@evil.com           | string               |
| threat.indicator.file.hash.\*           | keyword | File hash indicator      | -                           | string               |
| threat.indicator.file.name              | keyword | File name indicator      | malware.exe                 | string               |
| threat.indicator.file.size              | long    | File size indicator      | -                           | integer              |
| threat.indicator.file.type              | keyword | File type indicator      | -                           | string               |
| threat.indicator.first_seen             | date    | First seen timestamp     | 2020-01-01T00:00:00Z        | timestamp (ISO 8601) |
| threat.indicator.geo.\*                 | -       | Indicator geolocation    | -                           |                      |
| threat.indicator.ip                     | ip      | IP indicator             | 1.2.3.4                     | IPv4 or IPv6 address |
| threat.indicator.ipv6                   | ip      | IPv6 indicator           | -                           | IPv4 or IPv6 address |
| threat.indicator.last_seen              | date    | Last seen timestamp      | 2020-12-31T23:59:59Z        | timestamp (ISO 8601) |
| threat.indicator.marking.tlp            | keyword | TLP marking              | WHITE, GREEN, AMBER, RED    | string               |
| threat.indicator.name                   | keyword | Indicator name           | -                           | string               |
| threat.indicator.port                   | long    | Port indicator           | 8080                        | integer              |
| threat.indicator.provider               | keyword | Indicator provider       | -                           | string               |
| threat.indicator.reference              | keyword | Indicator reference      | -                           | string               |
| threat.indicator.registry.hive          | keyword | Registry hive indicator  | -                           | string               |
| threat.indicator.registry.key           | keyword | Registry key indicator   | -                           | string               |
| threat.indicator.registry.path          | keyword | Registry path indicator  | -                           | string               |
| threat.indicator.registry.value         | keyword | Registry value indicator | -                           | string               |
| threat.indicator.scanner_stats          | object  | Scanner statistics       | -                           | JSON object          |
| threat.indicator.sightings              | long    | Number of sightings      | 10                          | integer              |
| threat.indicator.type                   | keyword | Indicator type           | ipv4-addr, domain-name, url | string               |
| threat.indicator.url.domain             | keyword | URL domain indicator     | -                           | string               |
| threat.indicator.url.full               | keyword | Full URL indicator       | -                           | string               |
| threat.indicator.url.original           | keyword | Original URL indicator   | -                           | string               |
| threat.indicator.url.path               | keyword | URL path indicator       | -                           | string               |
| threat.indicator.url.port               | long    | URL port indicator       | -                           | integer              |
| threat.indicator.url.scheme             | keyword | URL scheme indicator     | http, https                 | string               |
| threat.indicator.whois.date             | date    | WHOIS date               | -                           | timestamp (ISO 8601) |
| threat.indicator.windows.filetype       | keyword | Windows file type        | -                           | string               |
| threat.intel.feed.description           | keyword | Feed description         | -                           | string               |
| threat.intel.feed.name                  | keyword | Feed name                | Custom Intel Feed           | string               |
| threat.intel.feeds                      | keyword | List of feeds            | -                           | string               |
| threat.tactic.id                        | keyword | Tactic ID                | TA0001                      | string               |
| threat.tactic.name                      | keyword | Tactic name              | Reconnaissance              | string               |
| threat.tactic.reference                 | keyword | Tactic reference         | -                           | string               |
| threat.technique.id                     | keyword | Technique ID             | T1087                       | string               |
| threat.technique.name                   | keyword | Technique name           | Account Discovery           | string               |
| threat.technique.reference              | keyword | Technique reference      | -                           | string               |
| threat.technique.subtechnique.id        | keyword | Sub-technique ID         | T1087.001                   | string               |
| threat.technique.subtechnique.name      | keyword | Sub-technique name       | Local Account               | string               |
| threat.technique.subtechnique.reference | keyword | Sub-technique reference  | -                           | string               |

---

## TLS Fields

Transport Layer Security/SSL information.

| Field Name                   | Type    | Description                    | Example                               | Valid Values         |
| ---------------------------- | ------- | ------------------------------ | ------------------------------------- | -------------------- |
| tls.cipher                   | keyword | Cipher suite                   | TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 | string               |
| tls.client.certificate       | keyword | Client certificate             | -                                     | string               |
| tls.client.certificate_chain | keyword | Client certificate chain       | -                                     | string               |
| tls.client.hash.md5          | keyword | Client cert MD5                | -                                     | string               |
| tls.client.hash.sha1         | keyword | Client cert SHA1               | -                                     | string               |
| tls.client.hash.sha256       | keyword | Client cert SHA256             | -                                     | string               |
| tls.client.issuer            | keyword | Client cert issuer             | -                                     | string               |
| tls.client.ja3               | keyword | Client JA3 fingerprint         | -                                     | string               |
| tls.client.not_after         | date    | Client cert expiry             | 2025-01-01T00:00:00Z                  | timestamp (ISO 8601) |
| tls.client.not_before        | date    | Client cert start              | 2020-01-01T00:00:00Z                  | timestamp (ISO 8601) |
| tls.client.server_name       | keyword | SNI server name                | example.com                           | string               |
| tls.client.subject           | keyword | Client cert subject            | -                                     | string               |
| tls.client.supported_ciphers | keyword | Client supported ciphers       | -                                     | string               |
| tls.client.x509.\*           | -       | Client x509 certificate fields | -                                     |                      |
| tls.curve                    | keyword | Elliptic curve                 | P-256                                 | string               |
| tls.established              | boolean | TLS connection established     | true                                  | true, false          |
| tls.ja3                      | keyword | JA3 fingerprint                | -                                     | string               |
| tls.ja3s                     | keyword | JA3S fingerprint               | -                                     | string               |
| tls.next_protocol            | keyword | ALPN protocol                  | h2, http/1.1                          | string               |
| tls.protocol                 | keyword | TLS protocol version           | TLSv1.2, TLSv1.3                      | string               |
| tls.protocol_version         | keyword | Protocol version               | 1.2, 1.3                              | string               |
| tls.resumed                  | boolean | Session resumed                | false                                 | true, false          |
| tls.server.certificate       | keyword | Server certificate             | -                                     | string               |
| tls.server.certificate_chain | keyword | Server certificate chain       | -                                     | string               |
| tls.server.hash.md5          | keyword | Server cert MD5                | -                                     | string               |
| tls.server.hash.sha1         | keyword | Server cert SHA1               | -                                     | string               |
| tls.server.hash.sha256       | keyword | Server cert SHA256             | -                                     | string               |
| tls.server.issuer            | keyword | Server cert issuer             | Example CA                            | string               |
| tls.server.ja3s              | keyword | Server JA3S fingerprint        | -                                     | string               |
| tls.server.not_after         | date    | Server cert expiry             | 2025-01-01T00:00:00Z                  | timestamp (ISO 8601) |
| tls.server.not_before        | date    | Server cert start              | 2020-01-01T00:00:00Z                  | timestamp (ISO 8601) |
| tls.server.subject           | keyword | Server cert subject            | example.com                           | string               |
| tls.server.x509.\*           | -       | Server x509 certificate fields | -                                     |                      |
| tls.version                  | keyword | TLS version                    | 1.2, 1.3                              | string               |
| tls.version_protocol         | keyword | Version protocol               | TLSv1.2                               | string               |

---

## URL Fields

URL/URI information.

| Field Name            | Type     | Description                         | Example                      | Valid Values         |
| --------------------- | -------- | ----------------------------------- | ---------------------------- | -------------------- |
| url.domain            | keyword  | Domain from URL                     | example.com                  | string               |
| url.extension         | keyword  | URL file extension                  | pdf, html                    | string               |
| url.fragment          | keyword  | URL fragment (#)                    | section1                     | string               |
| url.full              | wildcard | Complete URL                        | https://example.com/path?q=1 | string (supports \*) |
| url.original          | wildcard | Original URL (before normalization) | -                            | string (supports \*) |
| url.password          | keyword  | URL password                        | -                            | string               |
| url.path              | wildcard | URL path                            | /path/to/page                | string (supports \*) |
| url.port              | long     | URL port                            | 443                          | integer              |
| url.query             | wildcard | URL query string                    | q=search&lang=en             | string (supports \*) |
| url.registered_domain | keyword  | Registered domain                   | example.com                  | string               |
| url.scheme            | keyword  | URL scheme                          | http, https, ftp             | string               |
| url.subdomain         | keyword  | URL subdomain                       | www                          | string               |
| url.top_level_domain  | keyword  | URL TLD                             | com                          | string               |
| url.username          | keyword  | URL username                        | user                         | string               |

---

## User Fields

User/account information.

| Field Name                  | Type    | Description            | Example                                        | Valid Values |
| --------------------------- | ------- | ---------------------- | ---------------------------------------------- | ------------ |
| user.change.domain          | keyword | Changed to domain      | DOMAIN                                         | string       |
| user.change.email           | keyword | Changed to email       | user@example.com                               | string       |
| user.change.full_name       | keyword | Changed to full name   | -                                              | string       |
| user.change.name            | keyword | Changed to username    | newuser                                        | string       |
| user.domain                 | keyword | User domain            | DOMAIN                                         | string       |
| user.effective.domain       | keyword | Effective user domain  | -                                              | string       |
| user.effective.email        | keyword | Effective user email   | -                                              | string       |
| user.effective.full_name    | keyword | Effective full name    | -                                              | string       |
| user.effective.group.domain | keyword | Effective group domain | -                                              | string       |
| user.effective.group.id     | keyword | Effective group ID     | -                                              | string       |
| user.effective.group.name   | keyword | Effective group name   | -                                              | string       |
| user.effective.id           | keyword | Effective user ID      | -                                              | string       |
| user.effective.name         | keyword | Effective username     | -                                              | string       |
| user.email                  | keyword | User email             | user@example.com                               | string       |
| user.full_name              | keyword | User full name         | John Doe                                       | string       |
| user.group.domain           | keyword | Group domain           | -                                              | string       |
| user.group.id               | keyword | Group ID/SID           | S-1-5-32-545                                   | string       |
| user.group.name             | keyword | Group name             | Users                                          | string       |
| user.hash                   | keyword | User hash              | -                                              | string       |
| user.id                     | keyword | User ID/SID            | S-1-5-21-0000000000-1111111111-1111111111-1001 | string       |
| user.name                   | keyword | Username               | john                                           | string       |
| user.name.text              | text    | Username (text field)  | -                                              | string       |
| user.privileged             | boolean | Privileged account     | false                                          | true, false  |
| user.risk.calculated_level  | keyword | Risk level             | critical, high, medium, low                    | string       |
| user.risk.static_level      | keyword | Static risk level      | -                                              | string       |
| user.roles                  | keyword | User roles             | admin, user                                    | string       |
| user.target.domain          | keyword | Target user domain     | -                                              | string       |
| user.target.email           | keyword | Target user email      | -                                              | string       |
| user.target.full_name       | keyword | Target user full name  | -                                              | string       |
| user.target.group.domain    | keyword | Target group domain    | -                                              | string       |
| user.target.group.id        | keyword | Target group ID        | -                                              | string       |
| user.target.group.name      | keyword | Target group name      | -                                              | string       |
| user.target.id              | keyword | Target user ID         | -                                              | string       |
| user.target.name            | keyword | Target username        | -                                              | string       |

---

## Vulnerability Fields

Vulnerability/CVE information.

| Field Name                              | Type    | Description              | Example                     | Valid Values   |
| --------------------------------------- | ------- | ------------------------ | --------------------------- | -------------- |
| vulnerability.category                  | keyword | Vulnerability category   | -                           | string         |
| vulnerability.classification            | keyword | Classification           | -                           | string         |
| vulnerability.cvss_v2.base_score        | float   | CVSSv2 score             | 7.5                         | decimal number |
| vulnerability.cvss_v2.vector_string     | keyword | CVSSv2 vector            | -                           | string         |
| vulnerability.cvss_v3.base_score        | float   | CVSSv3 score             | 8.6                         | decimal number |
| vulnerability.cvss_v3.base_severity     | keyword | CVSSv3 severity          | Critical                    | string         |
| vulnerability.cvss_v3.temporal_score    | float   | CVSSv3 temporal          | -                           | decimal number |
| vulnerability.cvss_v3.temporal_severity | keyword | CVSSv3 temporal severity | -                           | string         |
| vulnerability.cvss_v3.vector_string     | keyword | CVSSv3 vector            | -                           | string         |
| vulnerability.cwe                       | keyword | CWE ID                   | CWE-79                      | string         |
| vulnerability.enumeration               | keyword | Enumeration type         | CVE, CWE, CAPEC             | string         |
| vulnerability.id                        | keyword | Vulnerability ID         | CVE-2020-1234               | string         |
| vulnerability.reference                 | keyword | Reference URL            | -                           | string         |
| vulnerability.report_id                 | keyword | Report ID                | 20191018.0001               | string         |
| vulnerability.scanner.vendor            | keyword | Scanner vendor           | Tenable                     | string         |
| vulnerability.score.base                | float   | Base score               | 5.5                         | decimal number |
| vulnerability.score.environmental       | float   | Environmental score      | 5.5                         | decimal number |
| vulnerability.score.temporal            | float   | Temporal score           | -                           | decimal number |
| vulnerability.score.version             | keyword | CVSS version             | 2.0, 3.0                    | string         |
| vulnerability.severity                  | keyword | Severity                 | Critical, High, Medium, Low | string         |

---

## X.509 Certificate Fields

X.509 digital certificate information.

| Field Name                       | Type    | Description               | Example                   | Valid Values         |
| -------------------------------- | ------- | ------------------------- | ------------------------- | -------------------- |
| x509.alternative_names           | keyword | Subject alternative names | \*.elastic.co             | string               |
| x509.issuer.common_name          | keyword | Issuer CN                 | Example SHA2 CA           | string               |
| x509.issuer.country              | keyword | Issuer country            | US                        | string               |
| x509.issuer.distinguished_name   | keyword | Issuer DN                 | C=US,O=Example Inc        | string               |
| x509.issuer.locality             | keyword | Issuer locality           | Mountain View             | string               |
| x509.issuer.organization         | keyword | Issuer organization       | Example Inc               | string               |
| x509.issuer.organizational_unit  | keyword | Issuer OU                 | www.example.com           | string               |
| x509.issuer.state_or_province    | keyword | Issuer state              | California                | string               |
| x509.not_after                   | date    | Certificate expiry        | 2025-01-01T00:00:00Z      | timestamp (ISO 8601) |
| x509.not_before                  | date    | Certificate start         | 2020-01-01T00:00:00Z      | timestamp (ISO 8601) |
| x509.public_key_algorithm        | keyword | Public key algorithm      | RSA                       | string               |
| x509.public_key_curve            | keyword | Curve name                | nistp521                  | string               |
| x509.public_key_exponent         | long    | Public key exponent       | 65537                     | integer              |
| x509.public_key_size             | long    | Key size in bits          | 2048                      | integer              |
| x509.serial_number               | keyword | Serial number             | 55FBB9C7DEBF09809D12CCAA  | string               |
| x509.signature_algorithm         | keyword | Signature algorithm       | SHA256-RSA                | string               |
| x509.subject.common_name         | keyword | Subject CN                | shared.global.example.net | string               |
| x509.subject.country             | keyword | Subject country           | US                        | string               |
| x509.subject.distinguished_name  | keyword | Subject DN                | C=US,ST=California        | string               |
| x509.subject.locality            | keyword | Subject locality          | San Francisco             | string               |
| x509.subject.organization        | keyword | Subject organization      | Example Inc               | string               |
| x509.subject.organizational_unit | keyword | Subject OU                | -                         | string               |
| x509.subject.state_or_province   | keyword | Subject state             | California                | string               |
| x509.version_number              | keyword | X.509 version             | 3                         | string               |

---

**END OF ECS 9.4.0 FIELDS REFERENCE**
