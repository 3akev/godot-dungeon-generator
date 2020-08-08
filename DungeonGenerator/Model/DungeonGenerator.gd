class_name DungeonGenerator

var rng: RandomNumberGenerator
var creator: DungeonCreator
var parameters: Dictionary

func _init(_rng: RandomNumberGenerator, _parameters: Dictionary) -> void:
	rng = _rng
	parameters = _parameters
	creator = DungeonCreator.new(rng, parameters)

func generate_dungeon() -> DungeonData:
	var dungeonData = DungeonData.new()
	dungeonData.add_room(Vector2(0, 0), creator.create_room(Vector2(0, 0)))
	
	var num_rooms = rng.randi_range(parameters.MIN_ROOMS_PER_DUNGEON, parameters.MAX_ROOMS_PER_DUNGEON) - 1
	for _i in range(num_rooms):
		generate_next_room(dungeonData)

	var num_extra_tunnels = rng.randi_range(parameters.MIN_EXTRA_TUNNELS, parameters.MAX_EXTRA_TUNNELS)
	for _i in range(num_extra_tunnels):
		generate_extra_tunnel(dungeonData)
	
	return dungeonData

func generate_next_room(dungeonData: DungeonData) -> void:
	var previous_slot = dungeonData.get_random_room_slot()
	var slot = dungeonData.get_adjacent_space(previous_slot)
	
	if slot == Vector2.INF:
		generate_next_room(dungeonData)
	else:
		dungeonData.add_room(slot, creator.create_room(slot))
		generate_tunnel(dungeonData, previous_slot, slot)

func generate_extra_tunnel(dungeonData: DungeonData) -> void:
	# Pick two random non-connected rooms, place a tunnel between them.
	# If we recurse, having a dungeon with no two adjacent rooms that are not
	# connected would lead to an infinite loop.
	# So extra tunnels are not guaranteed to spawn.
	var slot1 = dungeonData.get_random_room_slot()
	var slot2 = dungeonData.get_adjacent_non_connected_room(slot1)
	
	if slot2 == Vector2.INF:
		return
	
	generate_tunnel(dungeonData, slot1, slot2)

func generate_tunnel(dungeonData: DungeonData, slot1: Vector2, slot2: Vector2) -> void:
	var direction = slot1 - slot2
	var tunnel
	if direction in [Vector2.UP, Vector2.DOWN]:
		tunnel = creator.create_v_tunnel(dungeonData.rooms[slot1], dungeonData.rooms[slot2])
	else:
		tunnel = creator.create_h_tunnel(dungeonData.rooms[slot1], dungeonData.rooms[slot2])
	dungeonData.add_tunnel([slot1, slot2], tunnel)
