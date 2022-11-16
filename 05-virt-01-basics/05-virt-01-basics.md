## Задача 1

Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

Решение:  
Полная виртуализация - Полная эмулирует физический компьютер с физ. устройствами, обеспечивается полная изоляция гостевой ОС  
Паравиртуализация -  ОС подготовлена к работе с гипервизором. Возможно прямое использование ресурсов хоста  
Виртуализация на основе ОС -  Виртуализируется окружение ОС
## Задача 2

Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:
- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС.

Условия использования:
- Высоконагруженная база данных, чувствительная к отказу - Физические сервера или паравиртуализация. Физические сервера - все свободные ресурсы будут использоваться по назначению и не тратиться на виртуализацию. Паравиртуализация - повышенная отказо-устойчивость, удобная миграция, бэкапирование.
- Различные web-приложения. - Виртуализация. так как можно быстро разворачивать тестовые/новые web-приложения
- Windows системы для использования бухгалтерским отделом. - Паравиртуализация, так как мы создадим кластер для данных целей - удобная миграция и бэкапирование
- Системы, выполняющие высокопроизводительные расчеты на GPU. - Физичесике сервера, так как необходимо чтобы все свободные ресурсы были затрачены на расчёты.

Опишите, почему вы выбрали к каждому целевому использованию такую организацию.


## Задача 3

Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2. Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

Решение:  
1. Hyper-V - Учитывая Премущественно Windows based инфаструктуру, подойдёт Hyper-V, так как лучше совместимость с Windows
2. Proxmox, Xen, KVM - выбор зависит от поставленных задач перед инфаструктурой
3. Hyper-V - Больше всего подходит для виртуализации Windows
4. Docker - быстрое развертывание ОС Linux для тестирования
## Задача 4

Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.Среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

Решение:  
Недостатки:  
1. Большие расходы на штат инженеров, чтобы закрыть потребность в экспертизе по используемым технологиям
2. Необходимо затратить много времени на мониторинг
3. Если требуется интегрировать гипервизор с какими-то внешними системами - нужно делать отдельно для каждой платформы
4. В нужный момент может не оказаться специалистов по технологии, с которой возникли проблемы
5. Скорей всего будет сложно выбирать железо: одни вендоры поддерживают одно, другие другое, нужно больше тратиться на резерв, сложно взаимно заменять аппаратные компоненты

Лучшее решение, конечно, мигрировать на одну платформу, но полагаю это может быть не всегда возможно: всегда есть какое-то легаси, которое лучше не трогать без надобности, или раньше было дорогое и платное решение, теперь бюджет только на опенсорс, или какие-то административные ограничения и т.д. Либо мы работаем в датацентре и тогда, скорей всего, поддержку множества гипервизоров от нас будут ожидать клиенты.

Если бы я выбирал, то делал бы максимально единообразную систему с минимумом разнообразия используемых технологий в основе.

Конечно, если речь идёт о среде, где используются как виртуальные машины, так и контейнеры, то это "стандарт отрасли". Он несёт все минусы, которые я перечислил выше, но это параллельно развивающиеся технологии, имеющие свою нишу, и часто требуется знать и применять как минимум один гипервизор 1/2 уровня и какую-то технологию виртуализации.