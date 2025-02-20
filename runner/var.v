module runner

pub struct Var implements Instruction {
pub mut:
	ctx string
}

pub fn (var Var) construct(line string, function Function) Instruction {
	return var
}

pub fn (var &Var) get_type() string {
	return 'Var'
}

pub fn (var &Var) execute() {
	print(var.ctx)
}
