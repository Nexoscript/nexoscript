module runner

pub struct String implements Instruction {
pub mut:
	name string
	value string
}

pub fn (str String) construct(line string, function Function) Instruction {
	println(line)
	words := line.split(' ')
	println(words)
	mut index := 0
	mut string_value := ''
	for word in words {
		if index > 2 {
			string_value += word
			if index != words.len - 1 {
				string_value += " "
			}
		}
		index += 1
	}
	println(extract_between_quotes(string_value))
	if words[2] != '=' {
		panic('No equals available')
	}
	return String {
		name: words[1]
		value: extract_between_quotes(string_value)
	}
}

pub fn (str &String) get_type() string {
	return 'String'
}

pub fn (str &String) execute() {
	println(str.name + " | " + str.value)
}
