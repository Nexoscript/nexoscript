module runner

pub struct Function {
pub mut:
	instructions []Instruction
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
			mut print := Print{function_name: function.name}
			print = print.construct(line) as Print
			function.instructions << print
			continue
		}
		if line.starts_with('0xa2') {
			mut println1 := Println{function_name: function.name}
			println1 = println1.construct(line) as Println
			function.instructions << println1
			continue
		}
		if line.starts_with('0xd1') {
			mut str := String{function_name: function.name}
			str = str.construct(line) as String
			add_variable(function.name, str.name, str.value)
			continue
		}
	}
	return function
}
