## Telephony

### System role
Plays a critical role in supporting comminications across core electronic field monitoring related activities. It is a critical step in the subject breaches process - attempting to make contact with subjects through their Home Monitoring Unit (HMU) in the event of a potential breach.

### People

#### Needs
- Subjects need to be able to contact the monitoring team for any queiries or assistance they may need.
- Monitoring team members need to be able to contact the wider monitoring team to make enquires or queries related to their monitoring activities.
- As part of monitoring breach activities Probation Officers need a mechanism to automatically reach out to Subjects in the event of potential curfew breaches to understand the context in which a breach may have occurred.
- As part of the tag installation activities Field Officers need to confirm that Home Monitoring Unit (HMU) is installed correctly and the communication can be established between the HMU and the call center.
- In the event of a potential curfew breach Call Center Operators need Subject details to provide context to any Subject communications and to the provide call outcome in relation to the Subject.

#### Impacts
- Subjects have a direct line to the monitoring team to help facilitate any communications around their individual monitoring activities and requirements.
- Subjects can be reached by calling the HMU assigned to them.
- Monitoring team members can contact the call center to make enquires and queries related to monitoring activities.
- Field officers can ensure that HMUs have been installed correctly and are ready for use.
- Phone Operators have the context required to effectively process potential curfew breach calls with Subjects.

### Current System

#### Interactions
The following Context diagram shows the high level interactions between the Telephony Service, Integrity, Subjects, EM Team members and the HMU Device.
![Telephony System Context Diagram](embed:TelephonyContext)

#### Dependancies (C4 - Deployment diagram with supplier colouring)
Capita consume
G4S & Ring Central supply
Call center office
Home office working (confirm if this option is currently used - there may be support in the future but what is currently in place?)
Integrity (Dynamics 365)

### Key Contacts
[Tech Refresh Contacts](https://justiceuk-my.sharepoint.com/:x:/r/personal/david_cope1_justice_gov_uk/Documents/Microsoft%20Teams%20Chat%20Files/Key%20contacts%20list%20-%20EM%20Change%20tech%20refresh%20projects.xlsx?d=w74ff8db60f9d45c9b10d8ed768f5885d&csf=1&web=1&e=1sPYfT)

#### SLA's
- 6 seconds from call recieved (to confirm) to subject information display

#### Key Dates / Milestones
[Telephony Tranche Dates](https://justiceuk.sharepoint.com/:x:/r/sites/EMExpansionProgrammeteam/Shared%20Documents/03.%20Business%20Change%20and%20Stakeholder%20Management/Telephony/Tranche%20Dates%200911.xlsx?d=w38c58d9b856045f6b4bf8db8ff265b83&csf=1&web=1&e=W2wcRy)

#### Service History
##### Significant Changes
Before the Tech Refresh programme the Telephony service was not subject to any major changes since its inception. The Telephony service was completely replaced during the Tech Refresh program following an 'as is' approach in order to stablise the service and to scale in line with demand. The new system, provided by Ring Central is cloud-based and additional capacity can be added to the system as and when required.

##### Changes in response to quality attributes
The major driver behind the telephony project was scalability. The existing system was struggling to cope with the volume of calls and would exceed its maximum capacity before the end of 2023 based on growth projections around the number of Subjects being monitored. 
Additionally the hardware and software that made up the existing Telephony service no longer had manufacture support and user access control is sub-standard and did not follow the least privileged access model with some user having more priveledges than they require for their role.

##### Commercial changes
The most significant commercial change came as part of the Tech Refresh project. G4S contracted RingCentral to provide the telephony communications platform.

#### System Components (C4 - Container Diagram)
![Telephony System Component Diagram](embed:TelephonyFuturePartDContainer)

### Expansion plans

#### Drivers
Scalability, supportability and security are the main drivers behind current expansion plans.

#### Supplier relations
G4S previously struggled with technical challenges around client network and are currently struggling with estimations and troubleshooting issues which is resulting in slipping timelines.
Both Capita and G4S are defensive but for different reasons, Capita have lost condifence in G4S, are now wary of changes G4S make and are alert to potential issues. G4S are keen to show that they can deliver but even with support, timelines are slipping.
More recently, specifically after the successful release of tranche two the confidence Capita have in G4S has sharply and somewhat suspiciously risen - an employee on Capita who used to be part of the core Telephony team at G4S is suddenly singing the praises of the G4S team.