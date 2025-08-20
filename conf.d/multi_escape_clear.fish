# Multi-Escape Clear Plugin Configuration
# This file initializes the plugin and sets up event handlers

# Initialize plugin variables if not already set
if not set -q multi_escape_threshold
    set -g multi_escape_threshold 3
end

if not set -q multi_escape_timeout_ms
    set -g multi_escape_timeout_ms 1000
end

if not set -q multi_escape_mode
    set -g multi_escape_mode escape
end

# Initialize state variables
set -g multi_escape_count 0
set -g multi_escape_last_time 0

# Set up key binding based on mode
switch $multi_escape_mode
    case escape
        bind \e __multi_escape_handler
    case alt-escape
        bind \e\e __multi_escape_handler
    case ctrl-l
        bind \cl __multi_escape_handler
end

# Install event handler
function _multi_escape_clear_install --on-event multi_escape_clear_install
    echo "✓ Multi-escape clear plugin installed!"
    echo "  Press Esc $multi_escape_threshold times quickly to clear input"
    echo "  Configure with: __multi_escape_config --help"
end

# Update event handler  
function _multi_escape_clear_update --on-event multi_escape_clear_update
    echo "✓ Multi-escape clear plugin updated!"
end

# Uninstall event handler
function _multi_escape_clear_uninstall --on-event multi_escape_clear_uninstall
    # Kill any running cleanup job
    if set -q __multi_escape_cleanup_pid
        kill $__multi_escape_cleanup_pid 2>/dev/null
    end
    
    # Clean up global variables
    set -e multi_escape_count multi_escape_last_time multi_escape_threshold multi_escape_timeout_ms multi_escape_mode __multi_escape_cleanup_pid
    
    # Remove all possible key bindings
    bind -e \e 2>/dev/null
    bind -e \e\e 2>/dev/null
    bind -e \cl 2>/dev/null
    
    echo "✓ Multi-escape clear plugin uninstalled"
    echo "  All variables and key bindings have been cleaned up"
end