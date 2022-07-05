resource "aws_subnet" "Non-prod-pub-a" {
  vpc_id            = aws_vpc.Non-prod-vpc.id
  cidr_block        = "10.0.0.0/22"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "Non-prod-pub-a"
  }
}
resource "aws_subnet" "Non-prod-priv-a" {
  vpc_id            = aws_vpc.Non-prod-vpc.id
  cidr_block        = "10.0.4.0/22"
  availability_zone = "ap-south-1a"

  tags = {
    "Name" = "Non-prod-priv-a"
  }
}
resource "aws_subnet" "Non-prod-pub-b" {
  vpc_id            = aws_vpc.Non-prod-vpc.id
  cidr_block        = "10.0.8.0/22"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name" = "Non-prod-pub-b"
  }
}
resource "aws_subnet" "Non-prod-priv-b" {
  vpc_id            = aws_vpc.Non-prod-vpc.id
  cidr_block        = "10.0.12.0/22"
  availability_zone = "ap-south-1b"

  tags = {
    "Name" = "Non-prod-priv-b"
  }
}