module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version  = "~> 21.0" # this is module version

  name              = "roboshop-dev"
  # kubernetes_version = "1.33"
  kubernetes_version = "1.33"

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
    metrics-server = {}
  }

  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = local.vpc_id
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids
  create_node_security_group = false
  create_security_group      = false
  node_security_group_id = local.eks_node_sg_id
  security_group_id = local.eks_control_plane_sg_id

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    # blue = {
    #   create = true
    #   ami_type       = "AL2023_x86_64_STANDARD"
    #   kubernetes_version = 1.33
    #   instance_types = ["t3.small"]
    #   iam_role_additional_policies  = {
    #     amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
    #     amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    #   }
      
    #   # cluster nodes autoscaling
    #   min_size     = 2
    #   max_size     = 10
    #   desired_size = 2

    #   # taints = {
    #   #   upgrade = {
    #   #     key = "upgrade"
    #   #     value = "true"
    #   #     effect = "NO_SCHEDULE"
    #   #   }
    #   # }

    #   labels = {
    #     nodegroup = "blue"
    #   }
    # }

    green = {
      create = true
      ami_type       = "AL2023_x86_64_STANDARD"
      kubernetes_version = 1.33
      instance_types = ["t3.small"]
      iam_role_additional_policies  = {
        amazonEFS = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
        amazonEBS = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }
      
      #cluster nodes autoscaling
      min_size     = 2
      max_size     = 10
      desired_size = 2

      # taints = {
      #   upgrade = {
      #     key = "upgrade"
      #     value = "true"
      #     effect = "NO_SCHEDULE"
      #   }
      # }

      labels = {
        nodegroup = "green"
      }
    }
  }
}

  
