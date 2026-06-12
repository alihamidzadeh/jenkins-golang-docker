package main

import (
	"fmt"
	"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, CI/CD World! This is a Golang App running in Docker.")
}

func main() {
	http.HandleFunc("/", helloHandler)
	fmt.Println("Server is starting on port 8080...")
	http.ListenAndServe(":8080", nil)
}