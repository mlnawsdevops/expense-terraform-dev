module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = local.resource_name

  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.bastion_subnet_ids[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project = "expense"
  }
}

module "ec2_instance1" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-1"

  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.bastion_subnet_ids[1]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project = "expense"
  }
}