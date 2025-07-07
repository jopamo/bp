# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rebar-utils.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Auxiliary functions for using dev-util/rebar.

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_REBAR_UTILS_ECLASS} ]]; then
_REBAR_UTILS_ECLASS=1

inherit emoji

: "${REBAR_APP_SRC:=src/${PN}.app.src}"

get_erl_libs() {
	echo "/usr/$(get_libdir)/erlang/lib"
}

_rebar_find_dep() {
	local pn="${1}"
	local p
	local result

	pushd "${EPREFIX}$(get_erl_libs)" >/dev/null || return 1
	for p in ${pn} ${pn}-*; do
		if [[ -d ${p} ]]; then
			[[ ${result} ]] && return 2
			result="${p}"
		fi
	done
	popd >/dev/null || die

	[[ ${result} ]] || return 1
	echo "${result}"
}

rebar_disable_coverage() {
	local rebar_config="${1:-rebar.config}"
	sed -e 's/{cover_enabled, true}/{cover_enabled, false}/' \
		-i "${rebar_config}" \
		|| die "failed to disable coverage in ${rebar_config}"
}

rebar_fix_include_path() {
	local pn="${1}"
	local rebar_config="${2:-rebar.config}"
	local erl_libs="${EPREFIX}$(get_erl_libs)"
	local p

	p="$(_rebar_find_dep "${pn}")" || die "failed to unambiguously resolve dependency of '${pn}'"

	gawk -i inplace \
		-v erl_libs="${erl_libs}" -v pn="${pn}" -v p="${p}" '
/^{[[:space:]]*erl_opts[[:space:]]*,/, /}[[:space:]]*\.$/ {
	pattern = "\"(./)?deps/" pn "/include\"";
	if (match($0, "{i,[[:space:]]*" pattern "[[:space:]]*}")) {
		sub(pattern, "\"" erl_libs "/" p "/include\"");
	}
	print $0;
	next;
}
1
' "${rebar_config}" || die "failed to fix include paths in ${rebar_config} for '${pn}'"
}

rebar_remove_deps() {
	local rebar_config="${1:-rebar.config}"

	mkdir -p "${S}/deps" && :>"${S}/deps/.got" && :>"${S}/deps/.built" || die
	gawk -i inplace '
/^{[[:space:]]*deps[[:space:]]*,/, /}[[:space:]]*\.$/ {
	if ($0 ~ /}[[:space:]]*\.$/) {
		print "{deps, []}.";
	}
	next;
}
1
' "${rebar_config}" || die "failed to remove deps from ${rebar_config}"
}

rebar_set_vsn() {
	local version="${1:-${PV%_*}}"
	sed -e "s/vsn, git/vsn, \"${version}\"/" \
		-i "${S}/${REBAR_APP_SRC}" \
		|| die "failed to set version in src/${PN}.app.src"
}

fi
