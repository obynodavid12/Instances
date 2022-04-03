data "template_cloudinit_config" "cloudinit-example" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = template_file("scripts/init.cfg", {
      REGION = var.aws_region
    })
  }

  part {
    content_type = "text/x-shellscript"
    content      = template_file("scripts/runner.sh", {
    RUNNER_CFG_PAT = var.personal_access_token
    })
  }
}
