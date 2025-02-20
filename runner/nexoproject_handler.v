module runner

import os

pub struct NexoProjectHandler {
pub:
	file_path string
mut:
	project_data map[string]map[string]string
}

pub fn (mut handler NexoProjectHandler) load_project() ? {
	println(handler.file_path)
	content := os.read_file(handler.file_path) or { panic('Error loading project: ${err}') }

	lines := content.split('\n')
	mut current_key := ''

	for line in lines {
		trimmed := line.trim_space()

		if trimmed.len == 0 {
			continue
		}

		if trimmed.ends_with('{') {
			current_key = trimmed.replace(': {', '').trim_space()
			handler.project_data[current_key] = map[string]string{}
			continue
		}

		if trimmed.ends_with('}') {
			current_key = ''
			continue
		}

		if !trimmed.contains(':') { // Fixed here
			continue
		}

		parts := trimmed.split(':')
		if parts.len < 2 {
			continue
		}

		key := parts[0].trim_space().trim('"')
		value := parts[1].trim_space().trim('"')

		if current_key != '' {
			handler.project_data[current_key][key] = value
			continue
		}

		handler.project_data[key] = {
			key: value
		}
	}

	println('Project loaded successfully.')
}

pub fn (handler NexoProjectHandler) get(section string, key string) string {
	return handler.project_data[section][key] or { panic('Key not found') } // Fixed here
}

pub fn (mut handler NexoProjectHandler) set(section string, key string, value string) {
	if section !in handler.project_data {
		handler.project_data[section] = map[string]string{}
	}
	// Trim quotes around key only
	handler.project_data[section][key.trim('"')] = value
}

pub fn (mut handler NexoProjectHandler) add(section string, key string, value string) {
	handler.set(section, key, value)
}

pub fn (mut handler NexoProjectHandler) remove(section string, key string) {
	if section in handler.project_data {
		handler.project_data[section].delete(key)
	}
}

pub fn (handler NexoProjectHandler) save() ? {
	mut content := ''

	for section, data in handler.project_data {
		content += '${section}: {\n'
		for key, value in data {
			content += '  ${key}: "${value}"\n' // Quotes only around values
		}
		content += '}\n\n'
	}

	os.write_file(handler.file_path, content) or { panic('Error saving project: ${err}') }
	println('Project saved successfully.')
}
