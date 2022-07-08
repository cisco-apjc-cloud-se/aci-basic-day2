### NOTE: Contract Master EPG must be built first - may require running plan twice

### Tenant Model ###
tenants = {
  ### Tenants ###
  demo-basic-1 = {
    name          = "demo-basic-1"
    use_existing  = false
    description   = "Basic ACI Tenant #1 built from Terraform Cloud"
    ### Application Profiles & End Point Groups ###
    aps = {
      app-1 = {
        ap_name = "app-1"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Separated App #1"
        esgs = {
          web = {
            esg_name        = "web"
            description     = "App #1 Web Tier ESG"
            preferred_group = "exclude"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {
              app1-web-to-db = {
                contract_name = "app1-web-to-db"
              }
              servers-to-internet = {
                contract_name = "servers-to-internet"
              }
            }
            provided_contracts = {
              rfc1918-to-web = {
                contract_name = "rfc1918-to-web"
              }
              webadmins-to-web = {
                contract_name = "webadmins-to-web"
              }
            }
          }
          db = {
            esg_name        = "db"
            description     = "App #1 DB Tier ESG"
            preferred_group = "exclude"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {
              servers-to-internet = {
                contract_name = "servers-to-internet"
              }
            }
            provided_contracts = {
              app1-web-to-db = {
                contract_name = "app1-web-to-db"
              }
              dbadmins-to-db = {
                contract_name = "dbadmins-to-db"
              }
            }
          }
        }
        epgs = {
          web = {
            epg_name = "web"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
            description = "App #1 Web Tier EPG"
            domains = {
              vmm = {
                name = "DVS-VMM"
                type = "vmware"
              }
              phys = {
                name = "LAB-N9348"
                type = "physical"
              }
            }
            mapped_esg = {
              esg_name = "web"
            }
            paths = {}
          }
          db = {
            epg_name = "db"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
            description = "App #1 DB Tier EPG"
            domains = {
              vmm = {
                name = "DVS-VMM"
                type = "vmware"
              }
              phys = {
                name = "LAB-N9348"
                type = "physical"
              }
            }
            mapped_esg = {
              esg_name = "db"
            }
            paths = {}
          }
        }
      }
      app-2 = {
        ap_name = "app-2"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Separated App #2"
        esgs = {
          web = {
            esg_name        = "web"
            description     = "App #2 Web Tier ESG"
            preferred_group = "exclude"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {
              app2-web-to-db = {
                contract_name = "app2-web-to-db"
              }
              servers-to-internet = {
                contract_name = "servers-to-internet"
              }
            }
            provided_contracts = {
              rfc1918-to-web = {
                contract_name = "rfc1918-to-web"
              }
              webadmins-to-web = {
                contract_name = "webadmins-to-web"
              }
            }
          }
          db = {
            esg_name        = "db"
            description     = "App #2 DB Tier ESG"
            preferred_group = "exclude"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {
              servers-to-internet = {
                contract_name = "servers-to-internet"
              }
            }
            provided_contracts = {
              app2-web-to-db = {
                contract_name = "app2-web-to-db"
              }
              dbadmins-to-db = {
                contract_name = "dbadmins-to-db"
              }
            }
          }
        }
        epgs = {
          web = {
            epg_name = "web"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
            description = "App #2 Web Tier EPG"
            domains = {
              vmm = {
                name = "DVS-VMM"
                type = "vmware"
              }
              phys = {
                name = "LAB-N9348"
                type = "physical"
              }
            }
            mapped_esg = {
              esg_name = "web"
            }
            paths = {}
          }
          db = {
            epg_name = "db"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
            description = "App #2 DB Tier EPG"
            domains = {
              vmm = {
                name = "DVS-VMM"
                type = "vmware"
              }
              phys = {
                name = "LAB-N9348"
                type = "physical"
              }
            }
            mapped_esg = {
              esg_name = "db"
            }
            paths = {}
          }
        }
      }
      app-3 = {
        ap_name = "app-3"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Separated App #3"
        esgs = {
          web = {
            esg_name        = "web"
            description     = "App #3 Web Tier ESG"
            preferred_group = "exclude"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {
              app3-web-to-db = {
                contract_name = "app3-web-to-db"
              }
              servers-to-internet = {
                contract_name = "servers-to-internet"
              }
            }
            provided_contracts = {
              rfc1918-to-web = {
                contract_name = "rfc1918-to-web"
              }
              webadmins-to-web = {
                contract_name = "webadmins-to-web"
              }
            }
          }
          db = {
            esg_name        = "db"
            description     = "App #3 DB Tier ESG"
            preferred_group = "exclude"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {
              servers-to-internet = {
                contract_name = "servers-to-internet"
              }
            }
            provided_contracts = {
              app3-web-to-db = {
                contract_name = "app3-web-to-db"
              }
              dbadmins-to-db = {
                contract_name = "dbadmins-to-db"
              }
            }
          }
        }
        epgs = {
          web = {
            epg_name = "web"
            bd = {
              bd_name = "bd-304"       ## Bridge Domain to add EPG to
            }
            description = "App #3 Web Tier EPG"
            domains = {
              vmm = {
                name = "DVS-VMM"
                type = "vmware"
              }
              phys = {
                name = "LAB-N9348"
                type = "physical"
              }
            }
            mapped_esg = {
              esg_name = "web"
            }
            paths = {}
          }
          db = {
            epg_name = "db"
            bd = {
              bd_name = "bd-304"       ## Bridge Domain to add EPG to
            }
            description = "App #3 DB Tier EPG"
            domains = {
              vmm = {
                name = "DVS-VMM"
                type = "vmware"
              }
              phys = {
                name = "LAB-N9348"
                type = "physical"
              }
            }
            mapped_esg = {
              esg_name = "db"
            }
            paths = {}
          }
        }
      }
      app-4 = {
        ap_name = "app-4"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Separated App #4"
        esgs = {
          web = {
            esg_name        = "web"
            description     = "App #4 Web Tier ESG"
            preferred_group = "exclude"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {
              app4-web-to-db = {
                contract_name = "app4-web-to-db"
              }
              servers-to-internet = {
                contract_name = "servers-to-internet"
              }
            }
            provided_contracts = {
              rfc1918-to-web = {
                contract_name = "rfc1918-to-web"
              }
              webadmins-to-web = {
                contract_name = "webadmins-to-web"
              }
            }
          }
          db = {
            esg_name        = "db"
            description     = "App #4 DB Tier ESG"
            preferred_group = "exclude"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {
              servers-to-internet = {
                contract_name = "servers-to-internet"
              }
            }
            provided_contracts = {
              app4-web-to-db = {
                contract_name = "app4-web-to-db"
              }
              dbadmins-to-db = {
                contract_name = "dbadmins-to-db"
              }
            }
          }
        }
        epgs = {
          web = {
            epg_name = "web"
            bd = {
              bd_name = "bd-304"       ## Bridge Domain to add EPG to
            }
            description = "App #4 Web Tier EPG"
            domains = {
              vmm = {
                name = "DVS-VMM"
                type = "vmware"
              }
              phys = {
                name = "LAB-N9348"
                type = "physical"
              }
            }
            mapped_esg = {
              esg_name = "web"
            }
            paths = {}
          }
          db = {
            epg_name = "db"
            bd = {
              bd_name = "bd-304"       ## Bridge Domain to add EPG to
            }
            description = "App #4 DB Tier EPG"
            domains = {
              vmm = {
                name = "DVS-VMM"
                type = "vmware"
              }
              phys = {
                name = "LAB-N9348"
                type = "physical"
              }
            }
            mapped_esg = {
              esg_name = "db"
            }
            paths = {}
          }
        }
      }
    }
    networking = {
      ### VRFs ###
      vrfs = {
        vrf-1 = {
          vrf_name    = "vrf-1"
          description = "VRF #1 for Tenant #1"
          preferred_group = "enabled"
        }
      }
      ### Bridge Domains & L3 Subnets ###
      bds = {
        bd-303 = {
          bd_name     = "bd-303"
          vrf = {
            vrf_name    = "vrf-1"      ## VRF to add BD to
          }
          description = " Bridge Domain for Legacy VLAN 303 in Tenant #1"
          mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
          arp_flood   = "no" ## "yes", "no"
          l3outs      = {
            demo-l3out = {
              l3out_name = "demo-l3out"
              }
            }
          subnets = {
            sub-1 = {
              ip          = "10.66.209.81/28"
              description = "Primary Subnet for BD VLAN 303"
              scope       = ["public"]
              preferred   = "yes"
            }
          }
        }
        bd-304 = {
          bd_name     = "bd-304"
          vrf = {
            vrf_name    = "vrf-1"      ## VRF to add BD to
          }
          description = " Bridge Domain for Legacy VLAN 304 in Tenant #1"
          mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
          arp_flood   = "no" ## "yes", "no"
          l3outs      = {
            demo-l3out = {
              l3out_name = "demo-l3out"
              }
            }
          subnets = {
            sub-1 = {
              ip          = "10.66.209.97/28"
              description = "Primary Subnet for BD VLAN 304"
              scope       = ["public"]
              preferred   = "yes"
            }
          }
        }
        # bd-305 = {
        #   bd_name     = "bd-305"
        #   vrf = {
        #     vrf_name    = "vrf-1"      ## VRF to add BD to
        #   }
        #   description = " Bridge Domain for Legacy VLAN 305 in Tenant #1"
        #   mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
        #   arp_flood   = "yes" ## "yes", "no"
        #   l3outs      = [] ## List of associated L3outs for BD's Subnets
        #   subnets = {}
        # }
        ### STAGE 7 - NEW FIREWALL TRANSIT BRIDGE DOMAIN ###
        fw-int-306 = {
          bd_name     = "fw-int-306"
          vrf = {
            vrf_name    = "vrf-1"      ## VRF to add BD to
          }
          description = " Bridge Domain for Firewall Transit Internal VLAN 306 in Tenant #1"
          mac_address = "00:22:BD:F8:19:FF"  ## Default MAC Address
          arp_flood   = "yes" ## "yes", "no"
          l3outs      = {}
          subnets = {
            sub-1 = {
              ip          = "10.66.209.41/28"
              description = "Primary Subnet for FW Transit VLAN 306"
              scope       = ["public"]
              preferred   = "yes"
            }
          }
        }
      }
      ### Layer3 Outs and External EPGs ###
      l3outs = {
        demo-l3out = {
          l3out_name      = "demo-l3out"
          description     = "Demo L3Out built from Terraform"
          vrf = {
            vrf_name        = "vrf-1"
          }
          l3_domain       = "LAB-N9348"
          bgp_policy = {}
          ospf_policy = {
            enabled     = true
            description = "OSPF Peering to Lab"
            area_cost   = 1
            area_id     = "0.0.0.1"
            area_type   = "nssa"
          }
          logical_node_profiles = {
            lprof-1 = {
              lprof_name  = "demo-l3out"
              description = "Demo L3Out Logical Profile created from Terraform"
              bgp_peers = {}
              nodes = {
                node-1 = {
                  pod = 1
                  leaf_node = 101
                  loopback_ip = "101.1.1.1"
                }
                node-2 = {
                  pod = 1
                  leaf_node = 102
                  loopback_ip = "102.1.1.1"
                }
              }
              interface_profiles = {
                intprof-1 = {
                  intprof_name  = "demo-l3out-intprof"
                  description   = "Demo L3Out Logical Interface Profile created from Terraform"
                  ospf_profile = {
                    enabled = true
                    description = "OSPF Interface Auth and Policy Config"
                    auth_key    = "key"
                    auth_key_id = 255
                    auth_type   = "none"
                    ospf_policy = {}
                  }
                  floating_svis = {}
                  paths = {
                    path-1 = {
                      description     = "Demo L3 SVI Path"
                      path_type       = "ext-svi"
                      ip              = "10.66.209.22/30"
                      vlan_id         = 302
                      interface_type  = "port"
                      port = {
                        pod        = 1
                        node       = 102
                        port_name  = "eth1/1"
                      }
                      vpc = {
                        side_a = {}
                        side_b = {}
                      }
                      bgp_peers = {}
                    }
                  }
                }
              }
            }
          }
          external_epgs = {
            rfc1918 = {
              extepg_name         = "rfc1918"
              description         = "External users in RFC1918 subnets"
              preferred_group     = "exclude"
              consumed_contracts = {
                rfc1918-to-web = {
                  contract_name = "rfc1918-to-web"
                }
              }
              provided_contracts = {}
              contract_master_epgs = {}
              subnets = {
                N-10-0-0-0-8 = {
                  description = "10.0.0.0/8"
                  aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                  ip = "10.0.0.0/8"
                  scope = ["import-security"]
                }
                N-172-16-0-0-12 = {
                  description = "172.16.0.0/12"
                  aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                  ip = "172.16.0.0/12"
                  scope = ["import-security"]
                }
                N-192-168-0-0-16 = {
                  description = "192.168.0.0/16"
                  aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                  ip = "192.168.0.0/16"
                  scope = ["import-security"]
                }
              }
            }
            dbadmins = {
              extepg_name         = "dbadmins"
              description         = "DB Admin Users"
              preferred_group     = "exclude"
              consumed_contracts = {
                dbadmins-to-db = {
                  contract_name = "dbadmins-to-db"
                }
              }
              provided_contracts = {}
              ## NOTE: Contract Master External EPGS MUST ALREADY EXIST - CURRENT NO METHOD TO ENSURE MASTER EXEPG BUILT FIRST
              contract_master_epgs = {
                # demo-l3out = {
                #   l3out_name = "demo-l3out"
                #   extepg_name= "rfc1918"
                # }
              }
              subnets = {
                H-10-67-29-4 = {
                  description = "10.67.29.4/32"
                  aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                  ip = "10.67.29.4/32"
                  scope = ["import-security"]
                }
              }
            }
            ### STAGE 6 - New Web Admin User Group
            webadmins = {
              extepg_name         = "webadmins"
              description         = "Web Admin Users"
              preferred_group     = "exclude"
              consumed_contracts = {
                webadmins-to-web = {
                  contract_name = "webadmins-to-web"
                }
              }
              provided_contracts = {}
              ## NOTE: Contract Master External EPGS MUST ALREADY EXIST - CURRENT NO METHOD TO ENSURE MASTER EXEPG BUILT FIRST
              contract_master_epgs = {
                # rfc1918 = {
                #   l3out_name = "demo-l3out"
                #   extepg_name= "rfc1918"
                # }
              }
              subnets = {
                H-10-67-16-241 = {
                  description = "10.67.16.241/32"
                  aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                  ip = "10.67.16.241/32"
                  scope = ["import-security"]
                }
              }
            }
            ### STAGE 6 - New Internet Server User Group for External Egress Traffic
            internet = {
              extepg_name         = "internet"
              description         = "External Servers"
              preferred_group     = "exclude"
              consumed_contracts = {}
              provided_contracts = {
                servers-to-internet = {
                  contract_name = "servers-to-internet"
                }
              }
              contract_master_epgs = {}
              subnets = {
                N-0-0-0-0 = {
                  description = "0.0.0.0/0"
                  aggregate    = "none" # "import-rtctrl", "export-rtctrl","shared-rtctrl" and "none".
                  ip = "0.0.0.0/0"
                  scope = ["import-security"]
                }
              }
            }
          }
        }
      }
    }
    contracts = {
      standard = {
        ### STAGE 6 - Add Layer 4 Filters to Contracts ###
        app1-web-to-db = {
          contract_name = "app1-web-to-db"
          description   = "Allow all traffic from Web to DB Tier"
          scope         = "tenant" # "global", "tenant", "application-profile" and "context"
          subjects = {
            default = {
              subject_name = "default"
              description = "Default subject"
              filters = {
                allow-icmp = {
                  filter_name = "allow-icmp"
                }
                allow-mysql = {
                  filter_name = "allow-mysql"
                }
              }
              ### STAGE 7 - APPLY SERVICE GRAPH TEMPLATE TO CONTRACT ###
              service_graph = {
                template_name = "inside-one-arm-fw"
                nodes = {
                  fw = {
                    node_name     = "fw"
                    device = {
                      device_name = "ftd-aci-1"
                    }
                    description   = "Service graph instance applied from Terraform"
                    consumer_interface = {
                      type                = "general"
                      conn_name           = "consumer"   # Must match template connection names
                      cluster_interface   = "inside"
                      redirect_policy     = "to-inside-fw"
                      description         = "Consumer side service graph interface"
                      bd = {
                        bd_name     = "fw-int-306"
                      }
                      extepg = {}
                    }
                    provider_interface = {
                      type                = "general"
                      conn_name           = "provider"  # Must match template connection names
                      cluster_interface   = "inside"
                      redirect_policy     = "to-inside-fw"
                      description         = "Provider side service graph interface"
                      bd = {
                        bd_name     = "fw-int-306"
                      }
                      extepg = {}
                    }
                  }
                }
              }
            }
          }
        }
        app2-web-to-db = {
          contract_name = "app2-web-to-db"
          description   = "Allow all traffic from Web to DB Tier"
          scope         = "tenant" # "global", "tenant", "application-profile" and "context"
          subjects = {
            default = {
              subject_name = "default"
              description = "Default subject"
              filters = {
                allow-icmp = {
                  filter_name = "allow-icmp"
                }
                allow-mysql = {
                  filter_name = "allow-mysql"
                }
              }
              service_graph = {
                nodes = {}
              }
            }
          }
        }
        app3-web-to-db = {
          contract_name = "app2-web-to-db"
          description   = "Allow all traffic from Web to DB Tier"
          scope         = "tenant" # "global", "tenant", "application-profile" and "context"
          subjects = {
            default = {
              subject_name = "default"
              description = "Default subject"
              filters = {
                allow-icmp = {
                  filter_name = "allow-icmp"
                }
                allow-mysql = {
                  filter_name = "allow-mysql"
                }
              }
              service_graph = {
                nodes = {}
              }
            }
          }
        }
        app4-web-to-db = {
          contract_name = "app2-web-to-db"
          description   = "Allow all traffic from Web to DB Tier"
          scope         = "tenant" # "global", "tenant", "application-profile" and "context"
          subjects = {
            default = {
              subject_name = "default"
              description = "Default subject"
              filters = {
                allow-icmp = {
                  filter_name = "allow-icmp"
                }
                allow-mysql = {
                  filter_name = "allow-mysql"
                }
              }
              service_graph = {
                nodes = {}
              }
            }
          }
        }
        rfc1918-to-web = {
          contract_name = "rfc1918-to-web"
          description   = "Allow all traffic from External RFC1918 to all App Web Tiers"
          scope         = "tenant" # "global", "tenant", "application-profile" and "context"
          subjects = {
            default = {
              subject_name = "default"
              description = "Default subject"
              filters = {
                allow-icmp = {
                  filter_name = "allow-icmp"
                }
                allow-web = {
                  filter_name = "allow-web"
                }
              }
              service_graph = {
                nodes = {}
              }
            }
          }
        }
        dbadmins-to-db = {
          contract_name = "dbadmins-to-db"
          description   = "Allow all traffic from DB Admins to all App DB Tiers"
          scope         = "tenant" # "global", "tenant", "application-profile" and "context"
          subjects = {
            default = {
              subject_name = "default"
              description = "Default subject"
              filters = {
                allow-icmp = {
                  filter_name = "allow-icmp"
                }
                allow-ssh = {
                  filter_name = "allow-ssh"
                }
                allow-mysql = {
                  filter_name = "allow-mysql"
                }
              }
              service_graph = {
                nodes = {}
              }
            }
          }
        }
        ### STAGE 6 - New Web Admins Contract for SSH Access
        webadmins-to-web = {
          contract_name = "webadmins-to-web"
          description   = "Allow SSH traffic from Web Admins to all App Web Tiers"
          scope         = "tenant" # "global", "tenant", "application-profile" and "context"
          subjects = {
            default = {
              subject_name = "default"
              description = "Default subject"
              filters = {
                allow-ssh = {
                  filter_name = "allow-ssh"
                }
              }
              service_graph = {
                nodes = {}
              }
            }
          }
        }
        ### STAGE 6 - External Traffic Egress
        servers-to-internet = {
          contract_name = "servers-to-internet"
          description   = "Allow limited traffic from all servers to external servers"
          scope         = "tenant" # "global", "tenant", "application-profile" and "context"
          subjects = {
            default = {
              subject_name = "default"
              description = "Default subject"
              filters = {
                allow-dns = {
                  filter_name = "allow-dns"
                }
                allow-ssh = {
                  filter_name = "allow-ssh"
                }
                allow-icmp = {
                  filter_name = "allow-icmp"
                }
                allow-web = {
                  filter_name = "allow-web"
                }
              }
              service_graph = {
                nodes = {}
              }
            }
          }
        }
      }
      filters = {
        ### STAGE 6 - Remove IPv4 Filter ###
        # allow-ipv4 = {
        #   filter_name = "allow-ipv4"
        #   description = "Allow all IPv4 traffic"
        #   entries = {
        #     all-ip = {
        #       name = "all-ip"
        #       description = "Allow all IPv4 traffic"
        #       ether_t       = "ipv4"
        #       d_from_port   = "unspecified"
        #       d_to_port     = "unspecified"
        #       prot          = "unspecified"
        #       s_from_port   = "unspecified"
        #       s_to_port     = "unspecified"
        #     }
        #   }
        # }
        ### STAGE 6 - Add new Layer 4 Filters ###
        allow-icmp = {
          filter_name = "allow-icmp"
          description = "Allow ICMP traffic"
          entries = {
            icmp = {
              name = "icmp"
              description = "Allow ICMP traffic"
              ether_t       = "ipv4"
              d_from_port   = "unspecified"
              d_to_port     = "unspecified"
              prot          = "icmp"
              s_from_port   = "unspecified"
              s_to_port     = "unspecified"
            }
          }
        }
        allow-dns = {
          filter_name = "allow-dns"
          description = "Allow DNS traffic"
          entries = {
            dns-udp = {
              name = "dns-udp"
              description = "Allow ICMP traffic"
              ether_t       = "ipv4"
              d_from_port   = "53"
              d_to_port     = "53"
              prot          = "udp"
              s_from_port   = "unspecified"
              s_to_port     = "unspecified"
            }
            dns-tcp = {
              name = "dns-tcp"
              description = "Allow ICMP traffic"
              ether_t       = "ipv4"
              d_from_port   = "53"
              d_to_port     = "53"
              prot          = "tcp"
              s_from_port   = "unspecified"
              s_to_port     = "unspecified"
            }
          }
        }
        allow-mysql = {
          filter_name = "allow-mysql"
          description = "Allow MySQL TCP 3306 traffic"
          entries = {
            mysql = {
              name = "mysql"
              description = "Allow MySQL TCP 3306 traffic"
              ether_t       = "ipv4"
              d_from_port   = "3306"
              d_to_port     = "3306"
              prot          = "tcp"
              s_from_port   = "unspecified"
              s_to_port     = "unspecified"
            }
          }
        }
        allow-ssh = {
          filter_name = "allow-ssh"
          description = "Allow SSH traffic"
          entries = {
            ssh = {
              name = "ssh"
              description = "Allow SSH traffic"
              ether_t       = "ipv4"
              d_from_port   = "ssh" # 22
              d_to_port     = "ssh" # 22
              prot          = "tcp"
              s_from_port   = "unspecified"
              s_to_port     = "unspecified"
            }
          }
        }
        allow-web = {
          filter_name = "allow-web"
          description = "Allow Web traffic on TCP 80, 443 and 8080"
          entries = {
            http = {
              name = "http"
              description = "Allow HTTP TCP 80 traffic"
              ether_t       = "ipv4"
              d_from_port   = "http" # 80
              d_to_port     = "http" # 80
              prot          = "tcp"
              s_from_port   = "unspecified"
              s_to_port     = "unspecified"
            },
            https = {
              name = "https"
              description = "Allow HTTPS TCP 443 traffic"
              ether_t       = "ipv4"
              d_from_port   = "https" # 443
              d_to_port     = "https" # 443
              prot          = "tcp"
              s_from_port   = "unspecified"
              s_to_port     = "unspecified"
            },
            http-8080 = {
              name = "http-8080"
              description = "Allow HTTP TCP 8080 traffic"
              ether_t       = "ipv4"
              d_from_port   = "8080"
              d_to_port     = "8080"
              prot          = "tcp"
              s_from_port   = "unspecified"
              s_to_port     = "unspecified"
            }
          }
        }
      }
    }
    policies = {
      service_redirect_policies = {
        to-inside-fw = {
          policy_name  = "to-inside-fw"
          description  = "Redirect traffic to FW Inside IP"
          destinations = {
            fw-inside-ip = {
              ip        = "10.66.209.42"
              mac       = "00:50:56:98:AE:2C"
              dest_name = "FTD-ACI-1 Network Adapter #3 INSIDE"
            }
          }
        }
      }
    }
    services = {
      l4-l7 = {
        devices = {
          ftd-aci-1 = {
            device_name      = "ftd-aci-1"
            device_type      = "virtual"
            service_type     = "fw"
            domain = {
              name = "DVS-VMM"
              type = "vmware"
            }
            concrete_devices = {
              ftd-aci-1 = {
                device_name = "ftd-aci-1"
                vmm_controller_name = "MEL-DC4-VC"
                vm_name = "FTD-ACI-1" ## Capitalisation sensitive?
                interfaces = {
                  inside = {
                    interface_name  = "inside"
                    vnic_name       = "Network adapter 3"
                  }
                }
              }
            }
            logical_interfaces = {
              inside = {
                interface_name = "inside"
              }
            }
          }
        }
        service_graph_templates = {
          inside-one-arm-fw = {
            template_name     = "inside-one-arm-fw"
            description       = "One-Arm Firewall Redirect Template"
            ui_template_type  = "ONE_NODE_FW_ROUTED" # (or lower)
            function_nodes = {
              fw = {
                node_name           = "fw"
                description         = "Firewall service node"
                func_template_type  = "FW_ROUTED" # (or lower)
                func_type           = "GoTo"
                managed             = "no"
                routing_mode        = "Redirect"
                sequence_number     = 1
                device = {
                  device_name = "ftd-aci-1"
                }
              }
            }
          }
        }
      }
    }
  }
  demo-basic-2 = {
    name = "demo-basic-2"
    use_existing = false
    description = "Basic ACI Tenant #2 built from Terraform Cloud"
    aps = {}
    networking = {
      vrfs = {}
      bds = {}
      l3outs = {}
    }
    contracts = {
      standard = {}
      filters = {}
    }
    policies = {
      service_redirect_policies = {}
    }
    services = {
      l4-l7 = {
        devices = {}
        service_graph_templates = {}
      }
    }
  }
}
