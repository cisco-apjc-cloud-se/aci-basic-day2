# ACI Day 2 Automation with Terraform Cloud for Business and Intersight Service for Terraform
Keywords: ACI, Terraform, IST, IaC, Day 2

## Overview
This example focuses on automating common Day 2 services typically configured under the Tenant tab in the ACI GUI.  

This includes the management of:
* Tenants
* VRFs
  * Optional Preferred Group security enforcement model
* Bridge Domains (BD)
  * Optional L3 Subnets & Distributed Gateways
* Application Profiles
  * Endpoint Groups (EPGs)
    * Optional static server or network interface mapping (Static EPGs)
    * Optional dynamic VMM integration with VMware to create port group automatically (Dynamic EPGs)
  * Optional New Endpoint Security Groups (ESGs) mapped to one or more EPGs (ACI 5.2 Required)
  * Optional Preferred Group security
* Optional L3Outs
  * OSPF Peering
  * External Endpoint Groups (External Users Groups or Applications)
  * Optional Preferred Group security
* Optional Contracts & Filters
  * Bound to ESGs and External EPGs

![Logical Topology](/images/logical-topology.png)

In this example, we are using a custom Terraform module and set of input variable files (.auto.tfvars).  Each input variable file represents a customers ACI maturity journey from basic L2 services only to a full application-centric segmentation deployment with Layer 4 filters (ACLs) between applications, tiers & user groups.

**NOTE:** 5 of the 6 input auto.tfvars files are hidden.  To change between stages rename and unhide the required stage file (i.e. remove "." prefix) and hide the current file (i.e. add "." prefix) before executing the Terraform plan.

* Stage 1 - Basic L2 "Network Centric" Deployments
  * Layer 2 only, Layer 3 gateways on external/legacy network devices
  * 1 VLAN == 1 EPG == 1 Bridge Domain

* Stage 2 - Basic L3 Deployment with Preferred Group Enforcement
  * Layer 3 Subnets added to Bridge Domains (with same IP & MAC as HSRP VIP)
  * New L3Out with OSPF to dynamic advertise subnets to upstream network(s)
  * Use of Preferred Group to allow unrestricted traffic between EPG/ESGs and External EPGs (RFC1918 Subnets)

* Stage 3 - Application-Centric Separation
  * Each Application separated by new EPG & ESGs
  * New Dynamic EPGs/VMware Port Groups created for each defined application
  * Preferred Group still used to ensure unrestricted traffic between all ESGs & External EPGs

* Stage 4 - Application Tier Separation
  * Each Application further segemented to tiers (i.e. Web & Database)
  * New Dynamic EPGs/VMware Port Groups created for each defined applications' tiers
  * Preferred Group still used to ensure unrestricted traffic between all ESGs & External EPGs

* Stage 5 - Basic Contract Segmentation
  * Basic Contracts & Filters added to restrict traffic between certain ESGs & External EPGs i.e.
    * Intra-application traffic (i.e Web to Database)
    * External Users to Application traffic (i.e. RFC1918 to Web)
    * Restricted External Users to Application traffic (i.e. DB Admins to DB Servers)
  * Basic IPv4 filter only - i.e. allow any IPv4 traffic between segments
  * Preferred Group enforcement removed

* Stage 6 - Layer 4 Contract Segmentation
  * Fitlers replaced with Layer 4, application specific traffic groups i.e.
    * ICMP
    * MySQL (TCP 3306)
    * SSH (TCP 22)
    * Web (TCP 80, 443, 8080)
    * DNS (UDP/TCP 53)
  * Further Restricted External Users to Application traffic (i.e. Web Admins to Web Servers)
  * Allow Servers' restricted external access to Internet

We will use the Intersight Service for Terraform to provide Terraform Cloud with secure managed API access to traditionally isolated domain managers within the on-premises data center such as the ACI APIC controller(s).  

## Requirements
The Infrastructure-as-Code environment will require the following:
* GitHub Repository for Terraform plans, modules and variable files
* Terraform Cloud for Business account with a workspace associated to the GitHub repository above
* Cisco Intersight (SaaS) platform account with sufficient Advantage licensing
* An Intersight Assist appliance VM connected to the Intersight account above

