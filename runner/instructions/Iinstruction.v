module instructions

pub interface Iinstruction {
	execute()
	get_type() string
	construct(string) Iinstruction
}
