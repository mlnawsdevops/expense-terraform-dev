variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
    }
}

variable "mysql_tags" {
    default = {}
}

variable "backend_tags" {
    default = {}
}

variable "frontend_tags" {
    default = {}
}

variable "ansible_tags" {
    default = {}
}

variable "zone_name" {
    default = "daws100s.online"
}

variable "zone_id" {
    default = "Z02305702LFJSCAA8YV7Q"
}

variable "route53_tags" {
    default = {}
} 