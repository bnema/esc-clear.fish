function __multi_escape_config --description "Configure multi-escape clear plugin settings"
    argparse 't/threshold=' 'o/timeout=' 'r/reset' 's/status' 'h/help' -- $argv
    or return 1
    
    if set -q _flag_help
        echo "Multi-Escape Clear Plugin Configuration"
        echo ""
        echo "Usage: __multi_escape_config [options]"
        echo ""
        echo "Options:"
        echo "  -t, --threshold NUM    Set escape press threshold (1-10, default: 3)"
        echo "  -o, --timeout MS       Set timeout in milliseconds (100-5000, default: 1000)"
        echo ""
        echo "  -r, --reset            Reset all settings to defaults"
        echo "  -s, --status           Show current settings"
        echo "  -h, --help             Show this help message"
        echo ""
        echo "Examples:"
        echo "  __multi_escape_config --threshold 2      # Require only 2 presses"
        echo "  __multi_escape_config --timeout 500      # Set 500ms timeout"
        echo ""
        echo "  __multi_escape_config --reset            # Reset to defaults"
        return 0
    end
    
    if set -q _flag_reset
        set -g multi_escape_threshold 3
        set -g multi_escape_timeout_ms 1000
        __multi_escape_init
        echo "✓ Settings reset to defaults"
        return 0
    end
    
    if set -q _flag_threshold
        set -l threshold (math $_flag_threshold)
        if test $threshold -ge 1 -a $threshold -le 10
            set -g multi_escape_threshold $threshold
            echo "✓ Threshold set to: $multi_escape_threshold presses"
            __multi_escape_init
        else
            echo "✗ Error: Threshold must be between 1 and 10"
            return 1
        end
    end
    
    if set -q _flag_timeout
        set -l timeout (math $_flag_timeout)
        if test $timeout -ge 100 -a $timeout -le 5000
            set -g multi_escape_timeout_ms $timeout
            echo "✓ Timeout set to: $multi_escape_timeout_ms ms"
            __multi_escape_init
        else
            echo "✗ Error: Timeout must be between 100 and 5000 milliseconds"
            return 1
        end
    end
    
    
    if set -q _flag_status; or test (count $argv) -eq 0
        echo "Multi-Escape Clear Plugin Status:"
        echo ""
        echo "  Threshold: $multi_escape_threshold presses"
        echo "  Timeout: $multi_escape_timeout_ms ms"
        echo "  Current count: $multi_escape_count"
        echo ""
        echo "Usage: Press Esc $multi_escape_threshold times within $multi_escape_timeout_ms ms to clear input"
    end
end