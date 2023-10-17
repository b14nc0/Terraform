# Input Variables
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "eu-west-1"  
}

################# VPC

# VPC Name
variable "vpc_name" {
  description = "VPC Name"
  type = string 
  default = "eks-prueba-vpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type = list(string)
  default = ["eu-west-1a", "eu-west-1b"]
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  description = "VPC Private Subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  type = bool
  default = true  
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  description = "Enable only single NAT Gateway in one Availability Zone to save costs during our demos"
  type = bool
  default = true
}

################### EKS

variable "eks_name" {
  description = "eks Name"
  type = string 
  default = "eks-prueba"
}

variable "eks_version" {
  description = "eks version"
  type = string 
  default = "1.24"
}

variable "eks_instance_type" {
  description = "eks instance_type"
  type = list(string )
  default = ["t3.medium"]
}


############################## Tags

variable "enviroment" {
  description = "enviromment"
  type = string 
  default = "eks-prueba"
}