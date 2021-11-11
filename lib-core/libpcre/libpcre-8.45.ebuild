# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit libtool flag-o-matic toolchain-funcs

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"

MY_P="pcre-${PV/_rc/-RC}"
SRC_URI="mirror://sourceforge/pcre/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="+cxx +jit +recursion-limit static-libs"

DEPEND="
	lib-core/libedit
	app-compression/bzip2
	lib-core/zlib
"
BDEPEND="app-dev/pkgconf"

src_prepare() {
	default
	sed -i -e "s:-lpcre ::" libpcrecpp.pc.in || die
	elibtoolize
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--with-match-limit-recursion=$(usex recursion-limit 8192 MATCH_LIMIT)
		--enable-unicode-properties
		--enable-pcre16
		--enable-pcre32
		--enable-pcregrep-libz
		--enable-pcregrep-libbz2
		--enable-pcretest-libedit
		--enable-shared
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable cxx cpp)
		$(use_enable jit) $(use_enable jit pcregrep-jit)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_compile() {
	emake V=1
}
