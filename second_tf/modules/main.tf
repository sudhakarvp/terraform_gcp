module "vpc-test" {
  source = "/home/sudhakarvp/second_tf/vpc_module"
  network_name = "test"
  project_id = "terraform-261710"
  auto_create_subnetworks = false
}

module "subnet-public" {
  source = "/home/sudhakarvp/second_tf/subnet_module"
  name = "public-subnet"
  subnet_cidr_public = "10.0.1.0/28"
  region = "us-central1"
  network_name = "test"
} 
 

