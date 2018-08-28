package main

import (
	"fmt"

	logger "github.com/joaosoft/logger"
)

func main() {
	fmt.Println(NewSampleTestTwo())
}

func NewSampleTestTwo() string {
	logger.Info("executing info logger for sample-test-two")
	return "hello, i'm the sample-test-two"
}
