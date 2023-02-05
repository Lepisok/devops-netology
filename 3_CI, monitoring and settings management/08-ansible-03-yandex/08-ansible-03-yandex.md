# Домашнее задание к занятию "3. Использование Yandex Cloud"

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.

Ссылка на репозиторий LightHouse: https://github.com/VKCOM/lighthouse

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает lighthouse.
```
- name: Install lighthouse
  hosts: lighthouse
  handlers:
    - name: Start nginx service
      become: true
      ansible.builtin.service:
        name: nginx
        state: restarted
  tasks:
    - name: Install apps for lighthouse
      become: true
      ansible.builtin.yum:
        name:
         - git
         - epel-release
         - nginx
    - name: Git clone lighthouse
      ansible.builtin.git:
        repo: https://github.com/VKCOM/lighthouse.git
        dest: /lighthouse
        clone: yes
    - name: Copy nginx.conf
      become: true
      ansible.builtin.template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
    - name: Copy nginx.conf
      become: true
      ansible.builtin.template:
        src: lighthouse.conf.j2
        dest: /etc/nginx/conf.d/lighthouse.conf
      notify: Start nginx service

```
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.
3. Tasks должны: скачать статику lighthouse, установить nginx или любой другой webserver, настроить его конфиг для открытия lighthouse, запустить webserver.
4. Приготовьте свой собственный inventory файл `prod.yml`.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.  
```
lepis@lepis:~/Downloads/mnt-homeworks-MNT-video/08-ansible-02-playbook/playbook$ sudo ansible-lint site.yml
WARNING  Overriding detected file kind 'yaml' with 'playbook' for given positional argument: site.yml
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.  
```
lepis@lepis:~/Downloads/mnt-homeworks-MNT-video/08-ansible-02-playbook/playbook$ sudo ansible-playbook -i inventory/prod.yml site.yml --check
[WARNING]: Found both group and host with same name: vector
[WARNING]: Found both group and host with same name: lighthouse

PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************************************************
fatal: [clickhouse-01]: FAILED! => {"changed": false, "msg": "No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system", "rc": 127, "results": ["No RPM file matching 'clickhouse-common-static-22.3.3.44.rpm' found on system"]}

PLAY RECAP ************************************************************************************************************************************************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0  
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
PLAY [Install Clickhouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
changed: [clickhouse-01] => (item=clickhouse-client)
changed: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "item": "clickhouse-common-static", "msg": "Request failed", "response": "HTTP Error 404: Not Found", "status_code": 404, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Get clickhouse distrib] *****************************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Install clickhouse packages] ************************************************************************************************************************************************************************
changed: [clickhouse-01]

RUNNING HANDLER [Start clickhouse service] ****************************************************************************************************************************************************************
changed: [clickhouse-01]

TASK [Create database] ************************************************************************************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [vector]

TASK [Get vector distrib] *********************************************************************************************************************************************************************************
ok: [vector]

TASK [Install vector packages] ****************************************************************************************************************************************************************************
ok: [vector]

TASK [Vector templates] ***********************************************************************************************************************************************************************************
--- before: /etc/vector/vector.yml
+++ after: /root/.ansible/tmp/ansible-local-115279arb7sd90/tmpra_94vdo/vector.yml.j2
@@ -2,7 +2,7 @@
     clickhouse:
         compression: gzip
         database: logs
-        endpoint: http://192.168.35.130:8123
+        endpoint: http://192.168.35.131:8123
         inputs:
         - logs_file
         skip_unknown_fields: true

[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If this does not look like what you expect, quote the entire value to ensure it does not change.
changed: [vector]

TASK [Vector systemd unit] ********************************************************************************************************************************************************************************
ok: [vector]

PLAY [Install lighthouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Install git] ****************************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Install apps for lighthouse] ************************************************************************************************************************************************************************
changed: [lighthouse]

TASK [Git clone lighthouse] *******************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Copy nginx.conf] ************************************************************************************************************************************************************************************
--- before: /etc/nginx/nginx.conf
+++ after: /root/.ansible/tmp/ansible-local-115279arb7sd90/tmpem179fb2/nginx.conf.j2
@@ -39,7 +39,7 @@
         listen       80;
         listen       [::]:80;
         server_name  _;
-        root         /usr/share/nginx/html;
+        root         /lighthouse;
 
         # Load configuration files for the default server block.
         include /etc/nginx/default.d/*.conf;
@@ -74,11 +74,6 @@
 #        error_page 404 /404.html;
 #            location = /40x.html {
 #        }
-#
-#        error_page 500 502 503 504 /50x.html;
-#            location = /50x.html {
-#        }
 #    }
 
-}
-
+}
\ No newline at end of file

changed: [lighthouse]

TASK [Copy nginx.conf] ************************************************************************************************************************************************************************************
ok: [lighthouse]

PLAY RECAP ************************************************************************************************************************************************************************************************
clickhouse-01              : ok=5    changed=4    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
lighthouse                 : ok=6    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector                     : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.  
```
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

TASK [Vector templates] ***********************************************************************************************************************************************************************************
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If this does not look like what you expect, quote the entire value to ensure it does not change.
ok: [vector]

TASK [Vector systemd unit] ********************************************************************************************************************************************************************************
ok: [vector]

PLAY [Install lighthouse] *********************************************************************************************************************************************************************************

TASK [Gathering Facts] ************************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Install git] ****************************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Install apps for lighthouse] ************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Git clone lighthouse] *******************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Copy nginx.conf] ************************************************************************************************************************************************************************************
ok: [lighthouse]

TASK [Copy nginx.conf] ************************************************************************************************************************************************************************************
ok: [lighthouse]

PLAY RECAP ************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
lighthouse                 : ok=6    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector                     : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 
```
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.  
Решение:  
[README.md](https://github.com/Lepisok/devops-netology/blob/main/3_CI%2C%20monitoring%20and%20settings%20management/08-ansible-03-yandex/playbook/README.md)
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.  
Решение:  
[playbook](https://github.com/Lepisok/devops-netology/tree/main/3_CI%2C%20monitoring%20and%20settings%20management/08-ansible-03-yandex/playbook)
---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---