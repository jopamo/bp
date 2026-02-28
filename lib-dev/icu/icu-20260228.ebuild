# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs autotools dot-a

DESCRIPTION="International Components for Unicode"
HOMEPAGE="http://www.icu-project.org/"
SNAPSHOT=fd6268d09513dab1e5a5af46294c9b088df7b1dc
SRC_URI="https://github.com/unicode-org/icu/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}/icu4c/source"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

BDEPEND="app-dev/pkgconf"

src_prepare() {
	use static-libs && lto-guarantee-fat

	default

	local variable

	# Disable renaming as it is stupid thing to do
	sed -i \
		-e "s/#define U_DISABLE_RENAMING 0/#define U_DISABLE_RENAMING 1/" \
		common/unicode/uconfig.h || die

	# Fix linking of icudata
	sed -i \
		-e "s:LDFLAGSICUDT=-nodefaultlibs -nostdlib:LDFLAGSICUDT=:" \
		config/mh-linux || die

	# Append doxygen configuration to configure
	sed -i \
		-e 's:icudefs.mk:icudefs.mk Doxyfile:' \
		configure.ac || die

	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-renaming
		--disable-samples
		--disable-layoutex
		$(use_enable debug)
		$(use_enable static-libs static)
	)

	# icu tries to use clang by default
	tc-export CC CXX

	# make sure we configure with the same shell as we run icu-config
	# with, or ECHO_N, ECHO_T and ECHO_C will be wrongly defined
	export CONFIG_SHELL=${EPREFIX}/usr/bin/sh
	# probably have no /bin/sh in prefix-chain
	[[ -x ${CONFIG_SHELL} ]] || CONFIG_SHELL=${BASH}

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake -j1 VERBOSE="1" check
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
