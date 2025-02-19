module instructions

import regex

pub fn extract_between_quotes(text string) string {
	mut re := regex.regex_opt(r'"(.*?)"') or {panic('Regex Error')}
	matches := re.find_all_str(text)
	if matches.len > 0 {
		return matches[0][1..] // Entferne die äußeren Anführungszeichen
	}
	panic('Kein passender Text gefunden')
}
