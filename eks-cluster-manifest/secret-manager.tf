resource "aws_secretsmanager_secret" "RdsCredentialsforadm" {
  name = "RdsCredentialsforadm"
}
resource "aws_secretsmanager_secret_version" "RdsCredentialsforadm" {
  secret_id     = aws_secretsmanager_secret.RdsCredentialsforadm.id
  secret_string = jsonencode(var.RdsCredentialsforadm)
}