# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export _JAVA_AWT_WM_NONREPARENTING=1

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias burp='/usr/bin/burpsuite > /dev/null 2>&1 & disown'
alias fire='/usr/bin/firefox > /dev/null 2>&1 & disown'
alias wire='/usr/bin/wireshark > /dev/null 2>&1 & disown'
PS1='\[\e[32m\][ \[\e[0m\]\[\e[38;2;59;113;202m\]\w\[\e[0m\]\[\e[32m\] ]\[\e[0m\] \[\e[38;2;159;166;178m\]❯❯\[\e[0m\] '

# Sets or clears the target IP (and optional port) displayed in Polybar
target(){
    local target_file="$HOME/.config/polybar/scripts/target.txt"

    if [[ $# -eq 0 ]]; then
        # No arguments — clear the target
        echo "" > "$target_file"
    elif [[ $# -eq 1 ]]; then
        # Split IP and optional port
        local ip="${1%%:*}"
        local port="${1##*:}"
        [[ "$ip" == "$port" ]] && port=""

        # Validate IP format with regex
        if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            local valid=true
            # Validate each octet is between 0 and 255
            IFS='.' read -ra octets <<< "$ip"
            for octet in "${octets[@]}"; do
                if [[ $octet -gt 255 ]]; then
                    valid=false
                    break
                fi
            done

            # Validate port if provided
            if [[ -n "$port" ]] && ! [[ "$port" =~ ^[0-9]+$ && $port -ge 1 && $port -le 65535 ]]; then
                echo "Error: invalid port (must be between 1 and 65535)"
                return 1
            fi

            if $valid; then
                echo "$1" > "$target_file"
            else
                echo "Error: invalid IP (octets must be between 0 and 255)"
            fi
        else
            echo "Error: '$ip' is not a valid IP address"
            echo "Usage: target [ip] or target [ip:port]"
            echo "  target 10.10.10.10        → set target IP in Polybar"
            echo "  target 10.10.10.10:8080   → set target IP and port in Polybar"
            echo "  target                    → clear target from Polybar"
        fi
    else
        echo "Usage: target [ip] or target [ip:port]"
        echo "  target 10.10.10.10        → set target IP in Polybar"
        echo "  target 10.10.10.10:8080   → set target IP and port in Polybar"
        echo "  target                    → clear target from Polybar"
    fi
}

# Extracts open ports from any nmap output file (.gnmap, .nmap, .xml)
ports(){
    local usage="Usage: ports <file>
  ports lookup.gnmap   → parses grepable nmap output
  ports lookup.nmap    → parses normal nmap output
  ports lookup.xml     → parses XML nmap output"

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

    case "$file" in
        *.gnmap)
            result=$(grep -oP '\d{1,5}/open' "$file" | awk -F'/' '{print $1}' | sort -un | xargs | tr ' ' ',')
            ;;
        *.nmap)
            result=$(grep -oP '^\s*\d{1,5}/\w+\s+open' "$file" | grep -oP '^\s*\d+' | tr -d ' ' | sort -un | xargs | tr ' ' ',')
            ;;
        *.xml)
            result=$(grep 'state="open"' "$file" | grep -oP 'portid="\K\d+' | sort -un | xargs | tr ' ' ',')
            ;;
        *)
            echo "Error: unrecognized file extension (expected .gnmap, .nmap or .xml)"
            echo "$usage"
            return 1
            ;;
    esac

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

# Obfuscates sensitive data (flags, passwords, users, etc.) and copies to clipboard
mask(){
    if [[ $# -eq 0 ]]; then
        echo "Usage: mask <value>"
        return 1
    fi

    local input="$1"
    local masked
    masked=$(printf '%0.s*' $(seq 1 ${#input}))

    echo "$masked"

    if command -v xclip &>/dev/null; then
        echo -n "$masked" | xclip -selection clipboard
    else
        echo "[!] xclip not found — install it with: sudo pacman -S xclip"
    fi
}

# Python venv manager
venv(){
    local venv_dir="venv"
    local libs=()

    # Parse -l flag and collect libraries
    local args=()
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -l)
                shift
                while [[ $# -gt 0 && "$1" != -* ]]; do
                    libs+=("$1")
                    shift
                done
                ;;
            *) args+=("$1"); shift ;;
        esac
    done
    set -- "${args[@]}"

    case "$1" in
        -d)
            if [[ -z "$VIRTUAL_ENV" ]]; then
                echo "Error: no active virtual environment"
                return 1
            fi
            deactivate
            ;;
        -r)
            if [[ ! -d "$venv_dir" ]]; then
                echo "Error: no venv found in current directory"
                return 1
            fi
            if [[ -n "$VIRTUAL_ENV" ]]; then
                deactivate
            fi
            rm -rf "$venv_dir"
            echo "[+] venv removed"
            ;;
        "")
            if [[ -d "$venv_dir" ]]; then
                source "$venv_dir/bin/activate"
                echo "[+] venv activated"
            else
                python3 -m venv "$venv_dir"
                source "$venv_dir/bin/activate"
                echo "[+] venv created and activated"
            fi

            if [[ ${#libs[@]} -gt 0 ]]; then
                echo "[*] Installing libraries: ${libs[*]}"
                python3 -m pip install "${libs[@]}"
            fi
            ;;
        *)
            echo "Usage: venv [-d|-r] [-l lib1 lib2 ...]"
            echo "  venv                          → create venv if needed, then activate"
            echo "  venv -l requests flask        → create/activate and install libraries"
            echo "  venv -d                       → deactivate current venv"
            echo "  venv -r                       → deactivate (if active) and remove venv"
            return 1
            ;;
    esac
}

# Downloads linpeas.sh to the current directory as lp.sh
linpeas(){
    local url="https://github.com/peass-ng/PEASS-ng/releases/download/20260212-43b28429/linpeas.sh"
    local output="lp.sh"

    if [[ -f "$output" ]]; then
        echo "[!] $output already exists in current directory"
        return 1
    fi

    echo "[*] Downloading linpeas..."
    if curl -sL "$url" -o "$output"; then
        chmod +x "$output"
        echo "[+] Saved as $output"
    else
        echo "[-] Download failed"
        rm -f "$output"
        return 1
    fi
}

# VPN manager for HTB, HTB Academy and THM
vpn(){
    local config_dir="$HOME/.config/vpn"
    local usage="Usage: vpn -c <htb|htba|thm>
  vpn -c htb   → connect to HackTheBox
  vpn -c htba  → connect to HackTheBox Academy
  vpn -c thm   → connect to TryHackMe"

    if [[ $# -eq 0 ]]; then
        echo "Error: no arguments provided"
        echo "$usage"
        return 1
    fi

    if [[ "$1" != "-c" ]]; then
        echo "Error: unknown flag '$1'"
        echo "$usage"
        return 1
    fi

    if [[ -z "$2" ]]; then
        echo "Error: no VPN specified"
        echo "$usage"
        return 1
    fi

    local config

    case "$2" in
        htb)  config="$config_dir/htb.ovpn"  ;;
        htba) config="$config_dir/htba.ovpn" ;;
        thm)  config="$config_dir/thm.ovpn"  ;;
        *)
            echo "Error: unknown VPN '$2' (expected htb, htba or thm)"
            echo "$usage"
            return 1
            ;;
    esac

    if [[ ! -f "$config" ]]; then
        echo "Error: config file not found at '$config'"
        return 1
    fi

    echo "[*] Connecting to $2 VPN..."
    sudo openvpn --config "$config"
}
