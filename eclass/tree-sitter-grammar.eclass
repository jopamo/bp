# Distributed under the terms of the GNU General Public License v2

# @ECLASS: tree-sitter-grammar.eclass
# @SUPPORTED_EAPIS: 8
# @BLURB: Simplified eclass for building Tree-sitter grammars (Linux only)

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ -z ${_TREE_SITTER_GRAMMAR_ECLASS} ]]; then
_TREE_SITTER_GRAMMAR_ECLASS=1

inherit emoji edo toolchain-funcs

SRC_URI="https://github.com/tree-sitter/${PN}/archive/${TS_PV:-v${PV}}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${TS_PV:-${PV}}"

BDEPEND+=" test? ( dev-util/tree-sitter-cli )"
IUSE+=" test"
RESTRICT+=" !test? ( test )"

# TS_PV allows override for odd tag names
# TS_BINDINGS is a list of language bindings to build, only "python" supported

for _BINDING in "${TS_BINDINGS[@]}"; do
	case ${_BINDING} in
		python)
			DISTUTILS_EXT=1
			DISTUTILS_OPTIONAL=1
			DISTUTILS_USE_PEP517=setuptools
			PYTHON_COMPAT=( python3_{10..12} )
			inherit distutils-r1
			IUSE+=" python"
			REQUIRED_USE+=" python? ( ${PYTHON_REQUIRED_USE} )"
			DEPEND+=" python? ( ${PYTHON_DEPS} )"
			RDEPEND+=" python? ( ${PYTHON_DEPS} >=dev-py/tree-sitter-0.21.0[${PYTHON_USEDEP}] )"
			BDEPEND+=" python? ( ${PYTHON_DEPS} ${DISTUTILS_DEPS} dev-python/wheel[${PYTHON_USEDEP}] )"
			;;
		*)
			log_err "Unknown binding: ${_BINDING}"
			die "Unknown binding: ${_BINDING}"
			;;
	esac
done
unset _BINDING

# returns grammar ABI version from parser.c
_get_tsg_abi_ver() {
	local ver
	ver=$(sed -n 's/#define LANGUAGE_VERSION //p' "${S}/src/parser.c")
	[[ -n $ver ]] || { log_err "Unable to extract ABI version"; die "Unable to extract ABI version"; }
	echo "$ver"
}

tree-sitter-grammar_src_prepare() {
	log_info "Preparing source"
	default

	for binding in "${TS_BINDINGS[@]}"; do
		case ${binding} in
			python)
				use python && distutils-r1_src_prepare
				;;
		esac
	done
}

tree-sitter-grammar_src_configure() {
	log_info "Configuring build"
	for binding in "${TS_BINDINGS[@]}"; do
		case ${binding} in
			python)
				use python && distutils-r1_src_configure
				;;
		esac
	done
}

# builds grammar as shared library (legacy method)
_tree-sitter-grammar_legacy_compile() {
	cd "${S}/src" || { log_err "Failed to cd to src"; die; }
	tc-export CC CXX

	CFLAGS="${CFLAGS} -fPIC -I. -Itree_sitter"
	CXXFLAGS="${CXXFLAGS} -fPIC -I. -Itree_sitter"

	local objects=( parser.o )
	[[ -f scanner.c || -f scanner.cc ]] && objects+=( scanner.o )
	emake "${objects[@]}"

	local link="$(tc-getCC) ${CFLAGS}"
	[[ -f scanner.cc ]] && link="$(tc-getCXX) ${CXXFLAGS}"

	local soname=lib${PN}$(get_libname $(_get_tsg_abi_ver))
	local soname_args="-Wl,--soname=${soname}"

	edo ${link} ${LDFLAGS} -shared *.o "${soname_args}" -o "${WORKDIR}/${soname}"
}

tree-sitter-grammar_src_compile() {
	log_info "Compiling grammar"
	if [[ -f "${S}/pyproject.toml" ]]; then
		sed -e "/SONAME_MINOR :=/s/:=.*$/:= $(_get_tsg_abi_ver)/" -i "${S}/Makefile" || die
		emake STRIP="" PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/lib"
	else
		_tree-sitter-grammar_legacy_compile
	fi

	for binding in "${TS_BINDINGS[@]}"; do
		case ${binding} in
			python)
				use python && distutils-r1_src_compile
				;;
		esac
	done
}

tree-sitter-grammar_src_test() {
	log_info "Running test suite"
	tree-sitter test || { log_err "Test suite failed"; die; }
}

tree-sitter-grammar_src_install() {
	log_info "Installing"
	if [[ -f "${S}/pyproject.toml" ]]; then
		emake PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/lib" DESTDIR="${D}/" install
		find "${D}" -name '*.a' -delete || { log_err "Failed to remove static libs"; die; }
	else
		local soname=lib${PN}$(get_libname $(_get_tsg_abi_ver))
		dolib.so "${WORKDIR}/${soname}"
		dosym "${soname}" /usr/lib/lib${PN}$(get_libname)
	fi

	for binding in "${TS_BINDINGS[@]}"; do
		case ${binding} in
			python)
				use python && distutils-r1_src_install
				;;
		esac
	done
}

fi

EXPORT_FUNCTIONS src_prepare src_configure src_compile src_test src_install
