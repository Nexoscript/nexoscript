module runner

import os

pub fn start_runner(path string) {
	println('#################################')
	println('#       Nexoscript Runner       #')
	println('#################################')
	println('Selected Path: ' + path)

	init_variables()

	main := parse_build_file(path)
	if main.file == '' {
		println('main_file is empty')
		return
	}
	nexo_file := NexoFile{}.construct(os.join_path(path, main.file))
	mut found_main := false
	for function in nexo_file.functions {
		if function.name == main.method {
			found_main = true
			for instr in function.instructions {
				instr.execute()
			}
		}
	}
	if !found_main {
		println('Main method not found')
		return
	}
}
