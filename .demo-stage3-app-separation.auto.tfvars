### Tenant Model ###
tenants = {
  ### Tenants ###
  common = {
    name = "common"
    use_existing = true
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
  }
  demo-basic-1 = {
    name          = "demo-basic-1"
    use_existing  = false
    description   = "Basic ACI Tenant #1 built from Terraform Cloud"
    ### Application Profiles & End Point Groups ###
    aps = {
      legacy = {
        ap_name = "legacy"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Legacy Network Centric VLANs"
        esgs = {
          legacy-esg = {
            esg_name        = "legacy-esg"
            description     = "Legacy Networks ESG"
            preferred_group = "include"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {}
            provided_contracts = {}
          }
        }
        epgs = {
          vl-303 = {
            epg_name = "vl-303"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
            description = "EPG for VLAN 303"
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
              esg_name = "legacy-esg"
            }
            preferred_group = "include"
            paths = {}
          }
          vl-304 = {
            epg_name = "vl-304"
            bd = {
              bd_name = "bd-304"       ## Bridge Domain to add EPG to
            }
            description = "EPG for VLAN 304"
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
              esg_name = "legacy-esg"
            }
            preferred_group = "include"
            paths = {}
          }
        }
      }
      ### STAGE 3 - New Application-Specific Profiles, ESGs & EPGs ###
      app-1 = {
        ap_name = "app-1"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Separated App #1"
        esgs = {
          app-1 = {
            esg_name        = "app-1"
            description     = "App #1 ESG"
            preferred_group = "include"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {}
            provided_contracts = {}
          }
        }
        epgs = {
          app-1 = {
            epg_name = "app-1"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
            description = "App #1 EPG"
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
              esg_name = "app-1"
            }
            preferred_group = "include"  ## Must be the same as ESG!
            paths = {}
          }
        }
      }
      app-2 = {
        ap_name = "app-2"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Separated App #2"
        esgs = {
          app-2 = {
            esg_name        = "app-2"
            description     = "App #2 ESG"
            preferred_group = "include"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {}
            provided_contracts = {}
          }
        }
        epgs = {
          app-2 = {
            epg_name = "app-2"
            bd = {
              bd_name = "bd-303"       ## Bridge Domain to add EPG to
            }
            description = "App #2 EPG"
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
              esg_name = "app-2"
            }
            preferred_group = "include"  ## Must be the same as ESG!
            paths = {}
          }
        }
      }
      app-3 = {
        ap_name = "app-3"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Separated App #3"
        esgs = {
          app-3 = {
            esg_name        = "app-3"
            description     = "App #3 ESG"
            preferred_group = "include"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {}
            provided_contracts = {}
          }
        }
        epgs = {
          app-3 = {
            epg_name = "app-3"
            bd = {
              bd_name = "bd-304"       ## Bridge Domain to add EPG to
            }
            description = "App #3 EPG"
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
              esg_name = "app-3"
            }
            preferred_group = "include"  ## Must be the same as ESG!
            paths = {}
          }
        }
      }
      app-4 = {
        ap_name = "app-4"
        tenant_name = "demo-basic-1"    ## Tenant to add AP to
        description = "App Profile for Separated App #4"
        esgs = {
          app-4 = {
            esg_name        = "app-4"
            description     = "App #4 ESG"
            preferred_group = "include"
            vrf = {
              vrf_name        = "vrf-1"
            }
            consumed_contracts = {}
            provided_contracts = {}
          }
        }
        epgs = {
          app-4 = {
            epg_name = "app-4"
            bd = {
              bd_name = "bd-304"       ## Bridge Domain to add EPG to
            }
            description = "App #4 EPG"
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
              esg_name = "app-4"
            }
            preferred_group = "include"  ## Must be the same as ESG!
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
        #   l3outs      = {} ## List of associated L3outs for BD's Subnets
        #   subnets = {}
        # }
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
                      type            = "ext-svi"
                      ip              = "10.66.209.22/30"
                      vlan_id         = 302
                      pod             = 1
                      leaf_node       = 102
                      port            = "eth1/1"
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
              preferred_group     = "include"
              consumed_contracts = {}
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
          }
        }
      }
    }
    contracts = {
      standard = {}
      filters = {}
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
  }
}