This example will then use the following on-premise domain managers. These will need to be fully commissioned and a suitable user account provided for Terraform to use for provisioning.
* Cisco ACI APIC controller(s)
* VMware vCenter (Optional for demo VM deployment & configuration)
  See https://github.com/cisco-apjc-cloud-se/aci-basic-day2-vm

![Overview](/images/overview.png)

The ACI module makes the following assumptions:
* The ACI fabric has been fully comissioned
* Interfaces to servers & upstream network devices have been configured & patched
* A Physical domain and associated VLAN pool has been defined under Fabric Access Policies in the APIC GUI
* A VMware Virtual Machine Manager (VMM) domain and associated VLAN pool has been created under Virtual Networking in the APIC GUI

![Physical Topology](/images/topology.png)

## Link to Github Repositories
https://github.com/cisco-apjc-cloud-se/aci-basic-day2
https://github.com/cisco-apjc-cloud-se/aci-basic-day2-vm (For optional Demo VM provisioning)

## Steps to Deploy Use Case
1.	In GitHub, create a new, or clone the example GitHub repository(s)
2.	Customize the examples Terraform files, module and input variables (.auto.tfvars) as required

![GitHub files](/images/github-files.png)

3.	In Intersight, configure a Terraform Cloud target with suitable user account and token

![Intersight target](/images/intersight-target.png)

4.	In Intersight, configure a Terraform Agent target with suitable managed host URLs/IPs.  This list of managed hosts must include the IP addresses for the APIC servers as well as access to common GitHub domains in order to download hosted Terraform providers.

![Intersight agent](/images/intersight-agent.png)

5.	In Terraform Cloud for Business, create a new Terraform Workspace and associate to the GitHub repository.

![TFCB workspace](/images/tfcb-workspace.png)

6.	In Terraform Cloud for Business, configure the workspace to the use the Terraform Agent pool configured from Intersight.

![TFCB agent](/images/tfcb-agent.png)

7.	In Terraform Cloud for Business, configure the necessary user account variables for the APIC servers. Note: These have been configured using TFCB's Variable Set function for sharing variables between workspaces.

![TFCB variables](/images/tfcb-vars.png)

## Execute Deployment
In Terraform Cloud for Business, queue a new plan to trigger the initial deployment.  Any future changes to pushed to the GitHub repository will automatically trigger a new plan deployment.

To swich between stages, simply rename the file with a "." prefix to indicate it is now hidden and then rename the required stage file and remove the "." prefix to make this active input file.

## Results
If successfully executed, the Terraform plan will result in the following configuration for each domain manager.

### Stage 1 - Basic L2 "Network Centric" Deployment
* New Tenants
  * demo-basic-1
  * demo-basic-2
* New VRF
  * vrf-1
* New Bridge Domain
  * bd-303 (i.e. Legacy Bridge Domain for VLAN 303)
  * bd-304 (i.e. Legacy Bridge Domain for VLAN 304)
* New Application Profile & Endpoint Group (EPGs)
  * legacy
    * vl-303 (i.e. VLAN 303)
      * Static Port (Pod-1/Node-102/eth-[eth1/1] VLAN 303)
      * VMware Port Group (demo-basic-1|legacy|vl-303)
    * vl-304 (i.e. VLAN 304)
      * Static Port (Pod-1/Node-102/eth-[eth1/1] VLAN 304)
      * VMware Port Group (demo-basic-1|legacy|vl-304)


![Stage 1 APIC View](/images/stage1-apic.png)
![Stage 1 vCenter View](/images/stage1-vc.png)

### Stage 2 - Basic L3 Deployment with Preferred Group Enforcement
* Modified VRF
  * vrf-1 with Preferred Group enabled
* New Application Profile & Endpoint Security Group (EPGs) with Preferred Group enabled
  * legacy
    * vl-303 (i.e. VLAN 303)
    * vl-304 (i.e. VLAN 304)
