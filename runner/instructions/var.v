module instructions

pub struct Var implements Instruction {
pub mut:
	ctx string
}

pub fn (var Var) construct(line string) Instruction {
	return var
}

pub fn (var &Var) get_type() string {
	return 'Var'
}

pub fn (var &Var) execute() {
	print(var.ctx)
}
