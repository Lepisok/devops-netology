# Домашнее задание к занятию "5. Тестирование roles"

## Подготовка к выполнению
1. Установите molecule: `pip3 install "molecule==3.5.2"`
2. Выполните `docker pull aragast/netology:latest` -  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри

## Основная часть

Наша основная цель - настроить тестирование наших ролей. Задача: сделать сценарии тестирования для vector. Ожидаемый результат: все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos7` внутри корневой директории clickhouse-role, посмотрите на вывод команды.   
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert'ов в verify.yml файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска, etc). Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.  

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example)
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo - путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini` для того чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

## Решение:  
### Molecule  
### Ход выполнение 
```
lepis@lepis:~/Homework/netology-homework/My_homework/devops-netology/3_CI, monitoring and settings management/vector-role/vector/vector-role$ molecule test  
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy  
INFO     Performing prerun...  
INFO     Set ANSIBLE_LIBRARY=/home/lepis/.cache/ansible-compat/f5bcd7/modules:/home/lepis/.ansible/plugins/modules:/usr/share/ansible/plugins/modules  
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/lepis/.cache/ansible-compat/f5bcd7/collections:/home/lepis/.ansible/collections:/usr/share/ansible/collections  
INFO     Set ANSIBLE_ROLES_PATH=/home/lepis/.cache/ansible-compat/f5bcd7/roles:/home/lepis/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles  
INFO     Running default > dependency  
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos8)
ok: [localhost] => (item=centos7)
ok: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /home/lepis/Homework/netology-homework/My_homework/devops-netology/3_CI, monitoring and settings management/vector-role/vector/vector-role/molecule/default/converge.yml
INFO     Running default > create

PLAY [Create] ******************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost] => (item=None) 
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos8', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos8', 'pre_build_image': True}) 
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}) 
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True}) 
skipping: [localhost]

TASK [Synchronization the context] *********************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos8', 'pre_build_image': True}) 
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}) 
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True}) 
skipping: [localhost]

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos8', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 1, 'ansible_index_var': 'i'})
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item', 'i': 2, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:8) 
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7) 
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest) 
skipping: [localhost]

TASK [Create docker network(s)] ************************************************
skipping: [localhost]

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:8', 'name': 'centos8', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '757701745547.626785', 'results_file': '/home/lepis/.ansible_async/757701745547.626785', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:8', 'name': 'centos8', 'pre_build_image': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '749634441496.626811', 'results_file': '/home/lepis/.ansible_async/749634441496.626811', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '581195577291.626919', 'results_file': '/home/lepis/.ansible_async/581195577291.626919', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=6    changed=2    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running default > prepare

PLAY [Prepare Test Hosts] ******************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu]
ok: [centos8]
ok: [centos7]

TASK [Centos8 -- find repo files] **********************************************
skipping: [ubuntu]
ok: [centos7]
ok: [centos8]

TASK [Disable YUM mirror for Centos8] ******************************************
skipping: [ubuntu]
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660460, 'isgid': False, 'size': 8515, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Vault.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8846056, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
ok: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Debuginfo.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 318, 'inode': 680466, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660461, 'isgid': False, 'size': 314, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-fasttrack.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8846056, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Extras.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 704, 'inode': 680468, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660458, 'isgid': False, 'size': 630, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Media.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-AppStream.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 719, 'inode': 680463, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660459, 'isgid': False, 'size': 1331, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Sources.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
ok: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Media.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 693, 'inode': 680471, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660456, 'isgid': False, 'size': 1309, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-CR.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-PowerTools.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 724, 'inode': 680473, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660457, 'isgid': False, 'size': 649, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Debuginfo.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-HighAvailability.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 740, 'inode': 680470, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660462, 'isgid': False, 'size': 616, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-x86_64-kernel.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8846056, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
ok: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Sources.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 898, 'inode': 680474, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660455, 'isgid': False, 'size': 1664, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Base.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Devel.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 732, 'inode': 680467, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-ContinuousRelease.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 1130, 'inode': 680465, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Plus.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 706, 'inode': 680472, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-FastTrack.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 719, 'inode': 680469, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-BaseOS.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 704, 'inode': 680464, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})

TASK [Switch Centos8 to vault repo] ********************************************
skipping: [ubuntu]
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660460, 'isgid': False, 'size': 8515, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Vault.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8846056, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
ok: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Debuginfo.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 318, 'inode': 680466, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660461, 'isgid': False, 'size': 314, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-fasttrack.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8846056, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Extras.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 704, 'inode': 680468, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660458, 'isgid': False, 'size': 630, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Media.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-AppStream.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 719, 'inode': 680463, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660459, 'isgid': False, 'size': 1331, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Sources.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
ok: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Media.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 693, 'inode': 680471, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660456, 'isgid': False, 'size': 1309, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-CR.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-PowerTools.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 724, 'inode': 680473, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
ok: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660457, 'isgid': False, 'size': 649, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Debuginfo.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-HighAvailability.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 740, 'inode': 680470, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660462, 'isgid': False, 'size': 616, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-x86_64-kernel.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8846056, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
ok: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Sources.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 898, 'inode': 680474, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos7] => (item={'uid': 0, 'woth': False, 'mtime': 1606144121.0, 'inode': 660455, 'isgid': False, 'size': 1664, 'roth': True, 'isuid': False, 'isreg': True, 'pw_name': 'root', 'gid': 0, 'ischr': False, 'wusr': True, 'xoth': False, 'rusr': True, 'nlink': 1, 'issock': False, 'rgrp': True, 'gr_name': 'root', 'path': '/etc/yum.repos.d/CentOS-Base.repo', 'xusr': False, 'atime': 1606144121.0, 'isdir': False, 'ctime': 1676487538.8806057, 'isblk': False, 'xgrp': False, 'dev': 84, 'wgrp': False, 'isfifo': False, 'mode': '0644', 'islnk': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Devel.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 732, 'inode': 680467, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-ContinuousRelease.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 1130, 'inode': 680465, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-Plus.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 706, 'inode': 680472, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-FastTrack.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 719, 'inode': 680469, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})
changed: [centos8] => (item={'path': '/etc/yum.repos.d/CentOS-Linux-BaseOS.repo', 'mode': '0644', 'isdir': False, 'ischr': False, 'isblk': False, 'isreg': True, 'isfifo': False, 'islnk': False, 'issock': False, 'uid': 0, 'gid': 0, 'size': 704, 'inode': 680464, 'dev': 56, 'nlink': 1, 'atime': 1604968320.0, 'mtime': 1604968320.0, 'ctime': 1676487542.0086553, 'gr_name': 'root', 'pw_name': 'root', 'wusr': True, 'rusr': True, 'xusr': False, 'wgrp': False, 'rgrp': True, 'xgrp': False, 'woth': False, 'roth': True, 'xoth': False, 'isuid': False, 'isgid': False})

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
centos8                    : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=1    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0

INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu]
ok: [centos8]
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
skipping: [ubuntu]
changed: [centos7]
changed: [centos8]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]
skipping: [centos8]
changed: [ubuntu]

TASK [vector-role : Vector templates] ******************************************
changed: [centos7]
changed: [centos8]
changed: [ubuntu]

TASK [vector-role : Vector systemd unit] ***************************************
changed: [ubuntu]
changed: [centos8]
changed: [centos7]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
centos8                    : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [centos8]
ok: [ubuntu]
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
skipping: [ubuntu]
ok: [centos7]
ok: [centos8]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]
skipping: [centos8]
ok: [ubuntu]

TASK [vector-role : Vector templates] ******************************************
ok: [ubuntu]
ok: [centos7]
ok: [centos8]

TASK [vector-role : Vector systemd unit] ***************************************
ok: [centos8]
ok: [centos7]
ok: [ubuntu]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
centos8                    : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Get Vector version] ******************************************************
ok: [ubuntu]
ok: [centos8]
ok: [centos7]

TASK [Print Vector version] ****************************************************
ok: [centos7] => {
    "vector_version": {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python"
        },
        "changed": false,
        "cmd": [
            "vector",
            "--version"
        ],
        "delta": "0:00:00.116851",
        "end": "2023-02-18 13:40:14.603372",
        "failed": false,
        "msg": "",
        "rc": 0,
        "start": "2023-02-18 13:40:14.486521",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)",
        "stdout_lines": [
            "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)"
        ]
    }
}
ok: [ubuntu] => {
    "vector_version": {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python3"
        },
        "changed": false,
        "cmd": [
            "vector",
            "--version"
        ],
        "delta": "0:00:00.020986",
        "end": "2023-02-18 13:40:14.396110",
        "failed": false,
        "msg": "",
        "rc": 0,
        "start": "2023-02-18 13:40:14.375124",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)",
        "stdout_lines": [
            "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)"
        ]
    }
}
ok: [centos8] => {
    "vector_version": {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/libexec/platform-python"
        },
        "changed": false,
        "cmd": [
            "vector",
            "--version"
        ],
        "delta": "0:00:00.011031",
        "end": "2023-02-18 13:40:14.494847",
        "failed": false,
        "msg": "",
        "rc": 0,
        "start": "2023-02-18 13:40:14.483816",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)",
        "stdout_lines": [
            "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)"
        ]
    }
}

TASK [Get Vector Validate Config] **********************************************
ok: [ubuntu]
ok: [centos7]
ok: [centos8]

PLAY RECAP *********************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
centos8                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy

PLAY [Destroy] *****************************************************************

TASK [Set async_dir for HOME env] **********************************************
ok: [localhost]

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item=centos8)
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Delete docker networks(s)] ***********************************************
skipping: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
```
### Репозиторий vector
[vector](https://github.com/Lepisok/vector/tree/v0.2)  

## Решение:  
### TOX  
### Ход выполнение

```
lepis@lepis:~/Homework/netology-homework/My_homework/devops-netology/3_CI, monitoring and settings management/vector-role/vector/vector-role$ docker run --privileged=True -v /home/lepis/Homework/netology-homework/My_homework/devops-netology/3_CI_monitoring_and_settings_management/vector-role/vector/vector-role/:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash
[root@880d8c2b13ab vector-role]# tox
py37-ansible210 create: /opt/vector-role/.tox/py37-ansible210
py37-ansible210 installdeps: -rtox-requirements.txt, ansible<3.0
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.0.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.1,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.14.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='3665268761'
py37-ansible210 run-test: commands[0] | molecule test -s compatibility --destroy always
CRITICAL 'molecule/compatibility/molecule.yml' glob failed.  Exiting.
ERROR: InvocationError for command /opt/vector-role/.tox/py37-ansible210/bin/molecule test -s compatibility --destroy always (exited with code 1)
```
## Финальный запуск tox
    <details>
    <summary>Финальный запуск tox</summary>
``` bash
        [root@19fa213cc765 vector-role]# tox
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.0.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.1,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.14.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='1407121400'
py37-ansible210 run-test: commands[0] | molecule test -s molecule-podman --destroy always
INFO     molecule-podman scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
WARNING  Failed to locate command: [Errno 2] No such file or directory: 'git': 'git'
INFO     Guessed /opt/vector-role as project root directory
INFO     Using /root/.cache/ansible-lint/b984a4/roles/test.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running molecule-podman > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running molecule-podman > lint
INFO     Lint is disabled.
INFO     Running molecule-podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running molecule-podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '407177956629.9256', 'results_file': '/root/.ansible_async/407177956629.9256', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '337382872818.9278', 'results_file': '/root/.ansible_async/337382872818.9278', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running molecule-podman > syntax

playbook: /opt/vector-role/molecule/molecule-podman/converge.yml
INFO     Running molecule-podman > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="centos7 registry username: None specified") 
skipping: [localhost] => (item="ubuntu registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/centos:7") 
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/ubuntu:latest") 

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=centos7)
ok: [localhost] => (item=ubuntu)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/pycontribs/centos:7) 
skipping: [localhost] => (item=docker.io/pycontribs/ubuntu:latest) 

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="centos7 command: None specified")
ok: [localhost] => (item="ubuntu command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=centos7: None specified) 
skipping: [localhost] => (item=ubuntu: None specified) 

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running molecule-podman > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running molecule-podman > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
skipping: [ubuntu]
changed: [centos7]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]
[WARNING]: Updating cache and auto-installing missing dependency: python-apt
changed: [ubuntu]

TASK [vector-role : Vector templates] ******************************************
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
changed: [centos7]
changed: [ubuntu]

TASK [vector-role : Vector systemd unit] ***************************************
changed: [centos7]
changed: [ubuntu]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running molecule-podman > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
skipping: [ubuntu]
ok: [centos7]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]
ok: [ubuntu]

TASK [vector-role : Vector templates] ******************************************
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
ok: [centos7]
ok: [ubuntu]

TASK [vector-role : Vector systemd unit] ***************************************
ok: [centos7]
ok: [ubuntu]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running molecule-podman > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running molecule-podman > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Get Vector version] ******************************************************
ok: [centos7]
ok: [ubuntu]

TASK [Print Vector version] ****************************************************
ok: [centos7] => {
    "vector_version": {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python"
        },
        "changed": false,
        "cmd": [
            "vector",
            "--version"
        ],
        "delta": "0:00:00.068880",
        "end": "2023-02-18 14:59:25.875297",
        "failed": false,
        "msg": "",
        "rc": 0,
        "start": "2023-02-18 14:59:25.806417",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)",
        "stdout_lines": [
            "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)"
        ]
    }
}
ok: [ubuntu] => {
    "vector_version": {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python"
        },
        "changed": false,
        "cmd": [
            "vector",
            "--version"
        ],
        "delta": "0:00:00.082670",
        "end": "2023-02-18 14:59:25.778585",
        "failed": false,
        "msg": "",
        "rc": 0,
        "start": "2023-02-18 14:59:25.695915",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)",
        "stdout_lines": [
            "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)"
        ]
    }
}

TASK [Get Vector Validate Config] **********************************************
ok: [ubuntu]
ok: [centos7]

PLAY RECAP *********************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running molecule-podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running molecule-podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '801603080484.13729', 'results_file': '/root/.ansible_async/801603080484.13729', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '258341292911.13749', 'results_file': '/root/.ansible_async/258341292911.13749', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py37-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.1.3,arrow==1.2.3,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,importlib-metadata==6.0.0,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.2.1,text-unidecode==1.3,typing_extensions==4.5.0,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3,zipp==3.14.0
py37-ansible30 run-test-pre: PYTHONHASHSEED='1407121400'
py37-ansible30 run-test: commands[0] | molecule test -s molecule-podman --destroy always
INFO     molecule-podman scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
WARNING  Failed to locate command: [Errno 2] No such file or directory: 'git': 'git'
INFO     Guessed /opt/vector-role as project root directory
INFO     Using /root/.cache/ansible-lint/b984a4/roles/test.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running molecule-podman > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running molecule-podman > lint
INFO     Lint is disabled.
INFO     Running molecule-podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running molecule-podman > destroy
INFO     Sanity checks: 'podman'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True})

TASK [Wait for instance(s) deletion to complete] *******************************
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '926358426540.13946', 'results_file': '/root/.ansible_async/926358426540.13946', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '51755328505.13968', 'results_file': '/root/.ansible_async/51755328505.13968', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running molecule-podman > syntax

playbook: /opt/vector-role/molecule/molecule-podman/converge.yml
INFO     Running molecule-podman > create

PLAY [Create] ******************************************************************

TASK [get podman executable path] **********************************************
ok: [localhost]

TASK [save path to executable as fact] *****************************************
ok: [localhost]

TASK [Log into a container registry] *******************************************
skipping: [localhost] => (item="centos7 registry username: None specified") 
skipping: [localhost] => (item="ubuntu registry username: None specified") 

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item=Dockerfile: None specified)
ok: [localhost] => (item=Dockerfile: None specified)

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/centos:7") 
skipping: [localhost] => (item="Dockerfile: None specified; Image: docker.io/pycontribs/ubuntu:latest") 

TASK [Discover local Podman images] ********************************************
ok: [localhost] => (item=centos7)
ok: [localhost] => (item=ubuntu)

TASK [Build an Ansible compatible image] ***************************************
skipping: [localhost] => (item=docker.io/pycontribs/centos:7) 
skipping: [localhost] => (item=docker.io/pycontribs/ubuntu:latest) 

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item="centos7 command: None specified")
ok: [localhost] => (item="ubuntu command: None specified")

TASK [Remove possible pre-existing containers] *********************************
changed: [localhost]

TASK [Discover local podman networks] ******************************************
skipping: [localhost] => (item=centos7: None specified) 
skipping: [localhost] => (item=ubuntu: None specified) 

TASK [Create podman network dedicated to this scenario] ************************
skipping: [localhost]

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

TASK [Wait for instance(s) creation to complete] *******************************
changed: [localhost] => (item=centos7)
changed: [localhost] => (item=ubuntu)

PLAY RECAP *********************************************************************
localhost                  : ok=8    changed=3    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running molecule-podman > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running molecule-podman > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
skipping: [ubuntu]
changed: [centos7]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]
[WARNING]: Updating cache and auto-installing missing dependency: python-apt
changed: [ubuntu]

TASK [vector-role : Vector templates] ******************************************
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
changed: [centos7]
changed: [ubuntu]

TASK [vector-role : Vector systemd unit] ***************************************
changed: [centos7]
changed: [ubuntu]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running molecule-podman > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [ubuntu]
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
skipping: [ubuntu]
ok: [centos7]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]
ok: [ubuntu]

TASK [vector-role : Vector templates] ******************************************
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
ok: [centos7]
ok: [ubuntu]

TASK [vector-role : Vector systemd unit] ***************************************
ok: [centos7]
ok: [ubuntu]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
ubuntu                     : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running molecule-podman > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running molecule-podman > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Get Vector version] ******************************************************
ok: [centos7]
ok: [ubuntu]

TASK [Print Vector version] ****************************************************
ok: [centos7] => {
    "vector_version": {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python"
        },
        "changed": false,
        "cmd": [
            "vector",
            "--version"
        ],
        "delta": "0:00:00.080114",
        "end": "2023-02-18 15:04:22.523890",
        "failed": false,
        "msg": "",
        "rc": 0,
        "start": "2023-02-18 15:04:22.443776",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)",
        "stdout_lines": [
            "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)"
        ]
    }
}
ok: [ubuntu] => {
    "vector_version": {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python"
        },
        "changed": false,
        "cmd": [
            "vector",
            "--version"
        ],
        "delta": "0:00:00.074866",
        "end": "2023-02-18 15:04:22.577128",
        "failed": false,
        "msg": "",
        "rc": 0,
        "start": "2023-02-18 15:04:22.502262",
        "stderr": "",
        "stderr_lines": [],
        "stdout": "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)",
        "stdout_lines": [
            "vector 0.22.1 (x86_64-unknown-linux-gnu b633e95 2022-06-10)"
        ]
    }
}

TASK [Get Vector Validate Config] **********************************************
ok: [ubuntu]
ok: [centos7]

PLAY RECAP *********************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running molecule-podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running molecule-podman > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True})
changed: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True})

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) deletion to complete (299 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '884375101151.18410', 'results_file': '/root/.ansible_async/884375101151.18410', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '475408801195.18430', 'results_file': '/root/.ansible_async/475408801195.18430', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'ubuntu', 'pre_build_image': True, 'privileged': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
py39-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==3.0.1,ansible-core==2.14.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==22.2.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,jsonschema==4.17.3,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,pyrsistent==0.19.3,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,resolvelib==0.8.1,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.1,text-unidecode==1.3,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible210 run-test-pre: PYTHONHASHSEED='1407121400'
py39-ansible210 run-test: commands[0] | molecule test -s molecule-podman --destroy always
INFO     molecule-podman scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
WARNING  Failed to locate command: [Errno 2] No such file or directory: 'git'
INFO     Guessed /opt/vector-role as project root directory
INFO     Using /root/.cache/ansible-lint/b984a4/roles/test.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running molecule-podman > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running molecule-podman > lint
INFO     Lint is disabled.
INFO     Running molecule-podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running molecule-podman > destroy
INFO     Sanity checks: 'podman'
Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible210/bin/molecule", line 8, in <module>
    sys.exit(main())
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1130, in __call__
    return self.main(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1055, in main
    rv = self.invoke(ctx)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1657, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 1404, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/core.py", line 760, in invoke
    return __callback(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/click/decorators.py", line 26, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/test.py", line 159, in test
    base.execute_cmdline_scenarios(scenario_name, args, command_args, ansible_args)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 119, in execute_cmdline_scenarios
    execute_scenario(scenario)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 161, in execute_scenario
    execute_subcommand(scenario.config, action)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/base.py", line 150, in execute_subcommand
    return command(config).execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/logger.py", line 187, in wrapper
    rt = func(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/command/destroy.py", line 107, in execute
    self._config.provisioner.destroy()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/provisioner/ansible.py", line 705, in destroy
    pb.execute()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule/provisioner/ansible_playbook.py", line 106, in execute
    self._config.driver.sanity_checks()
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/molecule_podman/driver.py", line 212, in sanity_checks
    if runtime.version < Version("2.10.0") and runtime.config.ansible_pipelining:
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/runtime.py", line 208, in version
    self._version = parse_ansible_version(proc.stdout)
  File "/opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible_compat/config.py", line 39, in parse_ansible_version
    raise InvalidPrerequisiteError(
ansible_compat.errors.InvalidPrerequisiteError: Unable to parse ansible cli version: ansible 2.10.17
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /opt/vector-role/.tox/py39-ansible210/lib/python3.9/site-packages/ansible
  executable location = /opt/vector-role/.tox/py39-ansible210/bin/ansible
  python version = 3.9.2 (default, Jun 13 2022, 19:42:33) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]

Keep in mind that only 2.12 or newer are supported.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible210/bin/molecule test -s molecule-podman --destroy always (exited with code 1)
py39-ansible30 installed: ansible==3.0.0,ansible-base==2.10.17,ansible-compat==3.0.1,ansible-core==2.14.2,ansible-lint==5.1.3,arrow==1.2.3,attrs==22.2.0,bcrypt==4.0.1,binaryornot==0.4.4,bracex==2.3.post1,Cerberus==1.3.2,certifi==2022.12.7,cffi==1.15.1,chardet==5.1.0,charset-normalizer==3.0.1,click==8.1.3,click-help-colors==0.9.1,cookiecutter==2.1.1,cryptography==39.0.1,distro==1.8.0,enrich==1.2.7,idna==3.4,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.1,jsonschema==4.17.3,lxml==4.9.2,markdown-it-py==2.1.0,MarkupSafe==2.1.2,mdurl==0.1.2,molecule==3.4.0,molecule-podman==1.0.1,packaging==23.0,paramiko==2.12.0,pathspec==0.11.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.14.0,PyNaCl==1.5.0,pyrsistent==0.19.3,python-dateutil==2.8.2,python-slugify==8.0.0,PyYAML==5.4.1,requests==2.28.2,resolvelib==0.8.1,rich==13.3.1,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.7,selinux==0.3.0,six==1.16.0,subprocess-tee==0.4.1,tenacity==8.2.1,text-unidecode==1.3,urllib3==1.26.14,wcmatch==8.4.1,yamllint==1.26.3
py39-ansible30 run-test-pre: PYTHONHASHSEED='1407121400'
py39-ansible30 run-test: commands[0] | molecule test -s molecule-podman --destroy always
INFO     molecule-podman scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
WARNING  Failed to locate command: [Errno 2] No such file or directory: 'git'
INFO     Guessed /opt/vector-role as project root directory
INFO     Using /root/.cache/ansible-lint/b984a4/roles/test.vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running molecule-podman > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running molecule-podman > lint
INFO     Lint is disabled.
INFO     Running molecule-podman > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running molecule-podman > destroy
INFO     Sanity checks: 'podman'
Traceback (most recent call last):
  File "/opt/vector-role/.tox/py39-ansible30/bin/molecule", line 8, in <module>
    sys.exit(main())
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1130, in __call__
    return self.main(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1055, in main
    rv = self.invoke(ctx)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1657, in invoke
    return _process_result(sub_ctx.command.invoke(sub_ctx))
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 1404, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/core.py", line 760, in invoke
    return __callback(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/click/decorators.py", line 26, in new_func
    return f(get_current_context(), *args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/test.py", line 159, in test
    base.execute_cmdline_scenarios(scenario_name, args, command_args, ansible_args)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 119, in execute_cmdline_scenarios
    execute_scenario(scenario)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 161, in execute_scenario
    execute_subcommand(scenario.config, action)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/base.py", line 150, in execute_subcommand
    return command(config).execute()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/logger.py", line 187, in wrapper
    rt = func(*args, **kwargs)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/command/destroy.py", line 107, in execute
    self._config.provisioner.destroy()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/provisioner/ansible.py", line 705, in destroy
    pb.execute()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule/provisioner/ansible_playbook.py", line 106, in execute
    self._config.driver.sanity_checks()
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/molecule_podman/driver.py", line 212, in sanity_checks
    if runtime.version < Version("2.10.0") and runtime.config.ansible_pipelining:
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible_compat/runtime.py", line 208, in version
    self._version = parse_ansible_version(proc.stdout)
  File "/opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible_compat/config.py", line 39, in parse_ansible_version
    raise InvalidPrerequisiteError(
ansible_compat.errors.InvalidPrerequisiteError: Unable to parse ansible cli version: ansible 2.10.17
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /opt/vector-role/.tox/py39-ansible30/lib/python3.9/site-packages/ansible
  executable location = /opt/vector-role/.tox/py39-ansible30/bin/ansible
  python version = 3.9.2 (default, Jun 13 2022, 19:42:33) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]

Keep in mind that only 2.12 or newer are supported.
ERROR: InvocationError for command /opt/vector-role/.tox/py39-ansible30/bin/molecule test -s molecule-podman --destroy always (exited with code 1)
___________________________________________________________________________ summary ____________________________________________________________________________
  py37-ansible210: commands succeeded
  py37-ansible30: commands succeeded
ERROR:   py39-ansible210: commands failed
ERROR:   py39-ansible30: commands failed
```
    </details>
## Необязательная часть

1. Проделайте схожие манипуляции для создания роли lighthouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
