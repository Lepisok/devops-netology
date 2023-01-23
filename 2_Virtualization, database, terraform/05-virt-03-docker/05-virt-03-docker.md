## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

Решение:  
https://hub.docker.com/repository/docker/lepisok/nginx
## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

- Высоконагруженное монолитное java веб-приложение;  
Виртуальная машина, так как это высоконагруженное монолитно веб-приложение, премуществ контейнеров здесь не будет
- Nodejs веб-приложение;  
Docker, для этого его и используют, быстрое развертывание, тестирование
- Мобильное приложение c версиями для Android и iOS;  
IOS - ВМ, разработка только на MacOS, Android - подойдут контейнеры
- Шина данных на базе Apache Kafka;
Docker, быстрое маштабирование возможностей
- Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;  
Опять же Docker подойдёт
- Мониторинг-стек на базе Prometheus и Grafana;
Docker, опять же маштабирование, и данный мониторинг стек не требователен к ресурсам
- MongoDB, как основное хранилище данных для java-приложения;  
ВМ, для хранения больших баз данных необходима высокая производительность
- Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
Docker, для данного решения его будет достаточно

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.


Решение:  
```
vagrant@vagrant:~$ docker run -it -d -v /data:/data centos:latest  
Unable to find image 'centos:latest' locally  
latest: Pulling from library/centos  
a1d0c7532777: Pull complete  
Digest: sha256:a27fd8080b517143cbbbab9dfb7c8571c40d67d534bbdee55bd6c473f432b177  
Status: Downloaded newer image for centos:latest  
ff4ccbb6a45e6156992e51cc863b69598b57da5f1f924364cc866666818c8405  
vagrant@vagrant:~$ docker run -it -d -v /data:/data debian:latest  
Unable to find image 'debian:latest' locally  
latest: Pulling from library/debian  
17c9e6141fdb: Pull complete  
Digest: sha256:bfe6615d017d1eebe19f349669de58cda36c668ef916e618be78071513c690e5  
Status: Downloaded newer image for debian:latest  
1c5cacae789214839308c335087735ab2e231f112e39260e870d3e3261ec942d  
vagrant@vagrant:~$ docker ps  
vagrant@vagrant:~$ docker exec -it jovial_benz bash  
root@1c5cacae7892:/# touch /data/test_1  
root@1c5cacae7892:/#  
exit  
vagrant@vagrant:~$ sudo touch /data/test_2  
vagrant@vagrant:~$ docker exec -it festive_albattani bash  
[root@ff4ccbb6a45e /]# ls -la /data/  
total 8  
drwxr-xr-x 2 root root 4096 Nov  5 08:58 .  
drwxr-xr-x 1 root root 4096 Nov  5 08:56 ..  
-rw-r--r-- 1 root root    0 Nov  5 08:58 test_1  
-rw-r--r-- 1 root root    0 Nov  5 08:58 test_2
```