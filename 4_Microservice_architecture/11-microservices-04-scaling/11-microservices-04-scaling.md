
# Домашнее задание к занятию "11.04 Микросервисы: масштабирование"

Вы работаете в крупной компанию, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps специалисту необходимо выдвинуть предложение по организации инфраструктуры, для разработки и эксплуатации.

## Задача 1: Кластеризация

Предложите решение для обеспечения развертывания, запуска и управления приложениями.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- Поддержка контейнеров;
- Обеспечивать обнаружение сервисов и маршрутизацию запросов;
- Обеспечивать возможность горизонтального масштабирования;
- Обеспечивать возможность автоматического масштабирования;
- Обеспечивать явное разделение ресурсов доступных извне и внутри системы;
- Обеспечивать возможность конфигурировать приложения с помощью переменных среды, в том числе с возможностью безопасного хранения чувствительных данных таких как пароли, ключи доступа, ключи шифрования и т.п.

Обоснуйте свой выбор.  

Решение:  
Я бы рассматривал только k8s. Он отлично подходит для развертывания и автоматизированного масштабирования микросервисной инфраструктуры основанной на контейнерах. В нем так же имеется встроенный модуль Secrets для хранения чувствительных данных. К нему можно добавить пакетный менеджер Helm, что бы упростить запуск приложений в кластере. Возможно понадобится Terrform при развертывании инфраструктуры в облаке.
Шаблон Kubernetes с высоким уровнем доступности в Azure и Azure Stack Hub - Azure Hybrid App Solutions:  
![image.png](https://github.com/Lepisok/devops-netology/blob/main/4_Microservice_architecture/11-microservices-04-scaling/src/image.png)  