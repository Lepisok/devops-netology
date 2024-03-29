# Домашнее задание к занятию "6.3. MySQL"

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.
![img.png](img/img.png)  
Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/virt-11/06-db-03-mysql/test_data) и 
восстановитесь из него.  
![img_1.png](img/img_1.png)  
Перейдите в управляющую консоль `mysql` внутри контейнера.  
![img_2.png](img/img_2.png)  
Используя команду `\h` получите список управляющих команд.  
![img_3.png](img/img_3.png)  
Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.  
![img_4.png](img/img_4.png)  
Подключитесь к восстановленной БД и получите список таблиц из этой БД.
![img_5.png](img/img_5.png)  
**Приведите в ответе** количество записей с `price` > 300.  
![img_6.png](img/img_6.png)   
В следующих заданиях мы будем продолжать работу с данным контейнером.  

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"  

![img_7.png](img/img_7.png)  
Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.  
![img_8.png](img/img_8.png)  
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.
![img_9.png](img/img_9.png)  
## Задача 3  

Установите профилирование `SET profiling = 1`.  
![img_10.png](img/img_10.png)  
Изучите вывод профилирования команд `SHOW PROFILES;`.  
![img_11.png](img/img_11.png)  
Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.
![img_12.png](img/img_12.png)  
Engine = InnoDB  
Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`  

![img_13.png](img/img_13.png)  
## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.
![img_14.png](img/img_14.png)