module runner

import os
import runner.build

pub fn parse_build_file(path string) build.Main {
	// Get a list of all files in the directory
	files := os.ls(path) or {
		eprintln('Failed to list directory: ${err}')
		return build.Main{
			file:   ''
			method: ''
		}
	}

	// Find the first file with a `.nexoscript` extension
	mut project_file := ''
	for file in files {
		if file.ends_with('.nexoproject') {
			project_file = file
			break
		}
	}

	if project_file == '' {
		println('No .nexoproject file available')
		return build.Main{
			file:   ''
			method: ''
		}
	}

	// Check if a .nexoproject file exists
	if os.exists(os.join_path(path, project_file)) {
		ctx := os.read_file(os.join_path(path, project_file)) or {
			panic('Failed to read .nexoproject file')
		}

		// Parse the file manually (since it's not JSON-based)
		project := build.parse_nexoproject(ctx) or { panic('Failed to parse .nexoproject file') }

		if project.name != '' {
			println('Project: ' + project.name)
		}
		if project.author != '' {
			println('Author: ' + project.author)
		}
		if project.version != '' {
			println('Version: ' + project.version)
		}
		if project.main.file != '' {
			println('Main_File: ' + project.main.file)
			return project.main
		} else {
			println('No main file found')
			return build.Main{
				file:   ''
				method: ''
			}
		}
		if project.libraries.len > 0 {
			println('Libraries:')
			for key, value in project.libraries {
				println('  ${key}: ${value}')
			}
		}
	} else {
		println('No .nexoproject file found.')
		return build.Main{
			file:   ''
			method: ''
		}
	}
}
