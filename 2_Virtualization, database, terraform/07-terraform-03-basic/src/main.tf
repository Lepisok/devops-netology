provider "yandex" {
  cloud_id  = "b1gnbhah0meo1u27m3jf"
  folder_id = "${var.folder_id}"
  zone = "${var.zone}"
}

resource "yandex_iam_service_account" "sa" {
  folder_id = "${var.folder_id}"
  name      = "lepis"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = "${var.folder_id}"
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "netology-lepis" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "netology-lepis"
}
