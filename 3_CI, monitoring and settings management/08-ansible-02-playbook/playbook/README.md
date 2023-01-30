## Описание playbook
Данный `playbook` предназначен для установки на хосты clickhouse и vector  
`inventory/prod.yml` - `inventory` хосты для установки clickhouse и vector  
`group_vars/` - переменные для установки и настройки clickhouse и vector  
`site.yml` - состоит из двух `play` для установки и настройки clickhouse и vector  
`templates` - шаблоны  
`Теги` в данном `playbook` не используются  
`ansible-playbook -i inventory/prod.yml site.yml` - запуск `playbook`