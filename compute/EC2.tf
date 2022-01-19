#--------------------------compute/ec2.tf-----------------------

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "random_id" "node_id" {
  byte_length = 2
  count       = var.count_in
  keepers = {
    key_name = var.key_name #Random_id resource changes value everytime key is changed 
  }
}

resource "aws_key_pair" "pc_auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "ec2_grtz_node" {
  count                  = var.count_in # 1
  ami                    = data.aws_ami.server_ami.id
  instance_type          = var.instance_type # "t3.micro" stockholm region
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id[count.index]
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "grtz-node-${random_id.node_id[count.index].dec}"
  }
  key_name = aws_key_pair.pc_auth.id
  user_data = templatefile(var.user_data_path,
    {
      nodename    = "grtz-ec2-${random_id.node_id[count.index].dec}"
      db_endpoint = var.db_endpoint
      dbuser      = var.dbuser
      dbpass      = var.dbpassword
      dbname      = var.dbname
    }
  )
  root_block_device {
    volume_size = var.volume_size
  }
} #Resource


resource "aws_lb_target_group_attachment" "tg_alb_attachment" {
  count = var.count_in
  target_group_arn = var.lb_target_group_arn
  target_id        = aws_instance.ec2_grtz_node[count.index].id
  port             = 8000
}