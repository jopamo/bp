# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic libtool toolchain-funcs

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"

MY_P="pcre2-${PV/_rc/-RC}"
SRC_URI="mirror://sourceforge/pcre/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 static-libs zlib"

DEPEND="
	bzip2? ( app-compression/bzip2 )
	zlib? ( lib-core/zlib )
	lib-core/readline
"
BDEPEND="
	dev-util/pkgconf
	app-core/findutils
"

src_prepare() {
	default
	elibtoolize
}

src_configure() {
	local myconf=(
		--enable-pcre2-8
		--enable-shared
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		$(use_enable bzip2 pcre2grep-libbz2)
		--disable-pcre2test-libedit
		--enable-pcre2test-libreadline
		$(use_enable zlib pcre2grep-libz)
		--disable-jit
		--disable-pcre2grep-jit
		--enable-pcre2-16
		--enable-pcre2-32
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_compile() {
	emake V=1
}
