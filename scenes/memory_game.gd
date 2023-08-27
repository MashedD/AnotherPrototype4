extends Control

@export var level: PackedScene = preload("res://scenes/levels/level1.tscn")
@export var card_middle_material : Material = preload("res://assets/cards/middle.material")
@export var card_back_material : Material = preload("res://assets/cards/back.material")
@export var materials_path: = "res://assets/cards/candies"
@export var cards_to_match: = 2

var flipped: = []


func _ready() -> void:
	_load_level()
	_setup_cards()


func _load_level() -> void:
	get_tree().get_current_scene().find_child("SubViewport").add_child(level.instantiate())


func _setup_cards() -> void:
	var cards := get_tree().get_nodes_in_group("cards")
	var materials: = MaterialUtils.get_materials(materials_path)
	var indexes = _get_indexes(cards.size(), materials.size())
	var index: = 0
	
	for card in cards:
#		# FIXME: Workaround
		card.get_node("Pivot/MiddleMesh").mesh = card.get_node("Pivot/MiddleMesh").mesh.duplicate()
		card.get_node("Pivot/MiddleMesh").mesh.surface_set_material(0, card_middle_material.duplicate())

#		# FIXME: Workaround
		card.get_node("Pivot/BackMesh").mesh = card.get_node("Pivot/BackMesh").mesh.duplicate()
		card.get_node("Pivot/BackMesh").mesh.surface_set_material(0, card_back_material.duplicate())

		card.index = index
		card.front_index = indexes[index]
		card.get_node("Pivot/FrontMesh").material_override = materials[card.front_index]
		card.connect("pressed_card", _on_pressed_card)
		index += 1


# FIXME: scenario with less fronts than pairs needed
func _get_indexes(cards_count: int, materials_count: int) -> Array:
	randomize()
	@warning_ignore("integer_division")
	var unique_fronts_count: = cards_count / cards_to_match
	var material_indexes: = range(materials_count)
	material_indexes.shuffle()
	var slice_of_indexes: = material_indexes.slice(0, unique_fronts_count)
	var indexes: = ArrayUtils.concat_x_times(slice_of_indexes, cards_to_match)
	indexes.shuffle()
	return indexes


func _flip_card(card) -> void:
	# Note: not ready yet to work with cards_to_match
	if flipped.size() == 0 or flipped[0][0] != card.index:
		flipped.push_back([card.index, card.front_index])
		card.flip()
	else:
		flipped.clear()
		card.unflip()


func _get_card(index):
	var cards := get_tree().get_nodes_in_group("cards")
	for card in cards:
		if card.index == index:
			return card
	return null


func _are_fronts_same():
	var previous_front
	for card in flipped:
		if previous_front:
			if card[1] != previous_front:
				return false
		else:
			previous_front = card[1]
	return true


func _match_cards() -> void:
	#command.action(self, "do_pair", "redo_pair", "undo_pair", {"flipped_cards": flipped_cards})
	for card in flipped:
		_get_card(card[0]).disappear()
	#try_ending_game()
	#TopBar.test = 4


func _show_wrong_match() -> void:
	for card in flipped:
		_get_card(card[0]).wrong_match()


func _check_if_matched() -> void:
	if flipped.size() != cards_to_match:
		return
	elif _are_fronts_same():
		_match_cards()
	else:
		_show_wrong_match()
	flipped.clear()


func _on_pressed_card(card) -> void:
	_flip_card(card)
	_check_if_matched()
