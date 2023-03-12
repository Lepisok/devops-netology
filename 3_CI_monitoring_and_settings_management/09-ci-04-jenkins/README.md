# Домашнее задание к занятию "10.Jenkins"

## Подготовка к выполнению

1. Создать 2 VM: для jenkins-master и jenkins-agent.
2. Установить jenkins при помощи playbook'a.
3. Запустить и проверить работоспособность.
4. Сделать первоначальную настройку.

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.  
Решение:  
<details>
      <summary>molecule test</summary>
      
```bash
Started by user admin
Running as SYSTEM
Building remotely on test in workspace /opt/jenkins_agent/workspace/Freestyle_Job
The recommended git tool is: NONE
using credential e7574c24-0a42-4dd7-a011-293bea349028
 > git rev-parse --resolve-git-dir /opt/jenkins_agent/workspace/Freestyle_Job/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/Lepisok/devops-netology # timeout=10
Fetching upstream changes from https://github.com/Lepisok/devops-netology
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/Freestyle_Job@tmp/jenkins-gitclient-ssh322909493057746192.key
Verifying host key using known hosts file
You're using 'Known hosts file' strategy to verify ssh host keys, but your known_hosts file does not exist, please go to 'Manage Jenkins' -> 'Configure Global Security' -> 'Git Host Key Verification Configuration' and configure host key verification.
 > git fetch --tags --progress https://github.com/Lepisok/devops-netology +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision eeb6d1cdb2b3f2f5e0cfede26df4d8cc9046e834 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f eeb6d1cdb2b3f2f5e0cfede26df4d8cc9046e834 # timeout=10
Commit message: "add 08-ansible-05-testing"
 > git rev-list --no-walk b5d22b9335bb6ff5ec47206e6caa7cfba4ab8495 # timeout=10
[Freestyle_Job] $ /bin/sh -xe /tmp/jenkins1916896624983016431.sh
+ cd 3_CI_monitoring_and_settings_management/09-ci-04-jenkins/mnt-homeworks-ansible/roles/vector-role/
+ ls -la
total 12
drwxr-xr-x. 10 jenkins users 181 Mar 12 15:47 .
drwxr-xr-x.  3 jenkins users  25 Mar 12 15:47 ..
drwxr-xr-x.  2 jenkins users  22 Mar 12 15:47 defaults
drwxr-xr-x.  2 jenkins users  22 Mar 12 15:47 handlers
drwxr-xr-x.  2 jenkins users  22 Mar 12 15:47 meta
drwxr-xr-x.  3 jenkins users  21 Mar 12 15:47 molecule
-rw-r--r--.  1 jenkins users 726 Mar 12 15:47 README.md
drwxr-xr-x.  2 jenkins users  22 Mar 12 15:47 tasks
drwxr-xr-x.  2 jenkins users  52 Mar 12 15:47 templates
drwxr-xr-x.  2 jenkins users  39 Mar 12 15:47 tests
-rw-r--r--.  1 jenkins users 286 Mar 12 15:47 tox.ini
-rw-r--r--.  1 jenkins users  91 Mar 12 15:47 tox-requirements.txt
drwxr-xr-x.  2 jenkins users  22 Mar 12 15:47 vars
+ pip3 install --upgrade requests==2.23.0
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: requests==2.23.0 in /home/jenkins/.local/lib/python3.6/site-packages (2.23.0)
Requirement already satisfied: idna<3,>=2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (2.10)
Requirement already satisfied: chardet<4,>=3.0.2 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (3.0.4)
Requirement already satisfied: urllib3!=1.25.0,!=1.25.1,<1.26,>=1.21.1 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (1.25.11)
Requirement already satisfied: certifi>=2017.4.17 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (2022.12.7)
+ ansible-galaxy collection install community.docker
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Skipping 'community.docker' as it is already installed
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
+ pip3 install molecule molecule-docker
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: molecule in /home/jenkins/.local/lib/python3.6/site-packages (3.5.2)
Requirement already satisfied: molecule-docker in /home/jenkins/.local/lib/python3.6/site-packages (1.1.0)
Requirement already satisfied: importlib-metadata in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (4.8.3)
Requirement already satisfied: selinux in /usr/local/lib/python3.6/site-packages (from molecule) (0.2.1)
Requirement already satisfied: click-help-colors>=0.9 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (0.9.1)
Requirement already satisfied: dataclasses in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (0.8)
Requirement already satisfied: cookiecutter>=1.7.3 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.7.3)
Requirement already satisfied: subprocess-tee>=0.3.5 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (0.3.5)
Requirement already satisfied: ansible-compat>=0.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.0.0)
Requirement already satisfied: Jinja2>=2.11.3 in /usr/local/lib/python3.6/site-packages (from molecule) (3.0.3)
Requirement already satisfied: rich>=9.5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (12.6.0)
Requirement already satisfied: PyYAML<6,>=5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (5.4.1)
Requirement already satisfied: click<9,>=8.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (8.0.4)
Requirement already satisfied: enrich>=1.2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.2.7)
Requirement already satisfied: paramiko<3,>=2.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (2.12.0)
Requirement already satisfied: pluggy<2.0,>=0.7.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.0.0)
Requirement already satisfied: packaging in /usr/local/lib/python3.6/site-packages (from molecule) (21.3)
Requirement already satisfied: cerberus!=1.3.3,!=1.3.4,>=1.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.3.2)
Requirement already satisfied: docker>=4.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule-docker) (5.0.3)
Requirement already satisfied: requests in /home/jenkins/.local/lib/python3.6/site-packages (from molecule-docker) (2.23.0)
Requirement already satisfied: cached-property~=1.5 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-compat>=0.5.0->molecule) (1.5.2)
Requirement already satisfied: setuptools in /usr/local/lib/python3.6/site-packages (from cerberus!=1.3.3,!=1.3.4,>=1.3.1->molecule) (59.6.0)
Requirement already satisfied: python-slugify>=4.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (6.1.2)
Requirement already satisfied: six>=1.10 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (1.16.0)
Requirement already satisfied: poyo>=0.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (0.5.0)
Requirement already satisfied: jinja2-time>=0.2.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (0.2.0)
Requirement already satisfied: binaryornot>=0.4.4 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (0.4.4)
Requirement already satisfied: websocket-client>=0.32.0 in /home/jenkins/.local/lib/python3.6/site-packages (from docker>=4.3.1->molecule-docker) (1.3.1)
Requirement already satisfied: MarkupSafe>=2.0 in /usr/local/lib64/python3.6/site-packages (from Jinja2>=2.11.3->molecule) (2.0.1)
Requirement already satisfied: bcrypt>=3.1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule) (4.0.1)
Requirement already satisfied: pynacl>=1.0.1 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule) (1.5.0)
Requirement already satisfied: cryptography>=2.5 in /usr/local/lib64/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule) (39.0.2)
Requirement already satisfied: typing-extensions>=3.6.4 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule) (4.1.1)
Requirement already satisfied: zipp>=0.5 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule) (3.6.0)
Requirement already satisfied: idna<3,>=2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker) (2.10)
Requirement already satisfied: chardet<4,>=3.0.2 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker) (3.0.4)
Requirement already satisfied: urllib3!=1.25.0,!=1.25.1,<1.26,>=1.21.1 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker) (1.25.11)
Requirement already satisfied: certifi>=2017.4.17 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker) (2022.12.7)
Requirement already satisfied: commonmark<0.10.0,>=0.9.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule) (0.9.1)
Requirement already satisfied: pygments<3.0.0,>=2.6.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule) (2.14.0)
Requirement already satisfied: pyparsing!=3.0.5,>=2.0.2 in /usr/local/lib/python3.6/site-packages (from packaging->molecule) (3.0.9)
Requirement already satisfied: distro>=1.3.0 in /usr/local/lib/python3.6/site-packages (from selinux->molecule) (1.8.0)
Requirement already satisfied: cffi>=1.12 in /usr/local/lib64/python3.6/site-packages (from cryptography>=2.5->paramiko<3,>=2.5.0->molecule) (1.15.1)
Requirement already satisfied: arrow in /home/jenkins/.local/lib/python3.6/site-packages (from jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule) (1.2.3)
Requirement already satisfied: text-unidecode>=1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from python-slugify>=4.0.0->cookiecutter>=1.7.3->molecule) (1.3)
Requirement already satisfied: pycparser in /usr/local/lib/python3.6/site-packages (from cffi>=1.12->cryptography>=2.5->paramiko<3,>=2.5.0->molecule) (2.21)
Requirement already satisfied: python-dateutil>=2.7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from arrow->jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule) (2.8.2)
+ molecule test
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/jenkins/.cache/ansible-compat/0c68c0/modules:/home/jenkins/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/jenkins/.cache/ansible-compat/0c68c0/collections:/home/jenkins/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/jenkins/.cache/ansible-compat/0c68c0/roles:/home/jenkins/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
ok: [localhost] => (item=centos7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /opt/jenkins_agent/workspace/Freestyle_Job/3_CI_monitoring_and_settings_management/09-ci-04-jenkins/mnt-homeworks-ansible/roles/vector-role/molecule/default/converge.yml
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
INFO     Running default > create
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (298 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (297 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '321819093417.13435', 'results_file': '/home/jenkins/.ansible_async/321819093417.13435', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
changed: [centos7]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]

TASK [vector-role : Vector templates] ******************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
changed: [centos7]

TASK [vector-role : Vector systemd unit] ***************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
changed: [centos7]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
ok: [centos7]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]

TASK [vector-role : Vector templates] ******************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
ok: [centos7]

TASK [vector-role : Vector systemd unit] ***************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
ok: [centos7]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier
WARNING  Skipping, verify playbook not configured.
INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
Finished: SUCCESS
```
</details>


