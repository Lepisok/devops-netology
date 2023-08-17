resource "yandex_compute_instance" "nat" {
  name        = "nat"
  zone        = var.zone
  hostname    = "nat"
  platform_id = "standard-v2"


  resources {
    cores         = 4
    core_fraction = 50
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8qmbqk94q6rhb4m94t"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.public.id}"
    ip_address = "192.168.10.254"
    nat = true
  }
}
  
resource "yandex_compute_instance" "public-node" {
  name        = "public-node"
  zone        = var.zone
  hostname    = "public-node.lepis.cloud"
  description = "public node instance"
  platform_id = "standard-v2"

  resources {
    cores         = 4
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.image_id}"    ## Ubuntu 20.04 LTS
      type        = "network-nvme"
      size        = "30"
    }
  }

  metadata = {
      user-data   = "${file("./user.txt")}"
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.public.id}"
    nat       = true
  }
}


resource "yandex_compute_instance" "private-node" {
  name        = "private-node"
  zone        = var.zone
  hostname    = "private-node.lepis.cloud"
  description = "private node instance"
  platform_id = "standard-v2"

  allow_stopping_for_update = true

  resources {
    cores         = 4
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.image_id}"    ## Ubuntu 20.04 LTS
      type        = "network-nvme"
      size        = "30"
    }
  }

  metadata = {
      user-data   = "${file("./user.txt")}"
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.private.id}"
  }
}