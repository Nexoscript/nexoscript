module instructions

pub interface Instruction {
	execute()
	get_type() string
	construct(string) Instruction
}
