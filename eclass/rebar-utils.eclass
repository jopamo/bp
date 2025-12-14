# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rebar-utils.eclass
# @MAINTAINER:
# 1g4 Project <1g4@example.org>
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Auxiliary functions for using dev-util/rebar.

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_REBAR_UTILS_ECLASS} ]]; then
_REBAR_UTILS_ECLASS=1

inherit emoji

# @ECLASS_VARIABLE: REBAR_APP_SRC
# @DESCRIPTION:
# Path to the .app.src file relative to ${S}.
# Defaults to "src/${PN}.app.src".
: "${REBAR_APP_SRC:=src/${PN}.app.src}"

# @FUNCTION: get_erl_libs
# @DESCRIPTION:
# Return the path to the Erlang libraries directory.
get_erl_libs() {
	echo "/usr/$(get_libdir)/erlang/lib"
}

# @FUNCTION: _rebar_find_dep
# @INTERNAL
# @USAGE: <pkg_name>
# @DESCRIPTION:
# Finds a single matching Erlang dep in libdir, returns error if ambiguous or missing.
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

# @FUNCTION: rebar_disable_coverage
# @USAGE: [rebar_config]
# @DESCRIPTION:
# Disable coverage analysis in the given rebar config file (default: rebar.config).
rebar_disable_coverage() {
	local rebar_config="${1:-rebar.config}"
	sed -e 's/{cover_enabled, true}/{cover_enabled, false}/' \
		-i "${rebar_config}" \
		|| die "failed to disable coverage in ${rebar_config}"
}

# @FUNCTION: rebar_fix_include_path
# @USAGE: <project_name> [rebar_config]
# @DESCRIPTION:
# Fix include paths in rebar config to point to system installed headers.
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

# @FUNCTION: rebar_remove_deps
# @USAGE: [rebar_config]
# @DESCRIPTION:
# Remove dependencies from rebar config to avoid rebar trying to download them.
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

# @FUNCTION: rebar_set_vsn
# @USAGE: [version]
# @DESCRIPTION:
# Set the version in the app.src file. Defaults to PV without revision.
rebar_set_vsn() {
	local version="${1:-${PV%_*}}"
	sed -e "s/vsn, git/vsn, \"${version}\"/" \
		-i "${S}/${REBAR_APP_SRC}" \
		|| die "failed to set version in src/${PN}.app.src"
}

fi
