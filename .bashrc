# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export _JAVA_AWT_WM_NONREPARENTING=1

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Sets or clears the target IP displayed in Polybar
target(){
    local target_file="$HOME/.config/polybar/scripts/target.txt"

    if [[ $# -eq 0 ]]; then
        # No arguments — clear the target
        echo "" > "$target_file"
    elif [[ $# -eq 1 ]]; then
        # Validate IP format with regex
        if [[ "$1" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            local ip="$1"
            local valid=true
            # Validate each octet is between 0 and 255
            IFS='.' read -ra octets <<< "$ip"
            for octet in "${octets[@]}"; do
                if [[ $octet -gt 255 ]]; then
                    valid=false
                    break
                fi
            done
            if $valid; then
                echo "$1" > "$target_file"
            else
                echo "Error: invalid IP (octets must be between 0 and 255)"
            fi
        else
            echo "Error: '$1' is not a valid IP address"
            echo "Usage: target [ip]"
            echo "  target 10.10.10.10  → set target IP in Polybar"
            echo "  target              → clear target IP from Polybar"
        fi
    else
        echo "Usage: target [ip]"
        echo "  target 10.10.10.10  → set target IP in Polybar"
        echo "  target              → clear target IP from Polybar"
    fi
}
