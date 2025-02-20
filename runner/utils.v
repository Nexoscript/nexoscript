module runner

import regex

pub fn extract_between_quotes(text string) string {
	// Simpler regex: match anything between quotes
	mut re := regex.regex_opt(r'"([^"]*)"') or { panic('Regex Error') }
	matches := re.find_all_str(text)
	if matches.len > 0 {
		mut result := matches[0]
		if result.starts_with('"') && result.ends_with('"') {
			result = result[1..result.len - 1]
		}
		return result.replace(r'\"', '"')
	}
	panic('No text found')
}
