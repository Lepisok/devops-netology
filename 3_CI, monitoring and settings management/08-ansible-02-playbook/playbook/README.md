## Описание playbook
Данный `playbook` предназначен для установки на хосты clickhouse и vector  
`inventory/prod.yml` - `inventory` хосты для установки clickhouse и vector  
`group_vars/clickhouse/vars.yml` - переменные для установки clickhouse  
`group_vars/vector/vars.yml` - переменные для установки vector  
`site.yml` - `play` для установки и настройки clickhouse и vector  
`Теги` в данном `playbook` не используются  
`ansible-playbook -i inventory/prod.yml site.yml` - запуск `playbook`