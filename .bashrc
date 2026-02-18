# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export _JAVA_AWT_WM_NONREPARENTING=1

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias burp='/usr/bin/burpsuite > /dev/null 2>&1 & disown'
alias fire='/usr/bin/firefox > /dev/null 2>&1 & disown'
PS1='\[\e[32m\][ \[\e[0m\]\[\e[38;2;59;113;202m\]\w\[\e[0m\]\[\e[32m\] ]\[\e[0m\] \[\e[38;2;159;166;178m\]❯❯\[\e[0m\] '

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

# Extracts open ports from a .gnmap scan file
ports(){
    local usage="Usage: ports <file.gnmap>
  ports lookup.gnmap   → returns open ports as comma-separated list (e.g. 22,80,443)"

    if [[ $# -eq 0 ]]; then
        echo "Error: no file specified"
        echo "$usage"
        return 1
    fi

    if [[ $# -gt 1 ]]; then
        echo "Error: too many arguments"
        echo "$usage"
        return 1
    fi

    local file="$1"

    if [[ ! -f "$file" ]]; then
        echo "Error: '$file' is not a valid file"
        echo "$usage"
        return 1
    fi

    local result
    result=$(grep -oP '\d{1,5}/open' "$file" | awk -F'/' '{print $1}' | sort -un | xargs | tr ' ' ',')

    if [[ -z "$result" ]]; then
        echo "No open ports found in '$file'"
        return 1
    fi

    echo "$result"

    if command -v xclip &>/dev/null; then
        echo -n "$result" | xclip -selection clipboard
    else
      echo "[!] xclip not found — install it with: sudo pacman -S xclip"
    fi
}
