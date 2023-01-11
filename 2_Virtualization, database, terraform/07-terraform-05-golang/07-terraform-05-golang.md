# Домашнее задание к занятию "7.5. Основы golang"

С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

## Задача 1. Установите golang.
1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).  

Решение:  
```
lepis@lepis:~$ go version
go version go1.18.1 linux/amd64

```

## Задача 2. Знакомство с gotour.
У Golang есть обучающая интерактивная консоль [https://tour.golang.org/](https://tour.golang.org/). 
Рекомендуется изучить максимальное количество примеров. В консоли уже написан необходимый код, 
осталось только с ним ознакомиться и поэкспериментировать как написано в инструкции в левой части экрана.  

Решение: Ознакомлен, очень полезная интерактивная консоль для входа в язык

## Задача 3. Написание кода. 
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода 
на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.
    Для взаимодействия с пользователем можно использовать функцию `Scanf`:
    ```
    package main
    
    import "fmt"
    
    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)
    
        output := input * 2
    
        fmt.Println(output)    
    }
    ```  
Решение:  

```
package main

import "fmt"

func main() {
	fmt.Print("Enter a number: ")
	var input float64
	conversion := 3.28084
	fmt.Scanf("%f", &input)
	output := input * conversion

	fmt.Println(output)
}
```
 
2. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```
Решение:  
```
package main

import "fmt"

func main() {
	x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
	min_number := x[0]

	for i := 1; i < len(x); i += 1 {
		if min_number > x[i] {
			min_number = x[i]
		}
	}
	fmt.Println(min_number)
}

```
3. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

Решение:  
```
package main

import "fmt"

func main() {
	fmt.Println(division())
}

func division() []int {
	var numbers []int
	for i := 1; i <= 100; i += 1 {
		if i%3 == 0 {
			numbers = append(numbers, i)
		}
	}
	return numbers
}
```

## Задача 4. Протестировать код (не обязательно).

Создайте тесты для функций из предыдущего задания.   

Решение: Сделал для 3 задания, но что-то не пойму правильный тест или нет  

```
package main

import "testing"

func test(t *testing.T) {
	x := []int{3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66,
		69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99}
	var result []int
	result = division()
	if result[5] != x[5] {
		t.Error("Error")
	}
}

```
---
