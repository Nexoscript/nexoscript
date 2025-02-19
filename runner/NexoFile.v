module runner

import os

pub struct NexoFile {
pub mut:
	path string
	functions []Function
}

pub fn (n &NexoFile) construct(path string) NexoFile {
	println("Debug 2")
	mut file := NexoFile{path: path}
	println("Debug 3")
	ctx := os.read_lines(path) or {panic('Can`t Read File')}
	println("Debug 4")
	for line in ctx {
		println("Debug 5")
		if line.starts_with('0x00') && line.ends_with('0x13') {
			println("Debug 6")
			function := Function{}.construct(line.split(' ')[1].split('0x11')[0], ctx)
			println("Debug 7")
			file.functions << function
		}
	}
	return file
}
