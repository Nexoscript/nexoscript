module main

import os
import runner
import compiler

fn main() {
	args := os.args
	if args.len == 3 {
		match args[1] {
			"-run" {
				runner.start_runner(args[2])
			}
			"-build" {
				compiler.start_compiler(args[2])
			}
			"-build-run" {
				compiler.start_compiler(args[2])
				runner.start_runner(args[2])
			}
			else {
				println("Unknown Argument")
			}
		}
	}
}
