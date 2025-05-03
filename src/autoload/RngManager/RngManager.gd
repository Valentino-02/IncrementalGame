extends Node

var rng := RandomNumberGenerator.new()

var _seed : int = 0


func generateRandomSeed():
	_seed = int(Time.get_unix_time_from_system())
	rng.seed = _seed

func setSeed(newSeed: int) -> void:
	if _seed != null:
		push_warning("Rng Manager being called to replace the current seed")
	_seed = newSeed
	rng.seed = _seed

func getSeed() -> int:
	return _seed

func createRng() -> RandomNumberGenerator:
	var newRng := RandomNumberGenerator.new()
	newRng.seed = _seed
	return newRng
