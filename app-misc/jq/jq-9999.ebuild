# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="https://stedolan.github.com/jq/"
EGIT_REPO_URI="https://github.com/stedolan/jq.git"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="oniguruma static-libs"

DEPEND="
	>=sys-devel/bison-3.0
	sys-devel/flex
	oniguruma? ( lib-dev/oniguruma:=[static-libs?] )
"
RDEPEND="
	!static-libs? (
		oniguruma? ( lib-dev/oniguruma[static-libs?] )
	)
"

src_prepare() {
	use oniguruma || { sed -i 's:tests/onigtest::' Makefile.am || die; }
	sed -i '/^dist_doc_DATA/d' Makefile.am || die
	sed -i -r "s:(m4_define\(\[jq_version\],) .+\):\1 \[${PV}\]):" \
		configure.ac || die

	sed -i '/pow10/d' configure.ac || die
	default

	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-docs
		--disable-valgrind
		$(use_enable static-libs static)
		$(use_with oniguruma)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
