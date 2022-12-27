module "iam" {
  source = "modules/iam"

  name = test_user
  description = "My-test-user"
}