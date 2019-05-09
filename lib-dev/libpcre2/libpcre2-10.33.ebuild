# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic libtool toolchain-funcs

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
MY_P="pcre2-${PV/_rc/-RC}"
if [[ ${PV} != *_rc* ]] ; then
	# Only the final releases are available here.
	SRC_URI="mirror://sourceforge/pcre/${MY_P}.tar.bz2
		ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/${MY_P}.tar.bz2"
else
	SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/Testing/${MY_P}.tar.bz2"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 +jit libedit pcre16 pcre32 +readline +recursion-limit static-libs unicode zlib"
REQUIRED_USE="?? ( libedit readline )"

RDEPEND="bzip2? ( app-compression/lbzip2 )
	zlib? ( lib-sys/zlib )
	libedit? ( lib-dev/libedit )
	readline? ( lib-sys/readline:0= )"
DEPEND="${RDEPEND}
	dev-util/pkgconf
	>=sys-app/findutils-4.4.0"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	elibtoolize
}

src_configure() {
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-pcre2-8
		--enable-shared
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		--with-match-limit-depth=$(usex recursion-limit 8192 MATCH_LIMIT)
		$(use_enable bzip2 pcre2grep-libbz2)
		$(use_enable libedit pcre2test-libedit)
		$(use_enable readline pcre2test-libreadline)
		$(use_enable zlib pcre2grep-libz)
		$(use_enable jit)
		$(use_enable jit pcre2grep-jit)
		$(use_enable pcre16 pcre2-16)
		$(use_enable pcre32 pcre2-32)
		$(use_enable static-libs static)
		$(use_enable unicode)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_compile() {
	emake V=1
}
