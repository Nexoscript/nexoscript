module compiler

import os

pub fn start_compiler(path string) {
	println("#################################")
	println("#      NexoScript Compiler      #")
	println("#################################")

	println("Selected Path: " + path)
	mut line_count := 1

	if os.is_dir(path) {
		files := os.ls(path) or {
			eprintln('Fehler beim Lesen des Verzeichnisses: $err')
			return
		}

		for file in files {
			target_file := path + "/" + file
			if os.file_ext(target_file) == ".nexoscript" {
				mut lines := os.read_lines(target_file) or {
					eprintln("Error reading file: $err")
					return
				}

				for mut line in lines {
					println("Line: " + line_count.str() + " Ctx: " + line)
					words := line.split(' ') // Zerlegt die Zeile in Wörter
					for key, value in instructions {
						if key in words {
							line = line.replace_once(key, value)
						}
					}
					line_count += 1
				}

				output_dir := path + "/build"
				if !os.exists(output_dir) {
					os.mkdir(output_dir) or {
						println("Can not create path: " + output_dir)
					}
				}
				mut f := os.create( output_dir + "/" + file.replace_once(".nexoscript", ".nexovm")) or {
					println('file not writable')
					return
				}
				line_count = 0
				for line in lines {
					println("Line: " + line_count.str() + " Ctx: " + line)
					f.write_string(line + "\n") or {  }
					println("Line is writen to output File")
					line_count += 1
				}
				f.close()
			} else {
				println("Wrong ext Type: use .nexoscript")
			}
		}
	}
}

