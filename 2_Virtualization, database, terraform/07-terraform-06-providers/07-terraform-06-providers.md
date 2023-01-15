# Домашнее задание к занятию "17. Написание собственных провайдеров для Terraform."

Бывает, что 
* общедоступная документация по терраформ ресурсам не всегда достоверна,
* в документации не хватает каких-нибудь правил валидации или неточно описаны параметры,
* понадобиться использовать провайдер без официальной документации,
* может возникнуть необходимость написать свой провайдер для системы используемой в ваших проектах.   

## Задача 1. 
Давайте потренируемся читать исходный код AWS провайдера, который можно склонировать от сюда: 
[https://github.com/hashicorp/terraform-provider-aws.git](https://github.com/hashicorp/terraform-provider-aws.git).
Просто найдите нужные ресурсы в исходном коде и ответы на вопросы станут понятны.  


1. Найдите, где перечислены все доступные `resource` и `data_source`, приложите ссылку на эти строки в коде на 
гитхабе.   
Решение:  
[resource](https://github.com/Lepisok/devops-netology/blob/69b895f9a004bef974e8da48a4a73fe5e5aa123e/2_Virtualization%2C%20database%2C%20terraform/07-terraform-06-providers/terraform-provider-aws-main/internal/provider/provider.go#L944)  
[data_source](https://github.com/Lepisok/devops-netology/blob/69b895f9a004bef974e8da48a4a73fe5e5aa123e/2_Virtualization%2C%20database%2C%20terraform/07-terraform-06-providers/terraform-provider-aws-main/internal/provider/provider.go#L419)
2. Для создания очереди сообщений SQS используется ресурс `aws_sqs_queue` у которого есть параметр `name`. 
    * С каким другим параметром конфликтует `name`? Приложите строчку кода, в которой это указано.
    * Какая максимальная длина имени? 
    * Какому регулярному выражению должно подчиняться имя? 

Решение:  
1. Конфликтует с параметром `name_prefix`
```
"name": {
  Type:          schema.TypeString,
  Optional:      true,
  Computed:      true,
  ForceNew:      true,
  ConflictsWith: []string{"name_prefix"},
```  
2. Ммаксимальная длина имени - 80 символов
3. Регулярное выражение  
```
		if fifoQueue {
			re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,75}\.fifo$`)
		} else {
			re = regexp.MustCompile(`^[a-zA-Z0-9_-]{1,80}$`)
		}

```