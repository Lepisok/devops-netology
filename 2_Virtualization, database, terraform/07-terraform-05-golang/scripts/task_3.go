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
