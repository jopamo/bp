# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"

SNAPSHOT=35eafc9d2034ae19f0a807cb3005affea7bb2300
SLJIT_SNAPSHOT=eb8ef1e81902e14ae3bfdfcb423b932963b8cc10

SRC_URI="https://github.com/PCRE2Project/pcre2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
		https://github.com/zherczeg/sljit/archive/${SLJIT_SNAPSHOT}.tar.gz"
S="${WORKDIR}/pcre2-${SNAPSHOT}"

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
	rm -rf "${WORKDIR}/pcre2-${SNAPSHOT}/deps/sljit"
	mv "${WORKDIR}/sljit-${SLJIT_SNAPSHOT}" "${WORKDIR}/pcre2-${SNAPSHOT}/deps/sljit"

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-jit
		--enable-pcre2grep-jit
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
