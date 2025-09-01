# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
SNAPSHOT=1074e9ebe099929e7a376d5387610b6a34338ba6
SLJIT_SNAPSHOT=7779da89dc7e00a540712fcb859b762d4eca2a26

SRC_URI="https://github.com/PCRE2Project/pcre2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
SRC_URI="https://github.com/PCRE2Project/pcre2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
		https://github.com/zherczeg/sljit/archive/${SLJIT_SNAPSHOT}.tar.gz"
S="${WORKDIR}/pcre2-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 +static-libs zlib"

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
	append-flags -ffat-lto-objects

	rm -rf "${WORKDIR}/pcre2-${SNAPSHOT}/deps/sljit"
	mv "${WORKDIR}/sljit-${SLJIT_SNAPSHOT}" "${WORKDIR}/pcre2-${SNAPSHOT}/deps/sljit"

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-jit
		--enable-pcre2grep-jit
		--enable-pcre2test-libedit
		--enable-pcre2-16
		--enable-pcre2-32
		--disable-pcre2test-libreadline
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
