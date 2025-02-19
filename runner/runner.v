module runner

pub fn start_runner(path string) {
	println('#################################')
	println('#       Nexoscript Runner       #')
	println('#################################')

	println('Selected Path: ' + path)

	/*
	main_file := parse_build_file(path)
	if main_file == '' {
		println('main_file is empty')
		return
	}
	println(main_file)
	 */

	file := NexoFile{}.construct(path)
	println('Debug1')
	for function in file.functions {
		for instr in function.instructions {
			instr.execute()
		}
	}
}
