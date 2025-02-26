module runner

__global (
	variables map[string]map[string]any
)

pub fn init_variables() {
	variables = map[string]map[string]any{}
}

pub fn add_variable(function_name string, variable_name string, value any) {
	if function_name !in variables {
		variables[function_name] = map[string]any{}
	}
	variables[function_name][variable_name] = value
}

pub fn remove_variable(function_name string, variable_name string) {
	if function_name in variables {
		variables[function_name].delete(variable_name)
		if variables[function_name].len == 0 {
			variables.delete(function_name)
		}
	}
}

pub fn get_variable(function_name string, variable_name string) ?any {
	if function_name in variables && variable_name in variables[function_name] {
		return variables[function_name][variable_name]
	}
	return error('Variable nicht gefunden')
}

pub fn get_variables() map[string]map[string]any {
	return variables
}
