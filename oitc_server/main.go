package main

import (
	"encoding/json"
	"fmt"
	"net"
	"os"
)

const (
	serverAddress = "localhost:6767" // TODO: Change this
)

func main() {
	fmt.Println("Starting up server at", serverAddress)

	listener, err := net.Listen("tcp", serverAddress)
	if err != nil {
		fmt.Println("Starting errored out:", err)
		os.Exit(1)
	}
	defer listener.Close()

	// Eternally listen for incoming connections and spin up a goroutine to handle it
	for {
		conn, err := listener.Accept()

		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}

		go handleConnection(conn)
	}
}

type Player struct {
	Name string `json:"username"`
}

func handleConnection(conn net.Conn) {
	defer conn.Close()

	fmt.Println("Connection Received | LocalAddr:", conn.LocalAddr(), "| RemoteAddr:", conn.RemoteAddr())

	fmt.Println("data:", conn)

	var player Player
	decoded := json.NewDecoder(conn)
	print("Decoded:", decoded)
	err := decoded.Decode(&player)
	if err != nil {
		fmt.Println("Errored out :\\", err)
	}

	fmt.Println("The sent user is", player)
}
