function __multi_escape_handler --description "Handle multiple escape key presses to clear input"
    # Initialize counter variables if needed
    if not set -q multi_escape_count
        set -g multi_escape_count 0
        set -g multi_escape_last_time 0
    end
    
    # Get current time in milliseconds
    set -l current_time (date +%s%3N)
    
    # Calculate time difference since last escape press
    set -l time_diff (math $current_time - $multi_escape_last_time)
    
    # Reset counter if too much time has passed
    if test $time_diff -gt $multi_escape_timeout_ms
        set -g multi_escape_count 0
    end
    
    # Increment counter for this press
    set -g multi_escape_count (math $multi_escape_count + 1)
    
    # Update last press time
    set -g multi_escape_last_time $current_time
    
    # Check if we've reached the threshold
    if test $multi_escape_count -ge $multi_escape_threshold
        # First cancel any pending operations (handles multiline/complex inputs properly)
        commandline -f cancel-commandline
        # Then clear the command line completely
        commandline -r ""
        set -g multi_escape_count 0
        # Force a proper repaint
        commandline -f repaint
    end
    # If we haven't reached threshold, do nothing (default Fish escape behavior)
    
    # No visual feedback - it's too problematic with Fish's limitations
    # The feature works silently
end