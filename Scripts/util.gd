extends Node
class_name Util


static func assert_in_range(value:int,upper:int) -> void:
	assert(0 <= value && value < upper)


static func d_print(...args:Array) -> void:
	if !OS.is_debug_build(): return
	print(args)


static func d_print_verbose(...args:Array) -> void:
	if !OS.is_debug_build(): return
	print_verbose(args)


static func d_print_rich(... args:Array) -> void:
	if !OS.is_debug_build(): return
	print_rich(args)


static func add_bold(input: String) -> String:
	return "[b]%s[/b]" % input;
