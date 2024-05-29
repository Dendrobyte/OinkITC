package main

import (
	"fmt"
	"net"
	"os"
)

const ( // TODO: These become something from a build image, etc.
	serverPort = 6767 // TODO: Change this
	serverIP   = "127.0.0.1"
)

var (
	tempPlayer = &Player{
		Id:    111,
		Score: 0,
	}

	playerMap = map[int]*Player{
		111: tempPlayer,
	}
)

func main() {
	fmt.Println("Starting up server at", serverPort, ":", serverIP)

	serverAddress := net.UDPAddr{ // https://pkg.go.dev/net#UDPAddr
		Port: serverPort,
		IP:   net.ParseIP(serverIP),
	}

	conn, err := net.ListenUDP("udp", &serverAddress)
	if err != nil {
		fmt.Println("Starting errored out:", err)
		os.Exit(1)
	}
	defer conn.Close()
	fmt.Println("Start successful!")

	allFuncs := map[int]func(buffer []byte, rAddr *net.UDPAddr){
		0: handleName,
		1: handleScoreIncr,
	}

	// Eternally listen for incoming connections and spin up a goroutine to handle it
	var buf [1024]byte
	for {
		_, rAddr, err := conn.ReadFromUDP(buf[:]) // First is length of buffer

		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}

		funcIdx := int(buf[0])
		if val := allFuncs[funcIdx]; val != nil {
			// TODO: Convert buf[1:] to unmarshaled JSON
			//		 Stitch packets together based on order
			go val(buf[1:], rAddr)
		} else {
			fmt.Println("From addr", rAddr, ", received an unknown type in the buffer:", buf)
		}

	}
}

type Player struct {
	Id    int `json:"p_id"`
	Score int `json:"score"`
}

type Score struct {
	Type string `json:"type"` // arrow, melee
}

func handleName(nameBuffer []byte, rAddr *net.UDPAddr) {
	converted := string(nameBuffer)
	fmt.Println("Hello,", converted, "from", rAddr)
}

// TODO: Change this to sending along JSON information to unmartial
func handleScoreIncr(scoreBuffer []byte, rAddchan *net.UDPAddr) {
	s_id := int(scoreBuffer[0])
	v_id := int(scoreBuffer[1])

	fmt.Println("Shooter id:", s_id, "and victim id:", v_id)
	playerMap[s_id].Score += 1
	fmt.Printf("Player %v's score is now %d!\n", s_id, playerMap[s_id].Score)
}
