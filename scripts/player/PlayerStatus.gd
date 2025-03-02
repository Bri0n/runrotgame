extends Node

class_name PlayerStatus

func enter_state():
	push_error("enter_state() not implemented in " + str(self))

func exit_state():
	push_error("exit_state() not implemented in " + str(self))

func process_state(delta : float):
	push_error("process_state() not implemented in " + str(self))

func process_input(event : InputEvent):
	push_error("process_input() not implemented in " + str(self))
