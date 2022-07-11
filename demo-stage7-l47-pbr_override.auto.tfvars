tenants = {
  demo-basic-1 = {
    networking = {
      l3outs = {
        demo-l3out = {
          external_epgs = {
            dbadmins = {
              ## NOTE: Contract Master External EPGS MUST ALREADY EXIST - CURRENT NO METHOD TO ENSURE MASTER EXEPG BUILT FIRST
              contract_master_epgs = {
                demo-l3out = {
                  l3out_name = "demo-l3out"
                  extepg_name= "rfc1918"
                }
              }
            }
            webadmins = {
              ## NOTE: Contract Master External EPGS MUST ALREADY EXIST - CURRENT NO METHOD TO ENSURE MASTER EXEPG BUILT FIRST
              contract_master_epgs = {
                rfc1918 = {
                  l3out_name = "demo-l3out"
                  extepg_name= "rfc1918"
                }
              }
            }
          }
        }
      }
    }
    contracts = {
      standard = {
        app1-web-to-db = {
          subjects = {
            default = {
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
      }
    }
  }
}
