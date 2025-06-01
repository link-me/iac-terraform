param(
  [string]$EnvName = "dev",
  [string]$TfVars = "dev.tfvars"
)

Write-Host "[iac-terraform] Проверка наличия Terraform..." -ForegroundColor Cyan
try {
  terraform -version | Out-Null
} catch {
  Write-Host "Terraform не найден. Установите одним из способов:" -ForegroundColor Yellow
  Write-Host " - winget install HashiCorp.Terraform"
  Write-Host " - choco install terraform" 
  Write-Host "После установки запустите скрипт снова: .\\run.ps1" -ForegroundColor Yellow
  exit 1
}

Write-Host "[iac-terraform] Инициализация: terraform init" -ForegroundColor Cyan
terraform init
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "[iac-terraform] Валидация: terraform validate" -ForegroundColor Cyan
terraform validate
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "[iac-terraform] Планирование для '$EnvName': terraform plan -var-file=$TfVars" -ForegroundColor Cyan
terraform plan -var-file=$TfVars -out "$EnvName.tfplan"
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "[iac-terraform] План сохранён в $EnvName.tfplan. Запуск apply (Y/N)?" -ForegroundColor Green
$confirm = Read-Host "Подтвердите (Y/N)"
if ($confirm -match "^(Y|y)$") {
  Write-Host "[iac-terraform] Применение: terraform apply $EnvName.tfplan" -ForegroundColor Cyan
  terraform apply "$EnvName.tfplan"
} else {
  Write-Host "[iac-terraform] Применение отменено пользователем." -ForegroundColor Yellow
}