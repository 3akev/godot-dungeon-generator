extends TileMap

export var parameters = {
	MAX_ROOM_SIZE = Vector2(25, 20),
	MIN_ROOM_SIZE = Vector2(15, 12),

	ROOM_PADDING = 8,
	MIN_ROOMS_PER_DUNGEON = 6,
	MAX_ROOMS_PER_DUNGEON = 18,

	TUNNEL_WIDTH = 4,
	MIN_EXTRA_TUNNELS = 2,
	MAX_EXTRA_TUNNELS = 5
}

var rng = RandomNumberGenerator.new()
var data: DungeonData

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	rng.randomize()
	
	data = DungeonGenerator.new(rng, parameters).generate_dungeon()
	DungeonPlacer.new(self).place_dungeon(data)

func map_rect_to_world(rect):
	return Rect2(map_to_world(rect.position), map_to_world(rect.size))
