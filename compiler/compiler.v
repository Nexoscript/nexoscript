module compiler

import runner
import os

pub fn start_compiler(path string) {
	println('#################################')
	println('#      NexoScript Compiler      #')
	println('#################################')

	println('Selected Path: ${path}')
	mut line_count := 1

	if !os.is_dir(path) {
		println('Invalid directory: ${path}')
		return
	}

	src_path := os.join_path(path, 'src')

	if !os.is_dir(src_path) {
		println('Invalid directory: ${src_path}')
		return
	}

	files := os.ls(path) or {
		eprintln('Error reading directory: ${err}')
		return
	}

	src_files := os.ls(src_path) or {
		eprintln('Error reading directory: ${err}')
		return
	}

	mut project_file := ''

	for file in files {
		if os.file_ext(file) == '.nexoproject' {
			project_file = file
			println('Found project file')
			break
		}
	}

	if project_file == '' {
		println("Can't found project file")
		return
	}

	for file in src_files {
		target_file := '${src_path}/${file}'
		if os.file_ext(target_file) != '.nexoscript' {
			println('Skipping: ${file} (Invalid extension, use .nexoscript)')
			continue
		}

		mut lines := os.read_lines(target_file) or {
			eprintln('Error reading file ${file}: ${err}')
			continue
		}

		mut modified_lines := []string{}

		for mut line in lines {
			println('Line: ${line_count} | Ctx: ${line}')

			mut words := extract_tokens(line)
			println('Extracted tokens: ${words}')

			mut previous_word := ''
			for key, value in instructions {
				for word in words {
					if word == key
						&& instructions[previous_word] !in ['0x00', '0x01', '0x02', '0x03', '0x04'] {
						line = line.replace_once(key, value)
					}
					previous_word = word
				}
			}

			modified_lines << extract_tokens(line).join(' ')
			line_count += 1
		}

		// Ensure output directory exists
		output_dir := os.join_path(path, 'build')
		if !os.exists(output_dir) {
			os.mkdir(output_dir) or {
				eprintln('Failed to create output directory: ${output_dir}')
				continue
			}
		} else {
			build_files := os.ls(output_dir) or {
				eprintln('Error reading directory: ${err}')
				return
			}
			for build_file in build_files {
				os.rm(os.join_path(output_dir, build_file)) or {
					panic("Can't delete file: ${file}")
				}
			}
		}

		// Write compiled output
		output_file := '${output_dir}/${file.replace('.nexoscript', '.ns.compiled')}'
		os.write_file(output_file, modified_lines.join('\n')) or {
			eprintln('Error writing to file: ${output_file}')
			continue
		}

		println('Compiled: ${src_path}/${file} → ${output_file}')
	}
	project_file_path := os.join_path(path, project_file)

	new_project_file_path := os.join_path(path, 'build', 'manifest.nexoproject')

	os.cp(project_file_path, new_project_file_path) or {
		eprintln('Error copying .nexoproject: ${err}')
		return
	}

	mut handler := runner.NexoProjectHandler{
		file_path: new_project_file_path
	}
	handler.load_project() or {
		eprintln(err)
		return
	}
	// handler.set("main", "file", "manifest.nexoproject")
}

fn extract_tokens(line string) []string {
	mut tokens := []string{}
	mut current := ''

	for c in line {
		if c.is_space() {
			if current.len > 0 {
				tokens << current
				current = ''
			}
			continue
		}

		// Keep special symbols separate
		if c in [`(`, `)`, `{`, `}`, `,`, `.`] {
			if current.len > 0 {
				tokens << current
				current = ''
			}
			tokens << c.ascii_str()
		} else {
			current += c.ascii_str()
		}
	}

	if current.len > 0 {
		tokens << current
	}

	return tokens
}
