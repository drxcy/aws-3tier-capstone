variable "DB_NAME" {
    description =  "Master Database Name"
    type = string
    default = "appdb"
}
variable "DB_USERNAME" {
    description = "Master Database Username"
    type = string
    default = "postgres"
}
variable "DB_PASSWORD" {
    description = "Master Database Password"
    sensitive = true
    type = string
    default = "postgres"
}
variable "DB_INSTANCE" {
    description = "Database Instance for Postgres"
    type = string
    default = "db.t3.micro"
}
variable "DB_STORAGE" {
    description = "Database Storage for Postgres 20GB"
    type = number
    default = 20
}