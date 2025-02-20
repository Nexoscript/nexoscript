module instructions

pub struct Print implements Instruction {
pub mut:
	ctx string
}

pub fn (p Print) construct(line string) Instruction {
	if line.contains('"') {
		return Print{
			ctx: extract_between_quotes(line)
		}
	}
	return p
}

pub fn (p &Print) get_type() string {
	return 'Print'
}

pub fn (p &Print) execute() {
	print(p.ctx)
}
