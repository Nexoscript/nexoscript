module runner

import runner.instructions

pub struct Function {
	pub mut:
	instructions []instructions.Iinstruction
	name string
}

pub fn (f Function) construct(name string, lines []string) Function {
	println("Debug Func 1")
	mut function := Function{}
	println("Debug Func 2")
	function.name = name
	println(name)
	println("Debug Func 3")
	for line in lines {
		println("Debug Func 4")
		if line.starts_with('0x14') {
			println("Debug Func Panic")
			return function
		}
		if line.starts_with('0xa1') {
			mut print := instructions.Print{}
			print.construct(line)
			function.instructions << print
			continue
		}
		if line.starts_with('0xa2') {
			println('Debug Func Println')
			mut println1 := instructions.Println{}
			println(println1.get_type())
			println1 = println1.construct(line) as instructions.Println
			println(println1.get_type())
			function.instructions << println1
			for instr in function.instructions {
				println(instr.get_type())
			}
			continue
		}
	}
	return function
}
