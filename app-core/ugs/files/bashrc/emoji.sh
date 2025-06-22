#!/usr/bin/env bash
# /etc/emoji_support.sh

# Function to detect if emoji support is available
detect_emoji_support() {
    # Check if the terminal supports UTF-8 encoding
    [[ -t 1 ]] || return 1
    case "${LANG}${LC_CTYPE}" in
        *[Uu][Tt][Ff][-_]*8*) ;;  # Unicode UTF-8
        *[Uu][Tt][Ff]8*) ;;       # UTF-8 encoding
        *) return 1 ;;             # Not supported
    esac

    # Exclude terminal types that do not support emojis (like 'dumb' or 'linux')
    case "$TERM" in
        dumb|linux) return 1 ;;
    esac

    return 0  # Emoji support is available
}

# Function to set emoji variables
set_emoji_vars() {
    if detect_emoji_support; then
        export EMOJI_OK=true
        # Emoji representations when emojis are supported
        export ICON_OK="✅"          # Success
        export ICON_BAD="🚫"         # Error
        export ICON_INFO="ℹ️"        # Information
        export ICON_WARN="⚠️"        # Warning
        export ICON_SAD="😢"         # Sad/Error
        export ICON_DR="🧪"          # Dry-run
        export ICON_REAL="🗃️"       # Real/Active
        export ICON_FILE="📄"        # File
        export ICON_BYTE="💾"        # Byte
        export ICON_DUP="🔗"         # Duplicate
        export ICON_SAVE="🪙"        # Save
        export ICON_LOADING="⏳"     # Loading/Wait
        export ICON_CHECK="✔️"       # Checkmark
        export ICON_CROSS="❌"       # Crossmark
        export ICON_UPLOAD="⬆️"     # Upload
        export ICON_DOWNLOAD="⬇️"   # Download
        export ICON_COPY="📋"        # Copy
        export ICON_FOLDER="📂"      # Folder
        export ICON_LINK="🔗"        # Hyperlink
        export ICON_NEW="🆕"         # New
        export ICON_WARNING="⚠️"     # Alert/Warning
        export ICON_TASK="📋"        # Task/Checklist
        export ICON_SUCCESS="🏆"     # Success/Completion
    else
        export EMOJI_OK=false
        # Fallback text representations when emojis are not supported
        export ICON_OK="[OK]"        # Success
        export ICON_BAD="[NO]"       # Error
        export ICON_INFO="[INFO]"    # Information
        export ICON_WARN="[WARN]"    # Warning
        export ICON_SAD=":("         # Sad/Error
        export ICON_DR="[DRY-RUN]"   # Dry-run
        export ICON_REAL="[DEDUP]"   # Real/Active
        export ICON_FILE="[F]"       # File
        export ICON_BYTE="[B]"       # Byte
        export ICON_DUP="[DUP]"      # Duplicate
        export ICON_SAVE="[$]"       # Save
        export ICON_LOADING="[LOADING]" # Loading/Wait
        export ICON_CHECK="[CHECK]"  # Checkmark
        export ICON_CROSS="[CROSS]"  # Crossmark
        export ICON_UPLOAD="[UPLOAD]" # Upload
        export ICON_DOWNLOAD="[DOWNLOAD]" # Download
        export ICON_COPY="[COPY]"    # Copy
        export ICON_FOLDER="[FOLDER]" # Folder
        export ICON_LINK="[LINK]"    # Hyperlink
        export ICON_NEW="[NEW]"      # New
        export ICON_WARNING="[WARNING]" # Alert/Warning
        export ICON_TASK="[TASK]"    # Task/Checklist
        export ICON_SUCCESS="[SUCCESS]" # Success/Completion
    fi
}

# Initialize emoji variables when this script is sourced
set_emoji_vars
