extends StaticBody2D

var hats=[]
var save_path="res://Saved//data.json"
var num= -1
# Called when the node enters the scene tree for the first time.
func _ready():
	#print($StaticBody2D.name)
	#print(self.get_name())
	load_data()
	print(hats)
	num = int(self.get_name().replace("Hats",""))
	if num in hats:
		print("In")
		$Area2D.queue_free()
		$Sprite2D.queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		print(body.hats)
		body.hats.append(num)
		print(body.hats)
		save(body.hats)
		print("Get hat")
		# unlock powers
		$Area2D.queue_free()
		$Sprite2D.queue_free()


func save(savehat):
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_string(JSON.new().stringify(savehat))
	file.close()
	
func load_data():
	if FileAccess.file_exists(save_path):
		var file =FileAccess.open(save_path,FileAccess.READ)
		hats = str_to_var(file.get_as_text())
		file.close()
	else:
		print("No saved.")
