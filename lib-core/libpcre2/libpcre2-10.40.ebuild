# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic libtool

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SRC_URI="https://github.com/PhilipHazel/pcre2/releases/download/pcre2-${PV}/pcre2-${PV}.tar.bz2"
S="${WORKDIR}/pcre2-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 static-libs zlib"

DEPEND="
	lib-core/readline
	bzip2? ( app-compression/bzip2 )
	zlib? ( lib-core/zlib )
"
BDEPEND="
	app-core/findutils
	app-dev/pkgconf
"

src_prepare() {
	default
	elibtoolize
}

src_configure() {
	local myconf=(
		--disable-jit
		--disable-pcre2grep-jit
		--disable-pcre2test-libedit
		--enable-pcre2-16
		--enable-pcre2-32
		--enable-pcre2-8
		--enable-pcre2test-libreadline
		--enable-shared
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		$(use_enable bzip2 pcre2grep-libbz2)
		$(use_enable static-libs static)
		$(use_enable zlib pcre2grep-libz)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_compile() {
	emake V=1
}
