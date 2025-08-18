function __multi_escape_init --description "Initialize or reset multi-escape clear state"
    # Reset counter and timing state
    set -g multi_escape_count 0
    set -g multi_escape_last_time 0
    
    echo "Multi-escape clear state initialized"
    echo "Current settings:"
    echo "  Threshold: $multi_escape_threshold presses"
    echo "  Timeout: $multi_escape_timeout_ms ms"
end