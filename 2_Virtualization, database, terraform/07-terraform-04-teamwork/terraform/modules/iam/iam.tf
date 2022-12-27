variable name         {default = ""}
variable description  {default = ""}

resource "yandex_iam_service_account" "sa" {
  name        = var.name
  description = var.description
}

resource "yandex_resourcemanager_folder_iam_binding" "admin-account-iam" {
  folder_id   = "${var.folder_id}" # будет указан в отдельном файле variables.tf
  role        = "editor"
  members     = [
    "serviceAccount:${yandex_iam_service_account.sa.id}",
  ]
}