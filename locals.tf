#--------------------------root/locals.tf-----------------------

locals {
  vpc_cidr = "10.100.0.0/16"
}

locals {
  security_groups = {
    public = {
      name        = "public_sg"
      description = "SG for public access"
      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        nginx = {
          from        = 8000
          to          = 8000
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }#Public
    
    testRDP = {
      name = "windows-rdp"
      description = "RDP for public access"
      ingress = {
        rdp = {
          from        = 3389
          to          = 3389
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
      }
    }#testRDP

    private = {
      name        = "private_sg"
      description = "SG for private access"
      ingress = {
        rds = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = [local.vpc_cidr]
        }
      }
    } #Private
##########################
  } #Security Group
}   #Locals