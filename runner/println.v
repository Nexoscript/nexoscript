module runner

pub struct Println implements Instruction {
pub mut:
	ctx string
	function runner.Function
}

pub fn (p Println) construct(line string, function runner.Function) Instruction {
	if line.contains('"') {
		return Println{
			ctx: extract_between_quotes(line)
			function: function
		}
	}
	println(p.function.variables)
	mut graped_value := ''
	for key, value in p.function.variables {
		if line.split(' ')[1] == key {
			graped_value = value
		}
	}
	if graped_value != '' {
		return Println{
			ctx: graped_value
			function: function
		}
	}
	return p
}

pub fn (p &Println) get_type() string {
	return 'Println'
}

pub fn (p &Println) execute() {
	println(p.ctx)
}
