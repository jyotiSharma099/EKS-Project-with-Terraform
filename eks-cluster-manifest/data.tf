data "aws_secretsmanager_secret" "env_secrets" {
  name = "RdsCredentialsforadm"
  depends_on = [
    aws_secretsmanager_secret.RdsCredentialsforadm
  ]
}
data "aws_secretsmanager_secret_version" "current_secrets" {
  secret_id = data.aws_secretsmanager_secret.env_secrets.id
}