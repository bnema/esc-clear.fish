# Fish Multi-Escape Clear

A Fish shell plugin that clears the command line input when you rapidly press the Escape key multiple times.

## Features

- **Configurable threshold**: Set how many escape presses are needed (default: 3)
- **Timing control**: Configure the time window for detecting rapid presses (default: 1000ms)
- **Multiple trigger modes**: Choose between escape, alt-escape, or ctrl-l key bindings
- **Safe multiline handling**: Properly cancels operations before clearing complex inputs
- **Clean integration**: Uses Fish's native key binding system
- **Easy configuration**: Simple command-line configuration interface
- **Proper cleanup**: Automatically removes bindings and variables on uninstall

## Installation

### Prerequisites

First, install [Fisher](https://github.com/jorgebucaran/fisher) if you haven't already:

```fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

### Install the Plugin

**From GitHub**:
```fish
fisher install bnema/esc-clear.fish
```

**From local directory**:
```fish
fisher install /path/to/esc-clear.fish
# or from your home directory
fisher install ~/esc-clear.fish
```

**From current directory**:
```fish
fisher install .
```

## Usage

Simply press the Escape key multiple times quickly to clear the current command line input.

**Default behavior**: Press Esc 3 times within 1 second to clear the input line.

## Configuration

Configure the plugin using the `__multi_escape_config` command:

### View current settings
```fish
__multi_escape_config
# or
__multi_escape_config --status
```

### Change threshold
```fish
__multi_escape_config --threshold 2    # Require only 2 presses
__multi_escape_config --threshold 5    # Require 5 presses
```

### Adjust timeout
```fish
__multi_escape_config --timeout 500    # 500ms window  
__multi_escape_config --timeout 2000   # 2 second window
```

### Change trigger mode
```fish
__multi_escape_config --mode escape      # Default: Escape key
__multi_escape_config --mode alt-escape  # Alt+Escape (recommended for safety)
__multi_escape_config --mode ctrl-l      # Ctrl+L (alternative option)
```


### Reset to defaults
```fish
__multi_escape_config --reset
```

### Get help
```fish
__multi_escape_config --help
```

## Configuration Variables

The following global variables control the plugin behavior:

- `multi_escape_threshold`: Number of presses needed (1-10, default: 3)
- `multi_escape_timeout_ms`: Time window in milliseconds (100-5000, default: 1000)
- `multi_escape_mode`: Trigger mode (escape, alt-escape, ctrl-l, default: escape)


## Uninstallation

```fish
fisher remove bnema/esc-clear.fish
```

The plugin will automatically clean up all variables and key bindings.

## Compatibility

- **Fish Shell**: 3.0+
- **Fisher**: Any version
- **Terminal**: Any terminal that supports Fish shell

## Implementation Details

- Uses millisecond-precision timing via `date +%s%3N`
- Binds to the raw escape key (`\e`) 
- Maintains state using global variables
- Provides proper Fisher install/uninstall event handlers
- Follows Fish shell naming conventions with `__` prefix for private functions

## Troubleshooting

### Plugin not working after installation
Try restarting your Fish shell or run:
```fish
__multi_escape_init
```

### Conflicts with other escape key bindings
The plugin binds to the escape key by default. If you have other plugins that also bind escape, there may be conflicts. You can avoid this by using alternative trigger modes:
```fish
__multi_escape_config --mode alt-escape  # Use Alt+Escape instead
__multi_escape_config --mode ctrl-l      # Use Ctrl+L instead
```

Check your current bindings with:
```fish
bind | grep escape
```



## License

MIT License - see LICENSE file for details.