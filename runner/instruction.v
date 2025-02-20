module runner

pub interface Instruction {
	execute()
	get_type() string
	construct(string, runner.Function) Instruction
}
