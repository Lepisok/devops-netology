# Домашнее задание к занятию "2. Работа с Playbook"

## Подготовка к выполнению

1. (Необязательно) Изучите, что такое [clickhouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [vector](https://www.youtube.com/watch?v=CgEhyffisLY)
2. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.
3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Приготовьте свой собственный inventory файл `prod.yml`.  
Решение:  
```
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: 192.168.35.131

vector:
  hosts:
    vector:
      ansible_host: 192.168.35.132
```
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).  
Решение:
```
- name: Install Vector
  hosts: vector
  handlers:
    - name: Start Vector service
      ansible.builtin.service:
        name: vector
        state: restarted
  hosts: vector
  tasks:
    - name: Get vector distrib
      ansible.builtin.get_url:
        url: "https://packages.timber.io/vector/{{ vector_version}}/vector-x86_64.rpm"
        dest: "./vector-{{ vector_version}}.rpm"
    - name: Install vector packages
      become: true
      ansible.builtin.yum:
        name:
          - vector-{{ vector_version}}.rpm
      notify: Start Vector service
```
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.  
Решение:  
```
root@lepis:/home/lepis/Downloads/mnt-homeworks-MNT-video/08-ansible-02-playbook/playbook# ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.  
Решение:  
```
root@lepis:/home/lepis/Downloads/mnt-homeworks-MNT-video/08-ansible-02-playbook/playbook# ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: Found both group and host with same name: vector

PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ************************************************************************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [vector]

TASK [Get vector distrib] *********************************************************************************************************************************************************************************
ok: [vector]

TASK [Install vector packages] ****************************************************************************************************************************************************************************
ok: [vector]

PLAY RECAP ************************************************************************************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0   
vector                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.  
Решение:
```
root@lepis:/home/lepis/Downloads/mnt-homeworks-MNT-video/08-ansible-02-playbook/playbook# ansible-playbook -i inventory/prod.yml site.yml --diff
[WARNING]: Found both group and host with same name: vector

PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "size": 246310036, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Create database] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [vector]

TASK [Get vector distrib] *********************************************************************************************************************************************************************************
ok: [vector]

TASK [Install vector packages] ****************************************************************************************************************************************************************************
ok: [vector]

PLAY RECAP ************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.  
Решение:  
[README.md](https://github.com/Lepisok/devops-netology/blob/main/3_CI%2C%20monitoring%20and%20settings%20management/08-ansible-02-playbook/playbook/README.md)
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.  
Решение:  
[playbook](https://github.com/Lepisok/devops-netology/tree/main/3_CI%2C%20monitoring%20and%20settings%20management/08-ansible-02-playbook/playbook)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
