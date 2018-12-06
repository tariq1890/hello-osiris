package main

import (
	"fmt"
	"log"
	"net/http"
)

func serve(port int32, name string, msg []byte) {
	mux := http.NewServeMux()
	mux.HandleFunc(
		"/",
		func(w http.ResponseWriter, _ *http.Request) {
			w.Write(msg)
		},
	)
	log.Printf("%s server listening at :%d", name, port)
	go func() {
		if err := http.ListenAndServe(fmt.Sprintf(":%d", port), mux); err != nil {
			log.Fatalln(err)
		}
	}()
}

func main() {
	serve(4000, "hello", []byte("Hello, World!"))
	serve(5000, "goodbye", []byte("Ya'll come back real soon!"))
	select {}
}
