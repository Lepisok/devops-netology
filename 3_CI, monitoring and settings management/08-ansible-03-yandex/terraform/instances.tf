resource "yandex_compute_instance" "centos-count" {
  count = local.instance_count[terraform.workspace]
  name = "${terraform.workspace}-count-${count.index}"

  resources {
    cores  = local.cores[terraform.workspace]
    memory = local.memory[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.image_id}"    #Centos7
      type        = "network-nvme"
      size        = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  instance_count = {
    "prod"  = 3
    "stage" = 1
  }
  cores = {
    "prod"  = 2
    "stage" = 1
  }
  memory = {
    "prod"  = 4
    "stage" = 1
  }
}
