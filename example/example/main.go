package main

import (
	"os"
)

func main() {
	os.Stderr.WriteString("Hello world.")
	os.Exit(1)
}