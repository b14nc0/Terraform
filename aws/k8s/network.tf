module "vpc" { 
    source = "terraform-aws-modules/vpc/aws"
    name = "kubernetes-prueba-vpc"
    cidr = "10.0.0.0/16"
        azs = ["eu-west-1a"]
        private_subnet = ["10.0.1.0/24"]
        public_subnet = ["10.0.2.0/24"]
    create_igw = true
    enable_nat_gateway = true
    single_nat_gateway = true
    
    tags = { 
        Terraform = "true"
        Enviromment = "prueba"
    }
}