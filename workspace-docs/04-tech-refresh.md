## Tech Refresh 

### Stakeholders

- Euan Morrison - Project Manager

### History

In 2012 a legacy program "Gemini" aimed to bring in new services to drive EM but ultimately had lots of issues and wouldn't be delivered on time. While this project wasn't delivered despite heavy investment it did help with identifying some of the requirements and opportunities of the future systems to support EM.
Off the back of this a bridge contract was between Capita and G4S. Capita took on responsibiliy for the service and G4S supported the existing systems which is where we are today.

When the decision was made to terminate Gemini some work was undertaken on existing systems to see if they could continue to operate and provide a stable service until 2024 as well as incorporate the expansion targets which are expected to double the service usage. It was discovered that the service had not been maintained but was running and would keep running but there were risks that needed to be mitigitated.

In 2021 a request went out to Capita and G4S to request them how they will update their systems to bring them in line with MoJ standards, this lead to investigating what services could be moved into the cloud.
The quickest and least risky "lift and shift" option was taken vs a more transformational approach.
G4S moved to AWS but Capita would stay on premise and only move some of their services to Azure Cloud.

### Supplier and component breakdown

Capita (has a sub-contractor Civica):
- Replaced on-premise hardware that hosted end user device estate - moved to the cloud
- Future phase to upgrade their exchange version that was originally deffered
- Replaced a number enabling applications "Forms App" and "Subject ID" built in Azure
- Another application called Tasking 2 to be replaced by Tasking 3. Provides scheduling and visit information for the service - sold to MoJ as a lift and shift but it grew due to complexity. Relooked at COTS options but continued with Tasking 3 instead, due to go live around the end of April
- Also making network upgrades to firewall and switches

G4S:
Around 15 projects were suggested (named after precious stones)
- Migrating core services to AWS "Diamond", VMCloud to migrate as is to limit the impact on the services - expensive but lowest risk (YET THIS IS THE MOST UP IN THE AIR PROJECT) an AWS partner "Mobilise" was brought in to support the migration but still struggling to complete the migration, some challenges around capability in that space and capacity given their current workload.
- Various upgrades to existing applications (patching and updating frameworks) some have been descoped, some completed
- Core CRM platform "Copper" rebuild the bespoke elements of the CRM (plugins) and apply patches to the platform and re-host - due to progress into prod in July
- "Ruby" replacement of telephony service with Ring Central as cloud based SaaS product - currently in live phased role out, second phase... - will be integrated with Integrity their CMS
- "Jade" replacement of a service called "EMET" with a COTS product FMIS Asset Track - used by EMS Stores team - going live soon
- Change remote access method for EMSYS specials instance

G4S have a number of MoJ accounts to host their various systems, MoJ manage the accounts, shared networking and logging responsibilities which are agregated into a single bucket.