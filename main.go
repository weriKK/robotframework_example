package main

import (
	"encoding/json"
	"log"
	"math/rand"
	"net/http"
)

type helloResponse struct {
	Text   string
	Number int
	Bool   bool
}

func helloFixHandler(rw http.ResponseWriter, req *http.Request) {
	log.Printf("%s %s - %s", req.RemoteAddr, req.Method, req.RequestURI)

	resp := helloResponse{
		Text:   "These values dont change!",
		Number: 42,
		Bool:   true,
	}

	rw.Header().Add("Content-Type", "application/json")

	//rw.WriteHeader(http.StatusOK)
	err := json.NewEncoder(rw).Encode(resp)
	if err != nil {
		log.Printf("Encode failed: %v", err)
	}
}

func helloRandomHandler(rw http.ResponseWriter, req *http.Request) {
	log.Printf("%s %s - %s", req.RemoteAddr, req.Method, req.RequestURI)

	resp := helloResponse{
		Text:   "These values are random!",
		Number: rand.Intn(256),
		Bool:   rand.Intn(2) == 1,
	}

	rw.Header().Add("Content-Type", "application/json")

	//rw.WriteHeader(http.StatusOK)
	err := json.NewEncoder(rw).Encode(resp)
	if err != nil {
		log.Printf("Encode failed: %v", err)
	}
}

func main() {

	http.HandleFunc("/hellofix", helloFixHandler)
	http.HandleFunc("/hellorandom", helloRandomHandler)

	addr := ":8080"
	log.Printf("Listening on %s", addr)
	log.Fatal(http.ListenAndServe(addr, nil))
}
