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
      size        = "40"
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

resource "yandex_compute_instance" "centos-for-each" {
  for_each = local.for_each[terraform.workspace]
  name = "${terraform.workspace}-foreach-${each.key}"

  resources {
    cores  = local.cores[terraform.workspace]
    memory = local.memory[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.image_id}"    #Centos7
      type        = "network-nvme"
      size        = "40"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
}

locals {
  instance_count = {
    "prod"  = 2
    "stage" = 1
  }
  cores = {
    "prod"  = 2
    "stage" = 1
  }
  memory = {
    "prod"  = 2
    "stage" = 1
  }
  for_each = {
    prod = {
      "1" = {cores = "2", memory = "2"}
      "2" = {cores = "2", memory = "2"}
    }
    stage = {
      "3" = {cores = "1", memory = "1"}
    }
  }
}