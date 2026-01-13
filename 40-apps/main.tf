module "mysql-1" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-mysql-1"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.mysql_sg_id]
    subnet_id = local.database_subnet_ids[0] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.mysql_tags,
        {
        Name = "${local.resource_name}-2"
        }
    )
}


module "mysql-2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-mysql-2"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.mysql_sg_id]
    subnet_id = local.database_subnet_ids[1] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.mysql_tags,
        {
        Name = "${local.resource_name}-2"
        }
    )
}


module "backend-1" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-backend-1"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.backend_sg_id]
    subnet_id = local.private_subnet_ids[0] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.backend_tags,
        {
        Name = "${local.resource_name}-1"
        }
    )
}


module "backend-2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-backend-2"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.backend_sg_id]
    subnet_id = local.private_subnet_ids[1] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.backend_tags,
        {
        Name = "${local.resource_name}-2"
        }
    )
}


module "frontend-1" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-frontend-1"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.frontend_sg_id]
    subnet_id = local.public_subnet_ids[0] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.frontend_tags,
        {
        Name = "${local.resource_name}-1"
        }
    )
}

module "frontend-2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

    name = "${local.resource_name}-frontend-2"
    ami = data.aws_ami.rhel9.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [local.frontend_sg_id]
    subnet_id = local.public_subnet_ids[1] # us-east-1a availability zone bastion-expense-dev-1 server

    create_security_group = false 

    tags = merge(
        var.common_tags,
        var.frontend_tags,
        {
        Name = "${local.resource_name}-2"
        }
    )
}