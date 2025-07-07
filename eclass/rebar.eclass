# Distributed under the terms of the GNU General Public License v2

# @ECLASS: rebar.eclass
# @SUPPORTED_EAPIS: 7 8
# @PROVIDES: rebar-utils
# @BLURB: Build Erlang/OTP projects using dev-util/rebar.

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_REBAR_ECLASS} ]]; then
_REBAR_ECLASS=1

inherit rebar-utils

RDEPEND="app-lang/erlang:="
DEPEND="${RDEPEND}"
BDEPEND="
	app-dev/rebar
	app-core/gawk
"

# Finds a single matching Erlang dep in libdir, returns error if ambiguous or missing
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

erebar() {
	(( $# > 0 )) || die "erebar: at least one target is required"

	local -x ERL_LIBS="${EPREFIX}$(get_erl_libs)"
	[[ ${1} == eunit ]] && local -x ERL_LIBS="."

	rebar -v skip_deps=true "$@" || die -n "rebar $@ failed"
}

rebar_src_prepare() {
	default
	rebar_set_vsn
	if [[ -f rebar.config ]]; then
		rebar_disable_coverage
		rebar_remove_deps
	fi
}

rebar_src_configure() {
	local -x ERL_LIBS="${EPREFIX}$(get_erl_libs)"
	default
}

rebar_src_compile() {
	erebar compile
}

rebar_src_test() {
	erebar eunit
}

rebar_src_install() {
	local bin
	local dest="$(get_erl_libs)/${P}"

	insinto "${dest}"
	doins -r ebin
	[[ -d include ]] && doins -r include
	[[ -d bin ]] && for bin in bin/*; do dobin "$bin"; done

	if [[ -d priv ]]; then
		cp -pR priv "${ED}${dest}/" || die "failed to install priv/"
	fi

	cleanup_install
	dedup_symlink "${ED}"
}

fi

EXPORT_FUNCTIONS src_prepare src_compile src_test src_install
