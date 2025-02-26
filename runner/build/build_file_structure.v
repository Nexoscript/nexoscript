module build

pub fn extract_value(line string) string {
	parts := line.split(':')
	if parts.len < 2 {
		return ''
	}
	return parts[1].trim_space().trim('"')
}

pub fn parse_nexoproject(file_content string) ?Project {
	mut name := ''
	mut version := ''
	mut author := ''
	mut main_file := ''
	mut main_method := ''
	mut libraries := map[string]string{}

	mut in_main := false
	mut in_libraries := false

	for line in file_content.split_into_lines() {
		line_trimmed := line.trim_space()

		// Skip empty lines or separators
		if line_trimmed == '' || line_trimmed == '---' {
			continue
		}

		// Detect library section
		if line_trimmed.starts_with('libraries: {') {
			in_libraries = true
			continue
		}
		if line_trimmed == '}' {
			in_libraries = false
			continue
		}

		if line_trimmed.starts_with('main: {') {
			in_main = true
			continue
		}
		if line_trimmed == '}' {
			in_main = false
			continue
		}

		if in_main {
			if line_trimmed.starts_with('file:') {
				main_file = extract_value(line_trimmed)
			}
			if line_trimmed.starts_with('method:') {
				main_method = extract_value(line_trimmed)
			}
		}

		// Parse key-value pairs
		if in_libraries {
			parts := line_trimmed.split(':')
			if parts.len == 2 {
				key := parts[0].trim_space()
				value := parts[1].trim_space().trim('"')
				libraries[key] = value
			}
		} else {
			if line_trimmed.starts_with('name:') {
				name = extract_value(line_trimmed)
			}
			if line_trimmed.starts_with('version:') {
				version = extract_value(line_trimmed)
			}
			if line_trimmed.starts_with('author:') {
				author = extract_value(line_trimmed)
			}
		}
	}

	return Project{
		name:      name
		version:   version
		author:    author
		main:      Main{
			file:   main_file
			method: main_method
		}
		libraries: libraries
	}
}

pub struct Project {
pub:
	name      string
	version   string
	author    string
	main      Main
	libraries map[string]string
}

pub struct Main {
pub:
	file   string
	method string
}
