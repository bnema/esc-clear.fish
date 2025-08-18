# Tab completions for __multi_escape_config command

# Threshold completion
complete -c __multi_escape_config -s t -l threshold -d "Set escape press threshold (1-10)" -x -a "1 2 3 4 5 6 7 8 9 10"

# Timeout completion  
complete -c __multi_escape_config -s o -l timeout -d "Set timeout in milliseconds (100-5000)" -x -a "100 200 500 1000 1500 2000 3000 5000"

# Feedback toggle (no arguments needed)
complete -c __multi_escape_config -s f -l feedback -d "Toggle visual feedback"

# Reset (no arguments needed)
complete -c __multi_escape_config -s r -l reset -d "Reset all settings to defaults"

# Status (no arguments needed)
complete -c __multi_escape_config -s s -l status -d "Show current settings"

# Help (no arguments needed)
complete -c __multi_escape_config -s h -l help -d "Show help message"