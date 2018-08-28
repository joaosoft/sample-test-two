package main

import (
	"fmt"

	"github.com/joaosoft/logger"
	samplethree "github.com/joaosoft/sample-test-three"
)

func main() {
	fmt.Println(NewSampleTestTwo())
}

func NewSampleTestTwo() string {
	logger.Info("executing info logger for sample-test-two")
	fmt.Println(samplethree.NewSampleTestThree())
	return "hello, i'm the sample-test-two"
}
