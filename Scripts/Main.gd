extends Node


export (PackedScene) var Mob
var score


func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs","queue_free")
	$Music.stop()
	$DeathSound.play()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$Player2.start($StartPosition2.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_MobTimer_timeout():
	 # Choose a random location on Path2D.
	$Mob2Path/Mob2SpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $Mob2Path/Mob2SpawnLocation.rotation
	# Set the mob's position to a random location.
	mob.position = $Mob2Path/Mob2SpawnLocation.position
	# Make the direction down only.
	direction += PI/2
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
