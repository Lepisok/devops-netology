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
