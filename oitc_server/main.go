package main

import (
	"bufio"
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
	fmt.Println("Start successful!")

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
	// TODO: Do I want to close it? Or keep a connection open with every single player... probably.
	defer conn.Close()

	// TODO: Could set up some logging. Otherwise just a prefix for what connection is being consistent or something. This'll be spammy if I keep too much in though.
	//fmt.Println("Connection Received | LocalAddr:", conn.LocalAddr(), "| RemoteAddr:", conn.RemoteAddr())

	message, err := bufio.NewReader(conn).ReadString('\n')
	if err != nil {
		fmt.Println("Issue reading message: ", err)
	}

	var player Player
	err = json.Unmarshal([]byte(message), &player)
	if err != nil {
		fmt.Println("Error parsing message to json: ", err)
	}

	returnStr := "Received! Closing out connection. The changed name is: " + player.Name + "-001"
	fmt.Println("Connection from ", conn.RemoteAddr(), " processed.")
	conn.Write([]byte(returnStr))
}
