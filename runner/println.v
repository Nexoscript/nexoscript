module runner

pub struct Println implements Instruction {
pub mut:
	ctx string
	function_name string
}

pub fn (p Println) construct(line string) Instruction {
	if line.contains('"') {
		return Println{
			ctx: extract_between_quotes(line)
		}
	}
	mut graped_value := ''
	for function_name, variable in get_variables() {
		for name, value in variable {
			if line.split(' ')[1] == name {
				graped_value = value
			}
		}
	}
	if graped_value != '' {
		return Println{
			ctx: graped_value
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
