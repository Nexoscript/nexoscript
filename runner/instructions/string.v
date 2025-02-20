module instructions

pub struct String implements Instruction {
pub mut:
	ctx string
}

pub fn (str String) construct(line string) Instruction {
	println(line)
	words := line.split(' ')
	println(words)
	if words[2] != '=' {
		panic('No equals available')
	}

	return str
}

pub fn (str &String) get_type() string {
	return 'String'
}

pub fn (str &String) execute() {
	print(str.ctx)
}
