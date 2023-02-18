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

Решение:  
### Molecule  
### Ход выполнение 
>! lepis@lepis:~/Homework/netology-homework/My_homework/devops-netology/3_CI, monitoring and settings management/vector-role/vector/vector-role$ molecule test
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
## Необязательная часть

1. Проделайте схожие манипуляции для создания роли lighthouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
