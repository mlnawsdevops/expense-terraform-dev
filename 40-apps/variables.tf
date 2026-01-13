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