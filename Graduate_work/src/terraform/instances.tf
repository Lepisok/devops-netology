resource "yandex_compute_instance" "nodes" {
  for_each    = local.nodes
  name        = each.key
  zone        = var.zone
  hostname    = "${each.key}.lepis.cloud"
  description = each.value["desc"]
  platform_id = "standard-v2"

  resources {
    cores     = each.value["cores"]
    memory    = each.value["memory"]
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.image_id}"    ## Ubuntu 20.04 LTS
      type        = "network-nvme"
      size        = "30"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data   = "${file("./user.txt")}"
    description = "The file includes the users to be added to the VM"
  }

  lifecycle {
    create_before_destroy = true
  }
}

locals {

  nodes = {
    masternode = {
      "cores" = 2
      "memory" = 4
      "desc" = "ubuntu-vm-1"
    }
    workernode1 = {
      "cores" = 2
      "memory" = 4
      "desc" = "ubuntu-vm-2"
    }
  }
}