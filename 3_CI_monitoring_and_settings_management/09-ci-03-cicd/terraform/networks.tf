resource "yandex_vpc_network" "network-1" {
  name = "network_a"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.35.0/24"]
}