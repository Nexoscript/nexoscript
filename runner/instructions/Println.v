module instructions

pub struct Println implements Iinstruction {
pub mut:
	ctx string
}

pub fn (p Println) construct(line string) Iinstruction {
	if line.contains('"') {
		println("Print Success")
		return Println{ctx: extract_between_quotes(line)}
	}
	println("Println Empty")
	return p
}

pub fn (p &Println) get_type() string {
	return 'Println'
}

pub fn (p &Println) execute() {
	println(p.ctx)
}
