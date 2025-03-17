variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "container_app_rg"
}

variable "tags" {
  description = "Map of key/value pair to associate with the resource and/or use for the naming standard"
  type        = map(string)
  default     = {}
}

variable "terraform_module" {
  description = "Used to inform of a parent module"
  type        = string
  default     = ""
}

variable "container_app_env_name" {
  description = "Container App Environment Name"
  type        = string
}

variable "container_apps" {
  description = "A map of container apps to create"
  type = map(object({
    name            = string
    container_name  = string
    container_image = string
    cpu             = number
    memory          = string
    revision_mode   = string
    tags            = map(string)
  }))
}
