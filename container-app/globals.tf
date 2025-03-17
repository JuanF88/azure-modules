# data "aws_region" "current" {}
# data "aws_caller_identity" "current" {}

# module "standard_tags"{
#     source = "app.terraform.io/bokf/tag/cloud"
#     version = "~>0.3.0"
#     tags = merge(
#         var.tags,
#         {
#             tfModule = local.tfModule_extended
#         }
#     )
# }