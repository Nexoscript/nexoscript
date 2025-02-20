module runner

import runner.instructions

pub struct Function {
pub mut:
	instructions []instructions.Instruction
	name         string
}

pub fn (f Function) construct(name string, lines []string) Function {
	mut function := Function{}
	function.name = name
	for line in lines {
		if line.starts_with('0x14') {
			return function
		}
		if line.starts_with('0xa1') {
			mut print := instructions.Print{}
			print = print.construct(line) as instructions.Print
			function.instructions << print
			continue
		}
		if line.starts_with('0xa2') {
			mut println1 := instructions.Println{}
			println1 = println1.construct(line) as instructions.Println
			function.instructions << println1
			continue
		}
		if line.starts_with('0xd1') {
			mut str := instructions.String{}
			str = str.construct(line) as instructions.String
			function.instructions << str
		}
	}
	return function
}
