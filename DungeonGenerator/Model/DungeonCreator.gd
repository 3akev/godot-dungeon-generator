# This file is responsible of creating each room according to its room slot,
# and each tunnel according to its two adjacent room's slots.

class_name DungeonCreator

var rng: RandomNumberGenerator
var parameters: Dictionary
var room_slot_size: Vector2

func _init(_rng: RandomNumberGenerator, _parameters: Dictionary) -> void:
	rng = _rng
	parameters = _parameters
	room_slot_size = parameters.MAX_ROOM_SIZE + Vector2(parameters.ROOM_PADDING, parameters.ROOM_PADDING)

func create_room(room_slot: Vector2) -> Rect2:
	var room := Rect2(0, 0, rng.randi_range(parameters.MIN_ROOM_SIZE.x, parameters.MAX_ROOM_SIZE.x), rng.randi_range(parameters.MIN_ROOM_SIZE.y, parameters.MAX_ROOM_SIZE.y))
	room.position = room_slot * room_slot_size
	
	# center room in room slot according to room size
	room.position.x += (room_slot_size.x * (room_slot.x + 1) - room.end.x) / 2
	room.position.y += (room_slot_size.y * (room_slot.y + 1) - room.end.y) / 2
	
	# round to preserve integers
	room.position = room.position.round()
	return room

func create_h_tunnel(room1: Rect2, room2: Rect2) -> Rect2:
	# tunnel is horizontal; start at leftmost room, end at roo
	var x
	var length
	if room1.position.x < room2.position.x:
		x = room1.end.x
		length = room2.position.x - room1.end.x
	else:
		x = room2.end.x
		length = room1.position.x - room2.end.x
	
	var y = room1.position.y + (room1.size.y - parameters.TUNNEL_WIDTH)/2
	var tunnel = Rect2(x, y, length, parameters.TUNNEL_WIDTH)
	return tunnel

func create_v_tunnel(room1: Rect2, room2: Rect2) -> Rect2:
	# tunnel is vertical; start at upper room, end at other room
	var y
	var length
	if room1.position.y < room2.position.y:
		y = room1.end.y
		length = room2.position.y - room1.end.y
	else:
		y = room2.end.y
		length = room1.position.y - room2.end.y
	
	var x = room1.position.x + (room1.size.x - parameters.TUNNEL_WIDTH)/2
	var tunnel = Rect2(x, y, parameters.TUNNEL_WIDTH, length)
	return tunnel
