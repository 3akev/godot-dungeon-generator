class_name DungeonData

# The units used for the Rect2 objects describing rooms and tunnels are tiles
# i.e: a Rect2 with a width of 20 and a height of 10, would make a 20x10 room
# in terms of tiles.
#
# A room slot is an area of space equal to the maximum room size plus padding.
# Represented as a Vector2, both values integers.
# Using room slots, we can arrange rooms in a grid without any overlap.
# They also make it easy to find adjacent rooms, and the directions between
# them, which makes creating tunnels easier.

const Directions := [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

static func get_randomized_directions() -> Array:
	var tmp := Directions.duplicate()
	tmp.shuffle()
	return tmp

# slot: Rect2
var rooms = {}

# [slot1, slot2]: Rect2
var tunnels = {}

func add_room(slot: Vector2, rect: Rect2) -> void:
	rooms[slot] = rect

func add_tunnel(slots: Array, rect: Rect2) -> void:
	tunnels[slots] = rect
	
func get_random_room() -> Rect2:
	return rooms[get_random_room_slot()]

func get_random_room_slot() -> Vector2:
	return rooms.keys()[randi() % rooms.size()]

func get_adjacent_non_connected_room(slot: Vector2) -> Vector2:
	for v in get_randomized_directions():
		if rooms.get(slot + v, null) != null and not [slot, slot + v] in tunnels and not [slot + v, slot] in tunnels:
			return slot + v
	return Vector2.INF

func get_adjacent_space(slot: Vector2) -> Vector2:
	for v in get_randomized_directions():
		if rooms.get(slot + v, null) == null:
			return slot + v 
	return Vector2.INF
