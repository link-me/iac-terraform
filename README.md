# IaC Terraform

Stack: Terraform + AWS

Demo project.
# IaC Terraform — AWS базовый стек (VPC + EC2 + S3)

Минимальный, но полезный инфраструктурный проект на Terraform для AWS:
- создаёт VPC с публичной подсетью и интернет-доступом,
- поднимает EC2 инстанс с простым HTTP сервером (для проверки доступности),
- создаёт S3 бакет с версионированием и шифрованием.

## Стек
- Terraform (>= 1.5)
- AWS Provider (~> 5)
- AWS (VPC, EC2, S3)

## Требования
- Terraform установлен локально (`terraform -version`),
- AWS аккаунт и настроенные креды (через `~/.aws/credentials`, профиль `default`),
- права на создание VPC/EC2/S3.

## Быстрый старт
1) Установите Terraform (Windows):
   - `winget install HashiCorp.Terraform` или `choco install terraform`
2) Проверьте доступность:
   - `terraform -version`
3) Перейдите в директорию проекта:
   - `cd projects/iac-terraform`
4) Запустите скрипт:
   - `./run.ps1`
   - Скрипт выполнит `init`, `validate`, `plan` и предложит `apply`.

По умолчанию используется окружение `dev` и файл `dev.tfvars`.

## Ручные команды
- `terraform init`
- `terraform validate`
- `terraform plan -var-file=dev.tfvars -out dev.tfplan`
- `terraform apply dev.tfplan`

## Переменные
Основные переменные заданы в `variables.tf`. В `dev.tfvars` можно изменить регион, тип инстанса, CIDR.

## Выходные значения
После `apply` вы увидите:
- `vpc_id` — ID VPC,
- `public_subnet_id` — ID публичной подсети,
- `bucket_name` — имя S3 бакета,
- `instance_id`, `instance_public_ip` — EC2 ID и публичный IP.

## Проверка доступности EC2
После применения — откройте в браузере `http://<instance_public_ip>/`.
Должна отобразиться страница «… is up».

## Структура
- `providers.tf` — версии и провайдер AWS
- `variables.tf` — переменные
- `main.tf` — связывает модули
- `outputs.tf` — выходные значения
- `modules/network` — VPC, публичная подсеть, IGW, маршруты
- `modules/compute` — EC2 и Security Group
- `modules/s3` — бакет, версионирование, SSE
- `dev.tfvars` — параметры окружения dev
- `run.ps1` — удобный запуск `init/validate/plan/apply`

## Безопасность и стоимость
- S3 включает шифрование по умолчанию (AES256).
- EC2 и VPC — оплачиваемые ресурсы. Не забывайте: `terraform destroy` после тестов.

## Дорожная карта
См. `ROADMAP.md` и `ROADMAP.en.md`.
