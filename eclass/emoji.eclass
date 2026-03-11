# Distributed under the terms of the GNU General Public License v2
# @ECLASS: emoji.eclass

case ${EAPI} in
	5|6|7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_EMOJI_ECLASS:-} ]]; then
_EMOJI_ECLASS=1

# detects whether the current terminal can display emojis
detect_emoji_support() {
	[[ -t 1 ]] || return 1
	case "${LANG:-}${LC_CTYPE:-}" in
		*[Uu][Tt][Ff][-_]*8*|*[Uu][Tt][Ff]8*) ;;
		*) return 1 ;;
	esac
	case ${TERM:-} in
		''|dumb|linux) return 1 ;;
	esac
	return 0
}

# detects whether the current terminal can display ANSI colours
detect_color_support() {
	[[ -t 1 ]] || return 1
	case ${TERM:-} in
		''|dumb|linux) return 1 ;;
	esac
	return 0
}

# sets ICON_* variables to emojis or ASCII fallbacks
set_emoji_vars() {
	if detect_emoji_support; then
		export EMOJI_OK=true
		ICON_OK="✅"  ICON_BAD="🚫"  ICON_INFO="ℹ️"   ICON_WARN="⚠️"
		ICON_SAD="😢" ICON_DR="🧪"  ICON_REAL="🗃️"   ICON_FILE="📄"
		ICON_BYTE="💾" ICON_DUP="🔗" ICON_SAVE="🪙"   ICON_LOADING="⏳"
		ICON_CHECK="✔️" ICON_CROSS="❌" ICON_UPLOAD="⬆️" ICON_DOWNLOAD="⬇️"
		ICON_COPY="📋" ICON_FOLDER="📂" ICON_LINK="🔗" ICON_NEW="🆕"
		ICON_WARNING="⚠️" ICON_TASK="📋" ICON_SUCCESS="🏆"
	else
		export EMOJI_OK=false
		ICON_OK="[OK]" ICON_BAD="[NO]" ICON_INFO="[INFO]" ICON_WARN="[WARN]"
		ICON_SAD=":(" ICON_DR="[DRY]" ICON_REAL="[DEDUP]" ICON_FILE="[F]"
		ICON_BYTE="[B]" ICON_DUP="[DUP]" ICON_SAVE="[$]" ICON_LOADING="[WAIT]"
		ICON_CHECK="[CHECK]" ICON_CROSS="[X]" ICON_UPLOAD="[UP]" ICON_DOWNLOAD="[DOWN]"
			ICON_COPY="[COPY]" ICON_FOLDER="[DIR]" ICON_LINK="[LINK]" ICON_NEW="[NEW]"
			ICON_WARNING="[WARN]" ICON_TASK="[TASK]" ICON_SUCCESS="[DONE]"
	fi

	if detect_color_support; then
		_EMOJI_COLOR_OK=true
		_EMOJI_LOG_RESET=$'\e[0m'
	else
		_EMOJI_COLOR_OK=false
		_EMOJI_LOG_RESET=
	fi

	export ICON_OK ICON_BAD ICON_INFO ICON_WARN ICON_SAD ICON_DR ICON_REAL \
	       ICON_FILE ICON_BYTE ICON_DUP ICON_SAVE ICON_LOADING ICON_CHECK \
	       ICON_CROSS ICON_UPLOAD ICON_DOWNLOAD ICON_COPY ICON_FOLDER ICON_LINK \
	       ICON_NEW ICON_WARNING ICON_TASK ICON_SUCCESS
}

# one-shot initialisation guard
emoji_init() {
	[[ -n ${_EMOJI_VARS_SET:-} ]] || { set_emoji_vars; _EMOJI_VARS_SET=1; }
}

# ── colourised logging helpers ───────────────────────────────────────────
_emoji_clr() {
	[[ ${_EMOJI_COLOR_OK:-false} == true ]] || return 0
	printf '\e[%sm' "$1"
}

_emoji_log() {
	local col=$1
	local icon=$2
	shift 2
	printf '%b%s%b %s\n' "$(_emoji_clr "$col")" "$icon" "${_EMOJI_LOG_RESET:-}" "$*"
}

log_ok()   { _emoji_log '1;32' "${ICON_OK}"   "$@"; }
log_info() { _emoji_log '1;36' "${ICON_INFO}" "$@"; }
log_warn() { _emoji_log '1;33' "${ICON_WARN}" "$@"; }
log_err()  { _emoji_log '1;31' "${ICON_BAD}"  "$@" >&2; }

# run once when the eclass is sourced
emoji_init

fi  # _EMOJI_ECLASS guard
