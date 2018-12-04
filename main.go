package main

import (
	"net/http"
)

func main() {
	finish := make(chan bool)

	mux := http.NewServeMux()
	mux.HandleFunc("/", Hello)

	mux2 := http.NewServeMux()
	mux2.HandleFunc("/", Greetings)

	go func() {
		http.ListenAndServe(":4000", mux)
	}()

	go func() {
		http.ListenAndServe(":5000", mux2)
	}()

	<-finish
}

func Hello(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Listening on 4000: Hello World!\n"))
}

func Greetings(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Listening on 5000: Greetings World!\n"))
}
