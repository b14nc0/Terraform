 


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  

  cluster_name                    = var.eks_name
  cluster_version                 = var.eks_version
  vpc_id                          = module.vpc.vpc_id
  subnet_ids                      = module.vpc.private_subnets
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  cluster_addons = {

    coredns = {
      resolve_conflict = "OVERWRITE"
    }

    vpc-cni = {
      resolve_conflict = "OVERWRITE"
    }
    kube-proxy = {
      resolve_conflict = "OVERWRITE"
    }
    aws-ebs-csi-driver = {
      resolve_conflict = "OVERWRITE"
    }
  }
  #create_aws_auth_configmap = true
  #manage_aws_auth_configmap = true

  eks_managed_node_groups = {
    node-group = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_types   = var.eks_instance_type
      capacity_type = "SPOT"
      tags = {
        Terraform   = "true"
        Enviromment = var.enviroment
      }

    }

  }

}

