extends Node


var server_host: String = "127.0.0.1"
var server_port: int = 6767
var udp_peer
var json = JSON.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Establish connection with server
	# TODO: Outsource this to another function, i.e. only if a player players multiplayer or passes the menu or whatever
	#		Just make a button somewhere please, and IP should be player input
	print("Establishing connection to server...")
	# https://docs.godotengine.org/en/stable/classes/class_packetpeerudp.html -- <3
	udp_peer = PacketPeerUDP.new()
	var conn_err = udp_peer.connect_to_host(server_host, server_port)
	if conn_err != OK:
		print("Connection errored: ", conn_err)
	else:
		print("Connection established!")
		var test = "Mark"
		# TODO: Util of "send name" would add the leading 0 for me
		udp_peer.put_packet(PackedByteArray(["0"]) + test.to_ascii_buffer()) # https://docs.godotengine.org/en/stable/classes/class_packedbytearray.html
	
	# Connect signals on dummies
	for child in $Dummies.get_children():
		child.connect("dummy_is_hit", _on_dummy_is_hit)
	# TODO: Loading bar and load scenes and stuff


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("Still connected? ", udp_peer.is_socket_connected())
	pass


func _on_dummy_is_hit(s_id: int, v_id: int):
	print("A dummy with id ", v_id, " was hit by player with id ", s_id)
	udp_peer.put_packet(PackedByteArray(["1"]) + PackedByteArray([s_id, v_id]))
