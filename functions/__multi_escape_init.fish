function __multi_escape_init --description "Initialize or reset multi-escape clear state"
    # Reset counter and timing state
    set -g multi_escape_count 0
    set -g multi_escape_last_time 0
    
    # Remove existing bindings first
    bind -e \e 2>/dev/null
    bind -e \e\e 2>/dev/null
    bind -e \cl 2>/dev/null
    
    # Set up appropriate key binding based on mode
    if not set -q multi_escape_mode
        set -g multi_escape_mode escape
    end
    
    switch $multi_escape_mode
        case escape
            bind \e __multi_escape_handler
        case alt-escape
            bind \e\e __multi_escape_handler
        case ctrl-l
            bind \cl __multi_escape_handler
    end
    
    echo "Multi-escape clear state initialized"
    echo "Current settings:"
    echo "  Threshold: $multi_escape_threshold presses"
    echo "  Timeout: $multi_escape_timeout_ms ms"
    echo "  Mode: $multi_escape_mode"
end