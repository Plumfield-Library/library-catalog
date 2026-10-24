package main

import (
	"embed"
	"log"
	"net/http"

	"github.com/raystack/salt/server/spa"
)

//go:embed all:frontend/dist
var content embed.FS

func helloWorld(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello World!"))
}

func main() {
	handler, err := spa.Handler(content, "frontend/dist", "index.html", true)
	if err != nil {
		log.Fatalf("failed to initialize SPA handler: %v", err)
	}
	http.HandleFunc("/test", helloWorld)

	http.Handle("/", handler)
	log.Println("Starting server on :8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatalf("server failed: %v", err)
	}
}
