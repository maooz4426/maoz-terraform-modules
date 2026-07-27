variable "role_name" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "policy_document" {
  type = string
}

# nullにしてmovedした際にも対応できるように
# movedの際はcollasceを使用する
variable "policy_name" {
  type    = string
  default = null
}

variable "attachment_name" {
  type    = string
  default = null
}
