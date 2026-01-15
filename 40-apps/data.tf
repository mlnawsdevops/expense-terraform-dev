data "aws_ami" "rhel9" {
    most_recent = true
    owners = [ "973714476881" ]

    filter {
      name = "name"
      values = ["Redhat-9-DevOps-Practice"]
    }

    filter {
        name = "root-device-type"
        values = [ "ebs" ] #aws filter values are case-sensitive
    }

    filter {
      name = "virtualization-type"
      values = [ "hvm" ]
    }
  
}

data "aws_ssm_parameter" "mysql_sg_id" {
    name = "/${var.project_name}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "backend_sg_id" {
    name = "/${var.project_name}/${var.environment}/backend_sg_id"
}

data "aws_ssm_parameter" "frontend_sg_id" {
    name = "/${var.project_name}/${var.environment}/frontend_sg_id"
}

data "aws_ssm_parameter" "ansible_sg_id" {
    name = "/${var.project_name}/${var.environment}/ansible_sg_id"
}

data "aws_ssm_parameter" "public_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/public_subnet_ids"
}

data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/private_subnet_ids"
}

data "aws_ssm_parameter" "database_subnet_ids" {
    name = "/${var.project_name}/${var.environment}/database_subnet_ids"
}

data "aws_route53_zone" "this" {
  name         = "daws100s.online"
  private_zone = false
}