2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.  
Решение:  
<details>
      <summary>Declarative Pipeline Job</summary>
      
```bash
Started by user admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on test in /opt/jenkins_agent/workspace/Declarative Pipeline Job
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Git)
[Pipeline] git
The recommended git tool is: NONE
using credential e7574c24-0a42-4dd7-a011-293bea349028
Cloning the remote Git repository
Cloning repository https://github.com/Lepisok/devops-netology
 > git init /opt/jenkins_agent/workspace/Declarative Pipeline Job # timeout=10
Fetching upstream changes from https://github.com/Lepisok/devops-netology
 > git --version # timeout=10
 > git --version # 'git version 1.8.3.1'
using GIT_SSH to set credentials 
[INFO] Currently running in a labeled security context
[INFO] Currently SELinux is 'enforcing' on the host
 > /usr/bin/chcon --type=ssh_home_t /opt/jenkins_agent/workspace/Declarative Pipeline Job@tmp/jenkins-gitclient-ssh11266235158124643256.key
Verifying host key using known hosts file
You're using 'Known hosts file' strategy to verify ssh host keys, but your known_hosts file does not exist, please go to 'Manage Jenkins' -> 'Configure Global Security' -> 'Git Host Key Verification Configuration' and configure host key verification.
 > git fetch --tags --progress https://github.com/Lepisok/devops-netology +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
Checking out Revision 860590e667ea1bbe28b3159545b613d687c5f37b (refs/remotes/origin/main)
 > git config remote.origin.url https://github.com/Lepisok/devops-netology # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 860590e667ea1bbe28b3159545b613d687c5f37b # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git checkout -b main 860590e667ea1bbe28b3159545b613d687c5f37b # timeout=10
Commit message: "add 09-ci-04-jenkins"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Prepare molecule)
[Pipeline] sh
+ pip3 install --upgrade requests==2.23.0
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: requests==2.23.0 in /home/jenkins/.local/lib/python3.6/site-packages (2.23.0)
Requirement already satisfied: certifi>=2017.4.17 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (2022.12.7)
Requirement already satisfied: idna<3,>=2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (2.10)
Requirement already satisfied: chardet<4,>=3.0.2 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (3.0.4)
Requirement already satisfied: urllib3!=1.25.0,!=1.25.1,<1.26,>=1.21.1 in /home/jenkins/.local/lib/python3.6/site-packages (from requests==2.23.0) (1.25.11)
+ ansible-galaxy collection install community.docker
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Skipping 'community.docker' as it is already installed
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
+ pip3 install molecule molecule-docker
Defaulting to user installation because normal site-packages is not writeable
Requirement already satisfied: molecule in /home/jenkins/.local/lib/python3.6/site-packages (3.5.2)
Requirement already satisfied: molecule-docker in /home/jenkins/.local/lib/python3.6/site-packages (1.1.0)
Requirement already satisfied: PyYAML<6,>=5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (5.4.1)
Requirement already satisfied: ansible-compat>=0.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.0.0)
Requirement already satisfied: click<9,>=8.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (8.0.4)
Requirement already satisfied: pluggy<2.0,>=0.7.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.0.0)
Requirement already satisfied: selinux in /usr/local/lib/python3.6/site-packages (from molecule) (0.2.1)
Requirement already satisfied: cookiecutter>=1.7.3 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.7.3)
Requirement already satisfied: importlib-metadata in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (4.8.3)
Requirement already satisfied: rich>=9.5.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (12.6.0)
Requirement already satisfied: subprocess-tee>=0.3.5 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (0.3.5)
Requirement already satisfied: enrich>=1.2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.2.7)
Requirement already satisfied: cerberus!=1.3.3,!=1.3.4,>=1.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (1.3.2)
Requirement already satisfied: packaging in /usr/local/lib/python3.6/site-packages (from molecule) (21.3)
Requirement already satisfied: Jinja2>=2.11.3 in /usr/local/lib/python3.6/site-packages (from molecule) (3.0.3)
Requirement already satisfied: dataclasses in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (0.8)
Requirement already satisfied: paramiko<3,>=2.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (2.12.0)
Requirement already satisfied: click-help-colors>=0.9 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule) (0.9.1)
Requirement already satisfied: docker>=4.3.1 in /home/jenkins/.local/lib/python3.6/site-packages (from molecule-docker) (5.0.3)
Requirement already satisfied: requests in /home/jenkins/.local/lib/python3.6/site-packages (from molecule-docker) (2.23.0)
Requirement already satisfied: cached-property~=1.5 in /home/jenkins/.local/lib/python3.6/site-packages (from ansible-compat>=0.5.0->molecule) (1.5.2)
Requirement already satisfied: setuptools in /usr/local/lib/python3.6/site-packages (from cerberus!=1.3.3,!=1.3.4,>=1.3.1->molecule) (59.6.0)
Requirement already satisfied: poyo>=0.5.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (0.5.0)
Requirement already satisfied: jinja2-time>=0.2.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (0.2.0)
Requirement already satisfied: python-slugify>=4.0.0 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (6.1.2)
Requirement already satisfied: six>=1.10 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (1.16.0)
Requirement already satisfied: binaryornot>=0.4.4 in /home/jenkins/.local/lib/python3.6/site-packages (from cookiecutter>=1.7.3->molecule) (0.4.4)
Requirement already satisfied: websocket-client>=0.32.0 in /home/jenkins/.local/lib/python3.6/site-packages (from docker>=4.3.1->molecule-docker) (1.3.1)
Requirement already satisfied: MarkupSafe>=2.0 in /usr/local/lib64/python3.6/site-packages (from Jinja2>=2.11.3->molecule) (2.0.1)
Requirement already satisfied: cryptography>=2.5 in /usr/local/lib64/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule) (39.0.2)
Requirement already satisfied: pynacl>=1.0.1 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule) (1.5.0)
Requirement already satisfied: bcrypt>=3.1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from paramiko<3,>=2.5.0->molecule) (4.0.1)
Requirement already satisfied: zipp>=0.5 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule) (3.6.0)
Requirement already satisfied: typing-extensions>=3.6.4 in /home/jenkins/.local/lib/python3.6/site-packages (from importlib-metadata->molecule) (4.1.1)
Requirement already satisfied: urllib3!=1.25.0,!=1.25.1,<1.26,>=1.21.1 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker) (1.25.11)
Requirement already satisfied: idna<3,>=2.5 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker) (2.10)
Requirement already satisfied: certifi>=2017.4.17 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker) (2022.12.7)
Requirement already satisfied: chardet<4,>=3.0.2 in /home/jenkins/.local/lib/python3.6/site-packages (from requests->molecule-docker) (3.0.4)
Requirement already satisfied: pygments<3.0.0,>=2.6.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule) (2.14.0)
Requirement already satisfied: commonmark<0.10.0,>=0.9.0 in /home/jenkins/.local/lib/python3.6/site-packages (from rich>=9.5.1->molecule) (0.9.1)
Requirement already satisfied: pyparsing!=3.0.5,>=2.0.2 in /usr/local/lib/python3.6/site-packages (from packaging->molecule) (3.0.9)
Requirement already satisfied: distro>=1.3.0 in /usr/local/lib/python3.6/site-packages (from selinux->molecule) (1.8.0)
Requirement already satisfied: cffi>=1.12 in /usr/local/lib64/python3.6/site-packages (from cryptography>=2.5->paramiko<3,>=2.5.0->molecule) (1.15.1)
Requirement already satisfied: arrow in /home/jenkins/.local/lib/python3.6/site-packages (from jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule) (1.2.3)
Requirement already satisfied: text-unidecode>=1.3 in /home/jenkins/.local/lib/python3.6/site-packages (from python-slugify>=4.0.0->cookiecutter>=1.7.3->molecule) (1.3)
Requirement already satisfied: pycparser in /usr/local/lib/python3.6/site-packages (from cffi>=1.12->cryptography>=2.5->paramiko<3,>=2.5.0->molecule) (2.21)
Requirement already satisfied: python-dateutil>=2.7.0 in /home/jenkins/.local/lib/python3.6/site-packages (from arrow->jinja2-time>=0.2.0->cookiecutter>=1.7.3->molecule) (2.8.2)
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Molecule)
[Pipeline] sh
+ cd 3_CI_monitoring_and_settings_management/09-ci-04-jenkins/mnt-homeworks-ansible/roles/vector-role/
+ molecule test
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Set ANSIBLE_LIBRARY=/home/jenkins/.cache/ansible-compat/de5a40/modules:/home/jenkins/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/jenkins/.cache/ansible-compat/de5a40/collections:/home/jenkins/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/jenkins/.cache/ansible-compat/de5a40/roles:/home/jenkins/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > lint
INFO     Lint is disabled.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) deletion to complete] *******************************
ok: [localhost] => (item=centos7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > syntax

playbook: /opt/jenkins_agent/workspace/Declarative Pipeline Job/3_CI_monitoring_and_settings_management/09-ci-04-jenkins/mnt-homeworks-ansible/roles/vector-role/molecule/default/converge.yml
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
INFO     Running default > create
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None)
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7)

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (298 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (297 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '126048695282.16922', 'results_file': '/home/jenkins/.ansible_async/126048695282.16922', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'centos7', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running default > prepare
WARNING  Skipping, prepare playbook not configured.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
changed: [centos7]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]

TASK [vector-role : Vector templates] ******************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
changed: [centos7]

TASK [vector-role : Vector systemd unit] ***************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
changed: [centos7]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=3    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running default > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
ok: [centos7]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Install Vector RPM] ****************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
ok: [centos7]

TASK [vector-role : Install Vector DEB] ****************************************
skipping: [centos7]

TASK [vector-role : Vector templates] ******************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
[WARNING]: The value "0" (type int) was converted to "u'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
ok: [centos7]

TASK [vector-role : Vector systemd unit] ***************************************
[WARNING]: Collection community.docker does not support Ansible version 2.10.17
ok: [centos7]

PLAY RECAP *********************************************************************
centos7                    : ok=4    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running default > side_effect
WARNING  Skipping, side effect playbook not configured.
INFO     Running default > verify
INFO     Running Ansible Verifier
WARNING  Skipping, verify playbook not configured.
INFO     Verifier completed successfully.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
/usr/local/lib/python3.6/site-packages/ansible/parsing/vault/__init__.py:44: CryptographyDeprecationWarning: Python 3.6 is no longer supported by the Python core team. Therefore, support for it is deprecated in cryptography. The next release of cryptography (40.0) will be the last to support Python 3.6.
  from cryptography.exceptions import InvalidSignature
[WARNING]: Collection community.docker does not support Ansible version 2.10.17

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=centos7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```
</details>  

3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.  
[Jenkinsfile](https://github.com/Lepisok/devops-netology/blob/main/3_CI_monitoring_and_settings_management/09-ci-04-jenkins/pipeline/Jenkinsfile)  
4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.  
5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).  
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True), по умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.  
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.  
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.  

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, которые завершились хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением с названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline таким образом, чтобы он мог сначала запустить через Ya.Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Тем самым, мы должны по нажатию кнопки получить готовую к использованию систему.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
