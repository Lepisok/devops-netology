## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ                                                         |
| ------------- |---------------------------------------------------------------|
| Какое значение будет присвоено переменной `c`?  | TypeError: unsupported operand type(s) for +: 'int' and 'str' |
| Как получить для переменной `c` значение 12?  | a = str(a)                                                    |
| Как получить для переменной `c` значение 3?  | b = int(b)                                                    |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os


bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/project", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(f'/home/vagrant/project/{prepare_result}')
```

### Вывод скрипта при запуске при тестировании:
```
vagrant@vagrant:~/project$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   test_1.txt

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   test_1.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        task_1.py

vagrant@vagrant:~/project$ ./task_1.py 
/home/vagrant/project/test_1.txt
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys


dir = sys.argv[1]
bash_command = [f'cd {dir}', "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(f'{dir}/{prepare_result}')

```

### Вывод скрипта при запуске при тестировании:
```
vagrant@vagrant:~/project$ ./task_2.py /home/vagrant/project/
/home/vagrant/project//test_1.txt
vagrant@vagrant:~/project$ ./task_2.py /home/vagrant/
fatal: not a git repository (or any of the parent directories): .git
```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import time


dns_name = [ 'drive.google.com', 'mail.google.com', 'google.com' ]
ip_addr = [None, None, None]

while True:
        for i in range (0, len(dns_name)):
                ip = socket.gethostbyname(dns_name[i])
                print(dns_name[i] + ' ---- ' + ip)
                time.sleep(5)
                if  ip_addr[i] is None:
                        ip_addr[i] = ip
                elif ip_addr[i] != ip:
                        print('[ERROR] ' + dns_name[i] + ' IP mismatch: ' +  ip_addr[i] + ip)

```

### Вывод скрипта при запуске при тестировании:
```
vagrant@vagrant:~/project$ ./task_3.py
drive.google.com ---- 64.233.165.194
mail.google.com ---- 142.250.74.5
google.com ---- 216.58.207.206
drive.google.com ---- 64.233.165.194
mail.google.com ---- 142.250.74.5
google.com ---- 216.58.207.206
```