module instructions

pub struct Println implements Instruction {
pub mut:
	ctx string
}

pub fn (p Println) construct(line string) Instruction {
	if line.contains('"') {
		return Println{
			ctx: extract_between_quotes(line)
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
