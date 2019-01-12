package main

import (
	"fmt"
	"net/http"
	"net/http/httputil"
)

func handler(w http.ResponseWriter, r *http.Request) {
	var payload, err = httputil.DumpRequest(r, true)
	if err != nil {
		fmt.Fprint(w, err)
	}
	fmt.Println("------------------------------")
	fmt.Printf("%s\n", payload)

	w.Write([]byte("OK"))
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":3000", nil)
}
