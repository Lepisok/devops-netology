# Установка clickhouse, vector и lighthouse
## Директория  groups_vars

| Файлы           |                         Описание                          |
|---              |:---------------------------------------------------------:|
| clickhouse.yml  | Указанная переменная версии для установки clickhouse      |
| vector.yml      | Указанная переменная версии для установки vector и конфиг |

## Директория inventory
| Файлы      |                      Описание                      |
|------------|:--------------------------------------------------:|
| prod.yml   | Указанны хосты для clickhouse, vector и lighthouse |
## Директория template

| Файлы             |                   Описание                    |
|-------------------|:---------------------------------------------:|
| vector.service.j2 |      Шаблон для настройки сервиса vector      |
| vector.yml.j2     | Шаблон для преобразования конфига в ```YML``` |
| nginx.conf.j2     |      Шаблон для настройки сервиса nginx       |
|lighthouse.conf.j2 |    Шаблон для настройки сервиса lighthouse    |
## Описание playbook site.yml

| Taks                        |                                                                         Описание                                                                          |
|-----------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------:|
| ***Clickhouse***            |                                                                                                                                                           |
| Get clickhouse distrib      | Скачивание пакетом для установки clickhouse. Сначала скачиваются пакеты ```noarch.rpm```, если данных пакетов нет, то скачиваются пакеты ```x86_64.rpm``` |
| Install clickhouse packages |                                                 Установка скаченных пакетов перезапуск службы clickhouse                                                  |
| Create database             |                                                                 Cоздание БД в clickhouse                                                                  |
| ***Vector***                |                                                                                                                                                           |
| Get vector distrib          |                                                          Скачивание пакетов для установки vector                                                          |
| Install vector packages     |                                                            Установка скаченных пакетов vector                                                             |
| Vector templates            |                                                       Применение шаблона конфига```vector.yml.j2```                                                       |
| Vector systemd unit         |                                       Применение шаблона сервиса```vector.service.j2``` и перезапуск службы vector                                        |
| ***Lighthouse***            |                                                                                                                                                           |
| Install git                 |                                                                       Установка Git                                                                       |
| Install apps for lighthouse |                                                Установка пакетов для корректной работы lighthouse и nginx                                                 |
| Git clone lighthouse        |                                                            Клонирования репозитория lighthouse                                                            |
| Copy nginx.conf             |                                                            Применение шаблона ```nginx.conf```                                                            |
| Copy lighthouse.conf.j2     |                                            Применение шаблона ```lighthouse.conf.j2``` и запуск сервиса nginx                                             |