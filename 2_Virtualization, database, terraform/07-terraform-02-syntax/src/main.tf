variable "zone" {
  default = "ru-central1-a"
}

variable "domain_name" {
  default = "test.me"
}

provider "yandex" {
  cloud_id  = "b1gnbhah0meo1u27m3jf"
  folder_id = "b1g1k64h2f89q85s1fv9"
  zone = "${var.zone}"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8jvcoeij6u9se84dt5"
	  name        = "vm1"
      type        = "network-nvme"
      size        = "40"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

}

resource "yandex_vpc_network" "network-1" {
  name = "network_a"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet"
  zone = "${var.zone}"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}