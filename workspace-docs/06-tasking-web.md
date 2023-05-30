## Tasking Web

### System role
A system to arrange all the logistics of EM order visits, and the source of truth for information about these visits.

### People
- EMS Officers (via tablet/mobile app)
- EMS schedulers/Field Control Officers (via web app)

<!-- #### Needs -->
#### Impacts
- All EM order fullfilment

### Current System
Tasking 3, currently being moved to the cloud, and which replaces Tasking 2.

#### Interactions (C4 - Context Diagram with description)
- Pulls data from Integrity, as the system of record
- Tasking Web component links to Report World, which shows live Integrity reports

#### Dependancies (C4 - Deployment diagram with supplier colouring)
- IBM MQ
- EAI BizTalk middleware

<!-- #### Key Contacts -->

<!-- #### SLA's -->

#### Key Dates / Milestones
- Cutover weekend from Tasking 2 to Tasking 3 on the 23rd of June
- During this weekend, all input will be by email only, while systems are migrated and data validation is performed

#### Service History
##### Significant Changes
- Initial service was Tasking 2, built on Oracle 9
- Civica contracted to replace Tasking 2 with Tasking 3, as best-efforts contract supporting Tasking 2 was too expensive and ineffective.
- Tasking 3 will be in the cloud
<!-- ##### Changes in response to quality attributes -->
<!-- ##### Commercial changes -->

#### System Components (C4 - Container Diagram)
- Tasking 3 web application in Azure
- Tasking 3 tablet/mobile app accessed by Field Monitoring Officers
- Data from Integrity (Microsoft Dynamics CRM) is communicated to/from Tasking 3 via IBM MQ (currently on-prem, moving to AWS as part of Project Diamond)
- IBM MQ is connected to Integrity via BizTalk EAI middleware
- IBM MQ also communicates with Tasking Web, used by Field Control Officers
<!-- ### Expansion plans -->

#### Drivers
- Old system not fit for purpose, too old and only best-efforts support was viable.

<!-- #### Key Milestones -->

<!-- #### Supplier relations -->