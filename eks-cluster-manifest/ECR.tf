resource "aws_ecrpublic_repository" "pub_repo" {

repository_name = "wordpress"

catalog_data {
about_text = "wordpress Image"
architectures = ["x86-64"]
description = "wordpress image from dockerfile"
operating_systems = ["Linux"]
usage_text = "Usage Text"
}

tags = {
env = "dev"
}
}