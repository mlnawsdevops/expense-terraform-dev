# open source module with aws contribution
# 2 AZ = us-east-1a, us-east-1b
# using 2AZ bastion servers are integrating with 2AZ of frontend, backend, mysql servers 

#bastion-1 server
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = local.resource_name #expense-dev-bastion

  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id] # bastion security group from 20-sg
  subnet_id = local.bastion_subnet_ids[0] # us-east-1a availability zone bastion-expense-dev server

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project = "expense"
  }
}


# bastion-2 server
module "ec2_instance1" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "${local.resource_name}-1" # expense-dev-bastion-1

  instance_type = "t3.micro"
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.bastion_subnet_ids[1] # us-east-1b availability zone bastion-expense-dev-1 server

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Project = "expense"
  }
}