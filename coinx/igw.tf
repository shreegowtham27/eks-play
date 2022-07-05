resource "aws_internet_gateway" "Non-prod-igw" {
  vpc_id = aws_vpc.Non-prod-vpc.id

  tags = {
    Name = "Non-prod-igw"
  }
}
