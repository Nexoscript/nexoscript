module runner

pub struct Print implements Instruction {
pub mut:
	ctx string
	function runner.Function
}

pub fn (p Print) construct(line string, function runner.Function) Instruction {
	if line.contains('"') {
		return Print{
			ctx: extract_between_quotes(line),
			function: function
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
