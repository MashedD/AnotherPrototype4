extends Node


func regex_filter(array: Array, pattern: String) -> Array:
	var regex = RegEx.new()
	regex.compile(pattern)

	var results: = []
	for item in array:
		if regex.search(item):
			results.append(item)
	return results


func concat_x_times(elements, times) -> Array:
	var array: = []
	for i in times:
		array += elements
	return array
