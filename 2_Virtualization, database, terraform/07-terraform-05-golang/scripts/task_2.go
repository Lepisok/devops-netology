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
