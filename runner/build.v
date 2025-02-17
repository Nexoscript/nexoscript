module runner

import json
import os
import runner.build

pub fn parse_build_file(path string) string {
	if os.exists(path + '/build.json') {
		ctx := os.read_file(path + '/build.json') or { panic('Failed to read file') }
		mut build_config := build.BuildFileStructure{}
		build_config = json.decode(build.BuildFileStructure, ctx) or {
			panic('Failed to decode Json String')
		}
		if build_config.project != '' {
			println('Project: ' + build_config.project)
		}
		if build_config.author != '' {
			println('Author: ' + build_config.author)
		}
		if build_config.description != '' {
			println('Description: ' + build_config.description)
		}
		if build_config.version != '' {
			println('Version: ' + build_config.version)
		}
		if build_config.website != '' {
			println('Website: ' + build_config.website)
		}
		if build_config.main_file != '' {
			println('Main_File: ' + build_config.main_file)
			return path + '/' + build_config.main_file
		} else {
			return ''
		}
	}
}
