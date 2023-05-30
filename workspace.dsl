workspace "Electronic Monitoring" {

    !identifiers hierarchical
    !docs workspace-docs
    !adrs workspace-adrs

    model {
        group "EM Interpreters" {
            emsSysMvp = softwareSystem "EMSys MVP" "Interprets tracking events from GPS location monitoring equipment for 'regular' Subjects." "G4S"
            emsSysSpecials = softwareSystem "EMSys Specials" "Interprets tracking events from GPS location monitoring equipment for 'Specials' cohort." "G4S"
            scramnet = softwareSystem "Scramnet" "Interprets events recieved from Alcohol monitoring tags." "Capita"
            atvProcessor = softwareSystem "ATV Processor" "Interprets Curfew alerts from RF and GPS tags forwarding them to the Integrity System." "G4S"
            buddiEagle = softwareSystem "Buddi Eagle" "Interprets Non Fitted Device (NFD) events forwarding breaches to the Integrity System." "Capita"
        }

        integritySystem = softwareSystem "Integrity" "Provides workflows to manage monitoring activities" "G4S" {
            hmuCallbackTrigger = container "HMU Call Back Trigger Function" "Contains the business logic to communicate with RingCentral and invoke a callback request" "AWS Lambda" "G4S"
            predictiveDialerTrigger = container "Predictive Dialler Trigger Function" "Contains the business logic to communicate with RingCentral and invoke a predictive dialer request" "AWS Lambda" "G4S"
            installationEventTrigger = container "Installation Event" "Invoked as part of the tag installation process" "Event" "G4S"
            curfewBreachEventTrigger = container "Curfew Breach Event" "Invoked as part of the curfew breach process" "Event" "G4S"
            subjectInformationPopUp = container "Subject Info Pop-up" "Dispahys Subject details during Predictive Dialler calls"
        }

        atriumDocManagement = softwareSystem "Atrium Document Management" "Stores all “documents / records” received by EMS related to either orders or order related requests." "G4S"
        quickAddressSearch = softwareSystem "Quick Address Search" "Provides look-up and validation of address for FMO visits relating to new orders and change of address" "G4S"     
        ringTelephonyService = softwareSystem "Telephony Service (RingCentral)" "Enables voice calls betweeen Subjects and the Monitoring Center as well as supports wider communications across the core EM teams" "RingCentral" {
            hmuCallbackHandler = container "HMU call-back handler" "Contains the business logic to initiate phone calls to HMU's and play the correct pre-recorded message" "" "RingCentral"
            autoDialer = container "Auto dialler" "Contains the business logic to initiate phone calls to HMU's and retrieves Subject information from Integrity" "" "RingCentral"
            eventProcessor = container "Event Processor" "Processes Interactive Voice Responses (IVRs) and forwards call outcomes to Integrity." "" "RingCentral"
            api = container "Engage Voice API" "Allows management of Ring Centrals predictive dialler" "REST API" "RingCentral"
            webhooks = container "Webhook" "Method of receiving notifications about events of interest to an application" "" "RingCentral"
            phoneApp = container "Phone application" "Manages operator phone calls" "App" "RingCentral"
            supervisorApp = container "Supervisor application" "Manages agent skill assignments" "App" "RingCentral"
        }


        group "Citrix Platform B" {
            fieldEquipmentStoresManagement = softwareSystem "Field equipment stores management (FMIS)" "Supply chain management for the provision of EM Tags/Home Monitoring Units, associated parts and tools." "G4S"
            reportWorldOperationReporting = softwareSystem "Report World Operational reporting" "Provision of operational reports to staff/stakeholders needed to perform their day to day tasks. Data Warehouse is used for provision of management information and billing." "G4S"
            taskingWeb = softwareSystem "Tasking Web" "..." "G4S"
        }

        group "Field Monitoring Officer Tablet Applications" {
            webfleet = softwareSystem "Webfleet" "Fleet Management / Fleet vehicle tracker." "Capita"
            subjectIdentification = softwareSystem "Subject Identification (Azure Powerapp)" "Supports Subject ID team if the Subject's identity could not be confirmed on day of visit." "Capita"

            // Confirm if this app is also recieving a new version
            tasking2App = softwareSystem "Tasking 2 App (Azure Powerapp)" "Provides tasking and location tracking for Field Officers and Logistics operations. Schedules people and inventory into discrete jobs for the incoming 'tagging' workload and send details to the relevant FMO." "Civica System"

            amCaseAndAssetManagement = softwareSystem "AM Case & Asset Management (Azure Powerapp)" "Provide asset management functionality for Alcohol Monitoring tags." "Capita"
            formsApp = softwareSystem "Forms App (Azure Powerapp)" "Supports various Field Officers activities." "Capita"
        }

        acquisitiveCrimeMappingTrackerAndOffenderManagement = element "Acquisitive Crime (AC) Mapping Tracker & Offender Management" "EXCEL" "AC dataset from Police; AC match Analysis outcome." "AirBus Resource"
        acquisitiveCrimeMappingService = softwareSystem "Acquisitive Crime (AC) Mapping Service" "Matches AC dataset with GPS location monitoring." "AirBus System"

        tasking2Service = softwareSystem "Tasking 2 Service" "Schedules people and inventory into discrete jobs for the incoming 'tagging' workload and send details to the relevant FMO." "Civica System"
        tasking3Service = softwareSystem "Tasking 3 Service" "Schedules people and inventory into discrete jobs for the incoming 'tagging' workload and send details to the relevant FMO." "Civica System"

        printingService = softwareSystem "Printing Service" "Prints out letters to inform Subjects of breaches" "Capita"
        integritySystem -> printingService "Sends breach information to"        

        tasking2App -> tasking2Service "Gets task information from"
        tasking2App -> tasking3Service "Gets task information from"

        pNomis = softwareSystem "PNomis" "National Offender Management Information System (NOMIS)."
        nDelius = softwareSystem "NDelius" "Probation Case Management System (MOJ system)."
        liquidVoice = softwareSystem "Liquid Voice" "Provides call recording storage and playback"

        g4sDataWarehouse = element "G4S Data Warehouse" "Stores data exports from various external EM systems"
        ssis = element "SSIS ETL" "Extracts, transforms and loads data from G4S data warehouse to the Capita data darehouse"
        capitaDataWarehouse = element "Capita Data Warehouse" "Stores data exports from G4S Data Warehouse"

        ssis -> g4sDataWarehouse "Extracts data from"
        ssis -> capitaDataWarehouse "Loads data into"

        buddiEagle -> integritySystem "Sends breach details to"
        buddiEagle -> g4sDataWarehouse "Data exported to"

        integritySystem -> g4sDataWarehouse "Data exported to"

        group "Electronic Monitoring Devices" {
            curfewDevice = element "Curfew" "Device" "Device that monitors people to ensure they are at a specified location at specified times."
            locationMonitoringDevice = element "Location Monitoring" "Device" "GPS tag that monitors Curfew, Trail, Exclusion & Mandatory attendance monitoring scenarios."
            alcoholMonitoring = element "Alcohol Monitoring (SCRAM)" "Device" "Monitors alcohol consumption through the person's perspiration"
            nfdDevice = element "Not fitted device (NFD)" "Device" "GPS device that monitors location of foreign national offenders."
        }

        subject = person "Subject" "Person being monitored."
        group "Device Wearers" {
            wearerAcquisitiveCrime = person "David - GPS Location Monitoring" "Assigned Location monitoring device for Trial Monitoring."
            wearerAlcoholMonitoring = person "Jack - Alcohol Monitoring" "Assigned SCRAM monitoring device for Alcohol Monitoring."
            wearerCurfewMonitoring = person "Andrew - Radio Frequency" "Assigned Curfew monitoring device."
            wearerImmigrationMonitoring = person "Julie - NFD" "Assigned NFD monitoring device for Immigration Monitoring"
        }

        # EM device and user relationships to/from
        wearerAcquisitiveCrime -> locationMonitoringDevice "Wears"
        wearerAlcoholMonitoring -> alcoholMonitoring "Wears"
        wearerCurfewMonitoring -> curfewDevice "Wears"
        wearerImmigrationMonitoring -> nfdDevice "Wears"

        printingService -> wearerAcquisitiveCrime "Sends breach letter to"
        printingService -> wearerCurfewMonitoring "Sends breach letter to"
        printingService -> wearerAlcoholMonitoring "Sends breach letter to"
        printingService -> wearerImmigrationMonitoring "Sends breach letter to"

        curfewDevice -> atvProcessor "Sends events to"
        locationMonitoringDevice -> emsSysMvp "Sends events to"
        curfewDevice -> atvProcessor "Sends events to"
        locationMonitoringDevice -> emsSysSpecials "Sends events to"
        alcoholMonitoring -> scramnet "Sends events to"
        nfdDevice -> buddiEagle "Sends events to"

        probationOfficer = person "Probation Officer" "Supports individuals during their rehabilitation and protect the public."
        // Needs more information
        probationOfficer -> acquisitiveCrimeMappingService "Uses"
        probationOfficer -> wearerAcquisitiveCrime "Supports"
        probationOfficer -> wearerCurfewMonitoring "Supports"
        probationOfficer -> wearerImmigrationMonitoring "Supports"

        //parliment recommend that the future service provides police with real time access to location monitoring data.
        policeForces = person "Police Forces" "Provides AC dataset."
        policeForces -> acquisitiveCrimeMappingTrackerAndOffenderManagement "Provides AC data to."

        mojCrimeMappingAnalysts = person "MoJ Crime Mapping Analysts (AC Hub Team)" "..."
        mojCrimeMappingAnalysts -> acquisitiveCrimeMappingTrackerAndOffenderManagement "..."

        // Needs more information
        taskingAdmin = person "Tasking Admin / EMS Scheduler" "..."
        taskingAdmin -> tasking2Service "Uses"

        equipmentStoresTeam = person "Equipment Stores Team" "Manages equipment supply chain for the provision of EM tags etc."
        equipmentStoresTeam -> fieldEquipmentStoresManagement "Manages equipment supply chain using"

        // Needs more information
        fieldControlOfficer = person "Field Control Officer" "..." "Capita"
        fieldControlOfficer -> taskingWeb "Uses"

        // Needs more information
        fieldOpsSupport = person "Field Ops Support" "..."
        integritySystem -> fieldOpsSupport "Recieves SMS messages from"

        // Needs more information
        emsBiTeam = person "EMS MI/BI Team" "..."
        emsBiTeam -> reportWorldOperationReporting "Uses"
        integritySystem -> reportWorldOperationReporting "Shares data with" //Confirm!

        probationOfficer -> wearerAlcoholMonitoring "Supports"

        fieldMonitoringOfficer = person "Field Monitoring Officer" "Responsible for fitting tags" "Capita"
        fieldMonitoringOfficer -> amCaseAndAssetManagement "Manages Alchohol Monitoring cases & assets using"
        fieldMonitoringOfficer -> webfleet "Uses"
        fieldMonitoringOfficer -> formsApp "Manages visits, risk assessments, vehicle checks & activies using"
        fieldMonitoringOfficer -> tasking2App "Gets tasks from"
        fieldMonitoringOfficer -> reportWorldOperationReporting "Uses"
        fieldMonitoringOfficer -> subjectIdentification "Creates and updates personal records using"
        fieldMonitoringOfficer -> wearerAcquisitiveCrime "Installs monitoring device"
        fieldMonitoringOfficer -> wearerAlcoholMonitoring "Installs monitoring device"
        fieldMonitoringOfficer -> wearerCurfewMonitoring "Installs monitoring device"
        fieldMonitoringOfficer -> wearerImmigrationMonitoring "Installs monitoring device"
        fieldMonitoringOfficer -> quickAddressSearch "Uses"

        subjectIdTeam = person "Subject Id Team" "Identifies subjects from photographs" "Capita"
        subjectIdTeam -> subjectIdentification "Requests and reviews subject photographs using"

        specialsTeam = person "Specials Team" "Responsible for high risk EM."
        specialsTeam -> emsSysSpecials "Uses"

        monitoringOfficers = person "Monitoring Center Officer"
        monitoringOfficers -> emsSysMvp "Gets breach information from"
        monitoringOfficers -> emsSysSpecials "Gets breach information from"
        monitoringOfficers -> integritySystem "Enters breach information into"

        emsSysMvp -> acquisitiveCrimeMappingService "Sends events to"
        emsSysMvp -> integritySystem "Sends breach events to"
        emsSysSpecials -> integritySystem "Sends breach events to"
        atvProcessor -> integritySystem "Sends breach events to"
        scramnet -> amCaseAndAssetManagement "Sends breach events to"

        integritySystem -> atriumDocManagement "Stores documents in (Breach letters)"

        acquisitiveCrimeMappingTrackerAndOffenderManagement -> acquisitiveCrimeMappingService "Provides data to"

        orderRequestOrigin = element "EM Order Request Origin" "Process kick-off" "Request originate from different government organisations including Courts, Prisons, Probation and Home Office."
        orderRequest = element "EM Order Request" "Document (Word doc/PDF)" "Request form - manually populated"
        orderRequestInbox = element "EM Request Inbox" "Email System" "Shared mailbox owned by the Electronic Monitoring Service"
        electronicMonitoringServiceAdmin = person "Electronic Monitoring Service Admin" "Manually inputs the data for each order request"
        mojMapMaker = softwareSystem "MoJ Map Maker" "Allows for the creation of polygons to highlight map location boundaries to support requests" "Existing System"

        orderRequestOrigin -> orderRequest "Creates"
        orderRequest -> orderRequestInbox "Sent to"
        electronicMonitoringServiceAdmin -> orderRequestInbox "Receives new orders using"
        electronicMonitoringServiceAdmin -> mojMapMaker "Optionally uses"
        electronicMonitoringServiceAdmin -> orderRequest "Processes"
        electronicMonitoringServiceAdmin -> tasking2Service "Administers order fulfillment using"

        hmctsCommonPlatform = softwareSystem "Common Platform" "Allows the police, judiciary, solicitors, barristers and criminal justice agencies to access and edit case information." "Existing System"
        g4sSupplier = element "G4S" "Supplier" "Supplies, fits and monitors EM tags"
        capitaSupplier = element "Capita" "Supplier" "Supplies, fits and monitors EM tags"
        scramnetSupplier = element "Scramnet" "Supplier" "Supplies, fits and monitors EM tags"

        orderRequestInbox -> g4sSupplier "Completed order sent to"
        orderRequestInbox -> capitaSupplier "Completed order sent to"
        orderRequestInbox -> scramnetSupplier "Completed order sent to"

        hmctsCommonPlatform -> g4sSupplier "Completed order sent to"
        hmctsCommonPlatform -> capitaSupplier "Completed order sent to"
        hmctsCommonPlatform -> scramnetSupplier "Completed order sent to"

        // Confirm interactions with other systems
        //ems = softwareSystem "Electronic Monitoring System" // manages equipment breaches -> suppliers inform Responisible officer and then take action - some interface between ems team and probation system but poor/no feedback loop.
        //probationSystem = element "Probation Team" ""

        // Telephony
        telephonyOperator = person "Call Center Operator" "Trained in making and receiving calls in relation to EM" "Capita"
        electronicMonitoringTeamMember = person "EM Team member" "Involved in core EM activities" "Capita"
        hmu = element "Home Monitoring Unit (HMU)" "Device" "Telephone configured to receive and make calls to specific numbers" "G4S"

        fieldControlOfficer -> ringTelephonyService "Makes calls to"
        ringTelephonyService -> fieldControlOfficer "Makes calls to"

        contracts = deploymentEnvironment "Contracts" {
            deploymentNode "G4S" {
                softwareSystemInstance integritySystem
                softwareSystemInstance emsSysSpecials
                softwareSystemInstance emsSysMvp
                softwareSystemInstance atvProcessor
                softwareSystemInstance atriumDocManagement

                softwareSystemInstance taskingWeb

                deploymentNode "Civica" {
                    softwareSystemInstance tasking2Service
                    softwareSystemInstance tasking3Service
                }

                deploymentNode "RingCentral" {
                    softwareSystemInstance ringTelephonyService
                }
            }
            deploymentNode "Capita" {
                softwareSystemInstance formsApp
                softwareSystemInstance scramnet
                softwareSystemInstance Webfleet
                softwareSystemInstance amCaseAndAssetManagement
                softwareSystemInstance subjectIdentification
            }

            deploymentNode "AirBus" {
                softwareSystemInstance acquisitiveCrimeMappingService
            }
        }


        g4sApiService = softwareSystem "G4S API Service" "Responsible for uploading event calls from the telephony database into RingCentral and receiving call outcomes, forwarding them to Integrity" "G4S"


        g4sApiService -> integritySystem "Gets event details from"
        g4sApiService -> integritySystem "Sends call outcomes to" "HTTPS"
        g4sApiService -> ringTelephonyService.api "Pushes call events to" "HTTPS"
        ringTelephonyService.webhooks -> g4sApiService "Sends call outcomes to" "HTTPS"

        //integritySystem -> ringTelephonyService "Makes callback requests to"
        //integritySystem -> ringTelephonyService "Sends curfew breach details to"
        //ringTelephonyService -> integritySystem "Sends call outcomes to & requests Subject info from"
        ringTelephonyService -> hmu "Makes calls to"
        hmu -> ringTelephonyService "Makes calls to"
        electronicMonitoringTeamMember -> ringTelephonyService "Makes calls to"
        //integritySystem.hmuCallbackTrigger -> ringTelephonyService.api "Sends HMU callback requests to" "HTTPS"
        //integritySystem.predictiveDialerTrigger -> ringTelephonyService.api "Sends predictive dialer request to" "HTTPS"
        integritySystem.curfewBreachEventTrigger -> integritySystem.predictiveDialerTrigger "Invokes"
        integritySystem.installationEventTrigger -> integritySystem.hmuCallbackTrigger "Invokes"
        ringTelephonyService.hmuCallbackHandler -> hmu "Auto-dialled outbound pre-recorded calls to"
        ringTelephonyService.autoDialer -> hmu "Auto-dialled outbound calls to"
        ringTelephonyService.eventProcessor -> ringTelephonyService.webhooks "Send event notifications to"

        ringTelephonyService.api -> ringTelephonyService.hmuCallbackHandler "Forwards HMU callback events to"
        ringTelephonyService.api -> ringTelephonyService.autoDialer "Forwards predictive dialler events to"
        ringTelephonyService.autoDialer -> ringTelephonyService.eventProcessor "Sends call information to"
        ringTelephonyService.phoneApp -> ringTelephonyService.eventProcessor "Send call information to"
        //ringTelephonyService.autoDialer -> integritySystem.api "Gets Subject details from" "HTTPS"
        telephonyOperator -> integritySystem.subjectInformationPopUp "Gets contextual information from"
        telephonyOperator -> ringTelephonyService.phoneApp "Uses"
        fieldControlOfficer -> hmu "Installs"
        subject -> hmu "Uses"

        wearerAlcoholMonitoring -> hmu "Uses"
        wearerAcquisitiveCrime -> hmu "Uses"
        wearerCurfewMonitoring -> hmu "Uses"
        wearerImmigrationMonitoring -> hmu "Uses"
        
        
        pdSupervisor = softwareSystem "PD Supervisor" "Provides live call data inclues of Predictive Dialler skills call volumes" "G4S"
        pdSupervisor -> integritySystem "Gets live call data from"

        telephonySupervisor = person "Call Center Supervisor" "Manages call center queues and operators" "Capita"
        telephonySupervisor -> pdSupervisor "Gets live call data from"
        telephonySupervisor -> telephonyOperator "Manages"
        telephonySupervisor -> ringTelephonyService.supervisorApp "Updates operator skills using"


        // 1000ft elements
        group "Contact and Monitoring Center" {
            serviceManagementSystem = softwareSystem "Service Management System" "Supports monitoring operational activites including case management, reporting, correspondance, scheduling etc."
            telephonyService = softwareSystem "Telephony Service" "Enables voice calls betweeen Subjects and the Monitoring Center as well as supports wider communications across the core EM teams"
            monitoringOfficer = person "Monitoring Center Officers" "Supports monitoring operation activities"
            fieldOfficer = person "Field Officer" "Provides on the ground support of monitoring activities including installation of monitoring equipment and subject visits"
        }

        group "Complaince and Technical Equipment Monitoring" {
            deviceEventProcessor = softwareSystem "Device Event Processor" "Handles events and alerts raised by monitoring devices."
            monitoringDevice = element "Monitoring Device" "Device" "Device that provides constent monitoring of a subject."
            homeMonitoringUnit = element "Home Monitoring Unit" "Device" "Telephone configured to receive and make calls to specific numbers"
        }
        
        criminalJusticePartners = person "Criminal Justice Partner" "Monitors, evidences and incentivises compliance with monitoring restrictions (Police, Courts, Probation)"        
        serviceManagementSystem -> telephonyService "Triggers outbound calls"
        serviceManagementSystem -> subject "Sends compliance notifications to"
        telephonyService -> serviceManagementSystem "Provides call outcome details to"
        monitoringOfficer -> serviceManagementSystem "Uses"
        fieldOfficer -> serviceManagementSystem "Uses"
        fieldOfficer -> monitoringDevice "Installs"
        monitoringDevice -> deviceEventProcessor "Send events to"
        deviceEventProcessor -> serviceManagementSystem "Sends potential non-complaince details to"
        specialsTeam -> serviceManagementSystem "Uses"
        probationOfficer -> subject "Supports"
        criminalJusticePartners -> serviceManagementSystem "Requests information from and submits monitoring orders to"
        subject -> monitoringDevice "Is fitted with"
        subject -> telephonyService "Can request assistance using"
        fieldOfficer -> telephonyService "Can request assistance using"
        probationOfficer -> telephonyService "Can request assistance using"
        subject -> homeMonitoringUnit "Uses"
        fieldOfficer -> homeMonitoringUnit "Installs"
        telephonyService -> homeMonitoringUnit "Verifies installation of"
        homeMonitoringUnit -> telephonyService "Makes calls to"
        
    }

    views {
        deployment * contracts
            include *
            autolayout
        }

        

        systemlandscape "SystemLandscape" {
            include orderRequestOrigin
            include orderRequest
            include orderRequestInbox
            include electronicMonitoringServiceAdmin
            include mojMapMaker
            include g4sSupplier
            include capitaSupplier
            include scramnetSupplier
            include hmctsCommonPlatform
            include wearerAcquisitiveCrime
            include wearerCurfewMonitoring
            include wearerAlcoholMonitoring
            include tasking2Service
            include tasking2App
            include subjectIdentification
            include formsApp
            include amCaseAndAssetManagement
            include fieldMonitoringOfficer      
            include emsSysMvp
            include emsSysSpecials
            include scramnet
            include alcoholMonitoring
            include locationMonitoringDevice
            include curfewDevice
            include acquisitiveCrimeMappingService
            include policeForces
            include mojCrimeMappingAnalysts
            include acquisitiveCrimeMappingTrackerAndOffenderManagement
            include probationOfficer
            include integritySystem
            include atvProcessor
            include nfdDevice
            include buddiEagle
            include wearerImmigrationMonitoring
            include monitoringOfficers
            include atriumDocManagement
            include printingService
            include amCaseAndAssetManagement
            include fieldMonitoringOfficer
            include ringTelephonyService
            include telephonyOperator
            include integritySystem
            include hmu
            include g4sApiService
            include telephonySupervisor
            // autolayout
        }

        systemlandscape "SystemLandscape1000ft" {
            include subject
            include serviceManagementSystem
            include telephonyService
            include probationOfficer
            include fieldOfficer
            include deviceEventProcessor
            include subject
            include criminalJusticePartners
            include monitoringOfficer
            include monitoringDevice
            include homeMonitoringUnit

            //autoLayout
        }

        // Needs more information
        systemlandscape "ProcessAnOrder" {
            include orderRequestOrigin
            include orderRequest
            include orderRequestInbox
            include electronicMonitoringServiceAdmin
            include mojMapMaker
            include g4sSupplier
            include capitaSupplier
            include scramnetSupplier
            include hmctsCommonPlatform
            include wearerAcquisitiveCrime
            include wearerCurfewMonitoring
            include wearerAlcoholMonitoring
            include tasking2Service
            include tasking2App
            include subjectIdentification
            include formsApp
            include amCaseAndAssetManagement
            include fieldMonitoringOfficer            
            // autoLayout
        }

        systemlandscape "BreachTrackingToday" {
            include emsSysMvp
            include emsSysSpecials
            include scramnet
            include alcoholMonitoring
            include locationMonitoringDevice
            include curfewDevice
            include wearerAcquisitiveCrime
            include wearerAlcoholMonitoring
            include wearerCurfewMonitoring
            include acquisitiveCrimeMappingService
            include policeForces
            include mojCrimeMappingAnalysts
            include acquisitiveCrimeMappingTrackerAndOffenderManagement
            include probationOfficer
            include integritySystem
            include atvProcessor
            include monitoringOfficers
            include atriumDocManagement
            include printingService
            include amCaseAndAssetManagement
            include fieldMonitoringOfficer
            // autoLayout
        }

        systemlandscape "BreachTrackingFuture" {
            include emsSysMvp
            include emsSysSpecials
            include scramnet
            include alcoholMonitoring
            include locationMonitoringDevice
            include curfewDevice
            include wearerAcquisitiveCrime
            include wearerAlcoholMonitoring
            include wearerCurfewMonitoring
            include acquisitiveCrimeMappingService
            include policeForces
            include mojCrimeMappingAnalysts
            include acquisitiveCrimeMappingTrackerAndOffenderManagement
            include probationOfficer
            include integritySystem
            include atvProcessor
            include nfdDevice
            include buddiEagle
            include wearerImmigrationMonitoring
            include monitoringOfficers
            include atriumDocManagement
            include printingService
            include amCaseAndAssetManagement
            include fieldMonitoringOfficer
            // autoLayout
        }

        systemcontext ringTelephonyService "TelephonyContext" {
            include electronicMonitoringTeamMember
            include ringTelephonyService
            include subject
            include telephonyOperator
            include integritySystem
            include hmu
            include g4sApiService
            include telephonySupervisor
            include fieldControlOfficer
            //autoLayout
        }

        container ringTelephonyService "TelephonyFuturePartDContainer" "The following Context diagram shows the high level interactions between the Telephony Service, Integrity, Subjects, EM Team members and the HMU Device." {
            include ringTelephonyService
            include ringTelephonyService.hmuCallbackHandler
            include ringTelephonyService.autoDialer
            include ringTelephonyService.eventProcessor
            include ringTelephonyService.api
            include ringTelephonyService.webhooks
            include ringTelephonyService.phoneApp
            include ringTelephonyService.supervisorApp

            include integritySystem
            include integritySystem.subjectInformationPopUp

            include g4sApiService
            include subject
            include telephonyOperator
            include fieldControlOfficer
            include hmu
            include pdSupervisor
            include telephonySupervisor
            //autoLayout
        }

        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "G4S" {
                background #000000
                color #ffffff
            }
            element "Capita" {
                background #782ac7
                color #ffffff
            }
            element "Civica System" {
                background #41c72a
                color #ffffff
            }
            element "AirBus System" {
                background #c7982a
                color #ffffff
            }
            element "AirBus Resource" {
                background #ebbb4b
                color #ffffff
            }
            element "RingCentral" {
                background #cf8e2d
                color #ffffff
            }
        }
    }

}
