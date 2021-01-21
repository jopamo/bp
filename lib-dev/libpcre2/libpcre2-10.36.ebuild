# Distributed under the terms of the GNU General Public License v2

EAPI=7

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

IUSE="bzip2 static-libs zlib"

DEPEND="
	bzip2? ( app-compression/lbzip2 )
	zlib? ( lib-sys/zlib )
	lib-sys/readline
"

BDEPEND="
	dev-util/pkgconf
	>=sys-app/findutils-4.4.0"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
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
