extends CollisionShape3D

var server_host = "127.0.0.1"
var server_port = 6767
var tcp_peer
var json = JSON.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: Likely change to ENetMultiplayerPeer for UDP?
	tcp_peer = StreamPeerTCP.new()
	tcp_peer.set_no_delay(true)
	var connRes = tcp_peer.connect_to_host(server_host, server_port)
	print("Connection result: ", connRes)


var connected = false
var sent_name = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	while !connected:
		if tcp_peer.get_status() == 1:
			# If it's still connecting, re-poll
			tcp_peer.poll()
		if tcp_peer.get_status() == 2:
			print("Connection succeeded!")
			connected = true
		if tcp_peer.get_status() == 3:
			print("Connection errored!")
			connected = true

	# Just doing this once to test
	if !sent_name:
		var user = {"username": "Mark"}
		var send_name = JSON.stringify(user)
		print("Attempting to send:", send_name)
		tcp_peer.put_data(send_name)
		sent_name = true

	if !sent_name:
		pass  # Poll for a received input from the client
