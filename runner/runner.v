module runner

pub fn start_runner(path string) {
	println("#################################")
	println("#       Nexoscript Runner       #")
	println("#################################")

	println("Selected Path: " + path.replace(".nexoscript", ".nexovm"))
}
