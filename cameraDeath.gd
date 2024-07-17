extends Camera2D

func _on_player_died(position):
	# Aqui você pode adicionar a lógica para lidar com a morte do player
	# Por exemplo, parar de seguir o player, mover a câmera para outra posição, etc.
	print("Player morreu na posição:", position)
	# Exemplo: parar de seguir o player
	# global_position = position  # Mover a câmera para a posição do player
