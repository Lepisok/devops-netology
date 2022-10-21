## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" : [           #  добавил пробел после двоеточия
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            },                   # добавил запятую
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43" # добавил скобку к ip и обернул в скобки адрес
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
#!/usr/bin/env python3


import socket
import time
import json
import yaml


service_addr = {
    'drive.google.com': '0',
    'mail.google.com': '0',
    'google.com': '0'
}

for item in service_addr:
    initial_addr = socket.gethostbyname(item)
    service_addr[item] = initial_addr
    with open(item + '.json', 'w') as output_json:
        data_json = json.dumps({item: service_addr[item]})
        output_json.write(data_json)

    with open(item + '.yaml', 'w') as output_yaml:
        data_yaml = yaml.dump([{item: service_addr[item]}])
        output_yaml.write(data_yaml)

while True:
    for item in service_addr:
        old_addr = service_addr[item]
        new_addr = socket.gethostbyname(item)
        if new_addr != old_addr:
            service_addr[item] = new_addr
            with open(item + '.json', 'w') as output_json:
                data_json = json.dumps({item: service_addr[item]})
                output_json.write(data_json)

            with open(item + '.yaml', 'w') as output_yaml:
                data_yaml = yaml.dump([{item: service_addr[item]}])
                output_yaml.write(data_yaml)
            print("[ERROR] " + item + " IP mismatch: old IP " + old_addr + ", new IP " + new_addr)
        print(item + " - " + service_addr[item])
    print("######################################")
    time.sleep(10)

```

### Вывод скрипта при запуске при тестировании:
```
vagrant@vagrant:~$ ./task_5.py
drive.google.com - 142.250.150.194
mail.google.com - 142.250.74.133
google.com - 216.58.209.174
######################################
drive.google.com - 142.250.150.194
mail.google.com - 142.250.74.133
google.com - 216.58.209.174
######################################
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"drive.google.com": "142.250.150.194"}
{"google.com": "216.58.209.174"}
{"mail.google.com": "142.250.74.133"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
- drive.google.com: 142.250.150.194
- google.com: 216.58.209.174
- mail.google.com: 142.250.74.133
```