* New L3Out with External Endpoint Group (ExtEPGs) with Preferred Group enabled
  * demo-l3out
    * rfc1918
      * 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
  * OSPF NSSA peering to upstream network router

![Stage 2 APIC View](/images/stage2-apic.png)

### Stage 3 - Application-Centric Separation
* New Application Profiles & Endpoint Security Group (EPGs) with Preferred Group enabled
  * app-1
    * app-1
      * VMware Port Group (demo-basic-1|app-1|app-1)
  * app-2
    * app-2
      * VMware Port Group (demo-basic-1|app-2|app-2)
  * app-3
    * app-3
      * VMware Port Group (demo-basic-1|app-3|app-3)
  * app-4
    * app-4
      * VMware Port Group (demo-basic-1|app-4|app-4)

![Stage 3 APIC View](/images/stage3-apic.png)
![Stage 3 vCenter View](/images/stage3-vc.png)

### Stage 4 - Application Tier Separation
* New Application Profiles & Endpoint Security Group (EPGs) with Preferred Group enabled for each Tier
  * app-1
    * web
      * VMware Port Group (demo-basic-1|app-1|web)
    * db
      * VMware Port Group (demo-basic-1|app-1|db)
  * app-2
    * web
      * VMware Port Group (demo-basic-1|app-2|web)
    * db
      * VMware Port Group (demo-basic-1|app-2|db)
  * app-3
    * web
      * VMware Port Group (demo-basic-1|app-3|web)
    * db
      * VMware Port Group (demo-basic-1|app-3|db)
  * app-4
    * web
      * VMware Port Group (demo-basic-1|app-4|web)
    * db
      * VMware Port Group (demo-basic-1|app-4|db)

![Stage 4 APIC View](/images/stage4-apic.png)
![Stage 4 vCenter View](/images/stage4-vc.png)

### Stage 5 - Basic Contract Segmentation
* NEW IPv4 Traffic Filter
  * allow-ipv4
* NEW Contracts
  * appX-web-to-db (i.e. App1->App4)
    * Filters:
      * allow-ipv4
  * rfc1918-to-web
    * Filters:
      * allow-ipv4
  * dbadmins-to-db
    * Filters:
      * allow-ipv4
* Modified Endpoint Security Group (EPGs) with Preferred Group disabled and contracts associated
  * app-X
    * web
      * Consumes Contracts:
        * appX-web-to-db
      * Provides Contracts:
        * rfc1918-to-web
    * db
      * Provides Contracts:
        * appX-web-to-db
        * dbadmins-to-db
* Modified External EPGs with Preferred Group disabled and contracts associated
  * rfc1918
    * Consumed Contracts:
      * rfc1918-to-web
* NEW External EPG for DB Admin users
  * dbadmins
    * 10.67.29.4/32
    * Consumed Contracts:
      * dbadmins-to-db
    * Inherited/Contract Master EPG:
      * rfc1918 (i.e. inherit the security/contracts from this EPG)

![Stage 5 APIC View](/images/stage5-apic.png)

### Stage 6 - Layer 4 Contract Segmentation
* NEW Traffic Filters
  * allow-ssh
  * allow-icmp
  * allow-web
  * allow-mysql
  * allow-dns
* NEW Contract
  * webadmins-to-web
    * Filters:
      * allow-ssh
* Modfied Contracts
  * appX-web-to-db (i.e. App1->App4)
    * Filters:
      * allow-icmp
      * allow-mysql
  * rfc1918-to-web
    * Filters:
      * allow-icmp
      * allow-web
  * dbadmins-to-db
    * Filters:
      * allow-ssh
      * allow-mysql
      * allow-icmp
* Modified Endpoint Security Group (EPGs) with Preferred Group disabled and contracts associated
  * app-X
    * web
      * Provides Contracts:
        * webadmins-to-web
* NEW External EPG for Web Admin users
  * webadmins
    * 10.67.16.241/32
    * Consumed Contracts:
      * webadmins-to-web
    * Inherited/Contract Master EPG:
      * rfc1918 (i.e. inherit the security/contracts from this EPG)

![Stage 6 APIC View](/images/stage6-apic.png)
