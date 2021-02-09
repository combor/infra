resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.ssh_authorized_key
}


resource "aws_network_interface" "worker" {
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.allow_ssh.id, aws_security_group.allow_tls.id]

  tags = {
    Name = "worker"
  }
}

resource "aws_eip" "worker" {
  network_interface = aws_network_interface.worker.id
  vpc               = true
}

data "ct_config" "worker-ignition" {
  content  = data.template_file.worker-config.rendered
  strict   = true
  snippets = var.snippets
}

data "template_file" "worker-config" {
  template = file("${path.module}/worker.yaml")

  vars = {
    ssh_authorized_key            = var.ssh_authorized_key
    traefik_aws_access_key_id     = aws_iam_access_key.traefik.id
    traefik_aws_secret_access_key = aws_iam_access_key.traefik.secret
    traefik_hosted_zone_id        = aws_route53_zone.kombor-ski.id
    traefik_version               = var.traefik_version
    unifi_version                 = var.unifi_version
    acme_email                    = var.acme_email
    aws_region                    = var.aws_region
  }
}

resource "aws_ebs_volume" "worker" {
  availability_zone = data.aws_availability_zones.all.names[0]
  size              = 20
}

resource "aws_instance" "worker" {
  ami           = data.aws_ami.flatcar.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.id
  user_data     = data.ct_config.worker-ignition.rendered

  root_block_device {
    volume_type = var.disk_type
    volume_size = var.disk_size
    iops        = var.disk_iops
    encrypted   = true
  }

  network_interface {
    network_interface_id = aws_network_interface.worker.id
    device_index         = 0
  }
}

resource "aws_volume_attachment" "worker" {
  device_name = "/dev/xvdc"
  volume_id   = aws_ebs_volume.worker.id
  instance_id = aws_instance.worker.id
}
