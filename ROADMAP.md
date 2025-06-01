# ROADMAP

## Ближайшие улучшения
- Модуль ACM + HTTPS для публичного сервиса.
- Перенос user_data в шаблон Cloud-Init и параметризацию.
- Разделение окружений (workspaces): dev/stage/prod.

## Инфраструктура
- Модуль CloudFront + приватный доступ к S3.
- Логирование: CloudWatch, метрики EC2 и алерты.
- Бэкапы состояния Terraform на S3/DynamoDB.

## CI/CD
- Автоматические проверки `terraform fmt`, `validate`, `tflint`.
- План/апплай по PR с ручным подтверждением.

## Безопасность
- Ограничение SSH до корпоративных CIDR.
- Шифрование параметров/секретов через SSM Parameter Store.