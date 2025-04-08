extends Node

# Driver signals
signal driver_item_taken
signal driver_giving_item
signal update_engine_force(modifier:String, amount:float)
signal clear_driver_item
signal driver_play_animation(anim_name: String)
signal driver_play_animation_backwards(anim_name: String)
signal out_of_bounds
signal driver_change_invul

# Track signals
signal update_checkpoint(name:String)
signal revert_checkpoints
signal update_laps_left(laps_left:String)
signal end_track

# Devil Signals
signal devil_item_taken
signal devil_giving_item
signal clear_devil_item
signal devil_play_animation
signal toggle_crosshair

# Menu Signals
signal back_to_menu
