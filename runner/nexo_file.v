module runner

import os

pub struct NexoFile {
pub mut:
	path      string
	functions []Function
}

pub fn (n &NexoFile) construct(path string) NexoFile {
	mut file := NexoFile{
		path: path
	}
	ctx := os.read_lines(path) or { panic('Can`t Read File') }
	for line in ctx {
		if line.starts_with('0x00') && line.ends_with('0x13') {
			function := Function{}.construct(line.split(' ')[1].split('0x11')[0], ctx)
			file.functions << function
		}
	}
	return file
}
