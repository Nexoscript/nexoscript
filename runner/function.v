module runner

pub struct Function {
pub mut:
	instructions []Instruction
	name         string
	variables	 map[string]string
}

pub fn (f Function) construct(name string, lines []string) Function {
	mut function := Function{}
	function.name = name
	for line in lines {
		if line.starts_with('0x14') {
			return function
		}
		if line.starts_with('0xa1') {
			mut print := Print{}
			print = print.construct(line, function) as Print
			function.instructions << print
			continue
		}
		if line.starts_with('0xa2') {
			mut println1 := Println{}
			println1 = println1.construct(line, function) as Println
			function.instructions << println1
			continue
		}
		if line.starts_with('0xd1') {
			mut str := String{}
			function.variables[str.name]="string:[" + str.value + "]"
			str = str.construct(line, function) as String
			str.value = ''
			continue
		}
	}
	return function
}
