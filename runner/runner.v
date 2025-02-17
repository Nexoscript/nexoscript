module runner

pub fn start_runner(path string) {
	println('#################################')
	println('#       Nexoscript Runner       #')
	println('#################################')

	println('Selected Path: ' + path)

	main_file := parse_build_file(path)
	if main_file == '' {
		println('main_file is empty')
	} else {
		println(main_file)
	}
}
