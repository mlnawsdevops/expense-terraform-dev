module "mysql" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-mysql"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.mysql_sg_id]
    subnet_id = local.database_subnet_ids[0] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.mysql_tags,
        {
        Name = "${local.resource_name}"
        }
    )
}


# module "mysql-2" {
#   source  = "terraform-aws-modules/ec2-instance/aws"

#     name = "${local.resource_name}-mysql-2"
#     ami = data.aws_ami.rhel9.id
#     instance_type = "t3.micro"
#     vpc_security_group_ids = [local.mysql_sg_id]
#     subnet_id = local.database_subnet_ids[1] # us-east-1a availability zone bastion-expense-dev-1 server

#     create_security_group = false 

#     tags = merge(
#         var.common_tags,
#         var.mysql_tags,
#         {
#         Name = "${local.resource_name}-2"
#         }
#     )
# }


module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-backend"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.backend_sg_id]
    subnet_id = local.private_subnet_ids[0] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.backend_tags,
        {
        Name = "${local.resource_name}"
        }
    )
}


# module "backend-2" {
#   source  = "terraform-aws-modules/ec2-instance/aws"

#     name = "${local.resource_name}-backend-2"
#     ami = data.aws_ami.rhel9.id
#     instance_type = "t3.micro"
#     vpc_security_group_ids = [local.backend_sg_id]
#     subnet_id = local.private_subnet_ids[1] # us-east-1a availability zone bastion-expense-dev-1 server

#     create_security_group = false 

#     tags = merge(
#         var.common_tags,
#         var.backend_tags,
#         {
#         Name = "${local.resource_name}-2"
#         }
#     )
# }


module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-frontend"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.frontend_sg_id]
    subnet_id = local.public_subnet_ids[0] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.frontend_tags,
        {
        Name = "${local.resource_name}"
        }
    )
}

# module "frontend-2" {
#   source  = "terraform-aws-modules/ec2-instance/aws"

#     name = "${local.resource_name}-frontend-2"
#     ami = data.aws_ami.rhel9.id
#     instance_type = "t3.micro"
#     vpc_security_group_ids = [local.frontend_sg_id]
#     subnet_id = local.public_subnet_ids[1] # us-east-1a availability zone bastion-expense-dev-1 server

#     create_security_group = false 

#     tags = merge(
#         var.common_tags,
#         var.frontend_tags,
#         {
#         Name = "${local.resource_name}-2"
#         }
#     )
# }

module "ansible" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-ansible"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.ansible_sg_id]
    subnet_id = local.public_subnet_ids[0] # us-east-1a availability zone bastion-expense-dev-1 server

    user_data = file("expense.sh")
    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.ansible_tags,
        {
        Name = "${local.resource_name}-anisble"
        }
    )
}


module "zone" {
  source = "terraform-aws-modules/route53/aws"

  name = var.zone_name
  create_zone = false   

  records = {
    mysql = {
      type            = "A"
      ttl             = 1
      records         = [module.mysql.private_ip]
      allow_overwrite = true
    }

    # mysql2 = {
    #   type            = "A"
    #   ttl             = 1
    #   records         = [module.mysql-2.private_ip]
    #   allow_overwrite = true
    # }

    backend = {
      type            = "A"
      ttl             = 1
      records         = [module.backend.private_ip]
      allow_overwrite = true
    }

    # backend2 = {
    #   type            = "A"
    #   ttl             = 10
    #   records         = [module.backend-2.private_ip]
    #   allow_overwrite = true
    # }

    frontend = {
      type            = "A"
      ttl             = 1
      records         = [module.frontend.private_ip]
      allow_overwrite = true
    }

    # frontend2 = {
    #   type            = "A"
    #   ttl             = 10
    #   records         = [module.frontend-2.private_ip]
    #   allow_overwrite = true
    # }


    #daws100s.online record with public ip
    apex = {
      name            = "daws100s.online"
      full_name       = "daws100s.online"
      type            = "A"
      ttl             = 10
      records         = [module.frontend.public_ip]
      allow_overwrite = true
    }

    # frontend4 = {
    #   type            = "A"
    #   ttl             = 10
    #   records         = [module.frontend-2.public_ip]
    #   allow_overwrite = true
    # }
  }

  tags = merge(
    var.common_tags,
    var.route53_tags,
    {
        Name = var.zone_name
    }
  )
}
