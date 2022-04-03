data "template_cloudinit_config" "cloudinit-example" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = template_file("scripts/init.cfg", {
      region = var.aws_region
    })
  }

  part {
    content_type = "text/x-shellscript"
    content      = template_file("scripts/runner.sh", {
    personal_access_token = var.personal_access_token
    })
  }
}
