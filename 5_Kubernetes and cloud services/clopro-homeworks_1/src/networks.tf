resource "yandex_vpc_network" "network-1" {
  name           = "network_a"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public-subnet"
  zone           = "${var.zone}"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}


resource "yandex_vpc_subnet" "private" {
  name           = "private-subnet"
  zone           = "${var.zone}"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.route-table.id
}

resource "yandex_vpc_route_table" "route-table" {
  name       = "route-table"
  network_id = yandex_vpc_network.network-1.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat.network_interface.0.ip_address
  }
}