#!/usr/bin/env bash
# /etc/emoji-logging.sh — single file library + autoloader

# optional autoload behavior
# - if this file is executed by profile.d, it will export BASH_ENV so non-interactive bash also sources it
# - if this file is used as BASH_ENV, it will only define vars and functions then return

# detect execution mode
_EMOJI_LOG_FROM_PROFILED=0
if [[ "${BASH_SOURCE[0]}" == "/etc/profile.d/emoji-logging.sh" || "${0##*/}" == "emoji-logging.sh" && -n "${PS1:-}" ]]; then
  _EMOJI_LOG_FROM_PROFILED=1
fi

# allow opt-out via env
[[ "${EMOJI_LOG_DISABLE:-0}" = 1 ]] && return 0

# export BASH_ENV for non-interactive bash if we’re running as a profile.d script
if (( _EMOJI_LOG_FROM_PROFILED )); then
  # avoid loops if someone already pointed BASH_ENV here
  if [[ "${BASH_ENV:-}" != "/etc/emoji-logging.sh" ]]; then
    export BASH_ENV=/etc/emoji-logging.sh
  fi
fi

# guard against multiple sourcing
if [[ -z "${_EMOJI_LOG_LIB:-}" ]]; then
  _EMOJI_LOG_LIB=1

  # detect if emoji support is available
  detect_emoji_support() {
    [[ -t 1 ]] || return 1
    case "${LANG}${LC_CTYPE}" in
      *[Uu][Tt][Ff][-_]*8*) ;;
      *[Uu][Tt][Ff]8*) ;;
      *) return 1 ;;
    esac
    case "$TERM" in
      dumb|linux) return 1 ;;
    esac
    return 0
  }

  # set emoji and fallback variables
  set_emoji_vars() {
    if detect_emoji_support; then
      export EMOJI_OK=true
      export ICON_OK="✅"
      export ICON_BAD="🚫"
      export ICON_INFO="ℹ️"
      export ICON_WARN="⚠️"
      export ICON_SAD="😢"
      export ICON_DR="🧪"
      export ICON_REAL="🗃️"
      export ICON_FILE="📄"
      export ICON_BYTE="💾"
      export ICON_DUP="🔗"
      export ICON_SAVE="🪙"
      export ICON_LOADING="⏳"
      export ICON_CHECK="✔️"
      export ICON_CROSS="❌"
      export ICON_UPLOAD="⬆️"
      export ICON_DOWNLOAD="⬇️"
      export ICON_COPY="📋"
      export ICON_FOLDER="📂"
      export ICON_LINK="🔗"
      export ICON_NEW="🆕"
      export ICON_WARNING="⚠️"
      export ICON_TASK="📋"
      export ICON_SUCCESS="🏆"
    else
      export EMOJI_OK=false
      export ICON_OK="[OK]"
      export ICON_BAD="[NO]"
      export ICON_INFO="[INFO]"
      export ICON_WARN="[WARN]"
      export ICON_SAD=":("
      export ICON_DR="[DRY-RUN]"
      export ICON_REAL="[DEDUP]"
      export ICON_FILE="[F]"
      export ICON_BYTE="[B]"
      export ICON_DUP="[DUP]"
      export ICON_SAVE="[$]"
      export ICON_LOADING="[LOADING]"
      export ICON_CHECK="[CHECK]"
      export ICON_CROSS="[CROSS]"
      export ICON_UPLOAD="[UPLOAD]"
      export ICON_DOWNLOAD="[DOWNLOAD]"
      export ICON_COPY="[COPY]"
      export ICON_FOLDER="[FOLDER]"
      export ICON_LINK="[LINK]"
      export ICON_NEW="[NEW]"
      export ICON_WARNING="[WARNING]"
      export ICON_TASK="[TASK]"
      export ICON_SUCCESS="[SUCCESS]"
    fi
  }

  # initialize emoji variables now
  set_emoji_vars

  # defaults if caller overrides or sources without set_emoji_vars
  : "${ICON_OK:=OK}"
  : "${ICON_BAD:=ERR}"
  : "${ICON_INFO:=INFO}"
  : "${ICON_WARN:=WARN}"
  : "${ICON_TASK:=TASK}"
  : "${ICON_DR:=DRY}"
  : "${ICON_REAL:=RUN}"
  : "${ICON_LOADING:=...}"
  : "${ICON_SUCCESS:=DONE}"

  # log level control
  : "${LOG_LEVEL:=3}"   # 0=quiet 1=error 2=warn 3=info 4=debug

  # optional prefix like script name or component
  : "${LOG_PREFIX:=}"

  # detect if stderr is a TTY
  _log_isatty() { [[ -t 2 ]]; }

  # timestamp control
  : "${LOG_TS:=auto}"  # auto|on|off
  _log_ts() {
    case "$LOG_TS" in
      on) date +%H:%M:%S ;;
      auto) _log_isatty && date +%H:%M:%S || echo -n "" ;;
      off|*) echo -n "" ;;
    esac
  }

  # compose prefix
  _log_pfx() {
    local ts pfx out=""
    ts=$(_log_ts)
    pfx=${LOG_PREFIX:+$LOG_PREFIX }
    [[ -n "$ts" ]] && out+="[$ts] "
    out+="$pfx"
    printf "%s" "$out"
  }

  # core printer
  # $1=level_num $2=icon $3=label $4...=message
  _log_print() {
    local lvl="$1" ico="$2" lab="$3"; shift 3
    (( LOG_LEVEL < lvl )) && return 0
    if [[ -n "$lab" ]]; then
      printf "%s%s%s %s\n" "$(_log_pfx)" "${lab:+[$lab] }" "$ico" "$*" >&2
    else
      printf "%s%s %s\n" "$(_log_pfx)" "$ico" "$*" >&2
    fi
  }

  # public helpers
  log_debug()   { _log_print 4 "${ICON_INFO}"  "DBG" "$*"; }
  log_info()    { _log_print 3 "${ICON_INFO}"  ""   "$*"; }
  log_warn()    { _log_print 2 "${ICON_WARN}"  ""   "$*"; }
  log_ok()      { _log_print 3 "${ICON_OK}"    ""   "$*"; }
  log_success() { _log_print 3 "${ICON_SUCCESS}" "" "$*"; }
  log_error()   { _log_print 1 "${ICON_BAD}"   ""   "$*"; }
  log_task()    { _log_print 3 "${ICON_TASK}"  ""   "$*"; }
  log_dry()     { _log_print 3 "${ICON_DR}"    ""   "$*"; }
  log_run()     { _log_print 3 "${ICON_REAL}"  ""   "$*"; }

  # fatal helper
  log_die() { log_error "$*"; exit 1; }
fi

# if we were run as a script under profile.d, we’re done
# if we were sourced as BASH_ENV, the functions and vars are now available
