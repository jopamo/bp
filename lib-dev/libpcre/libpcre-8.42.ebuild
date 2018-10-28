# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils multilib libtool flag-o-matic toolchain-funcs multilib-minimal

DESCRIPTION="Perl-compatible regular expression library"
HOMEPAGE="http://www.pcre.org/"
MY_P="pcre-${PV/_rc/-RC}"
if [[ ${PV} != *_rc* ]] ; then
	# Only the final releases are available here.
	SRC_URI="mirror://sourceforge/pcre/${MY_P}.tar.bz2
		ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/${MY_P}.tar.bz2"
else
	SRC_URI="ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/Testing/${MY_P}.tar.bz2"
fi

LICENSE="BSD"
SLOT="3"
KEYWORDS="amd64 arm64 x86"

IUSE="+cxx +jit +recursion-limit static-libs"

RDEPEND="
	app-compression/lbzip2
	lib-sys/zlib
	lib-sys/readline
"
DEPEND="
	${RDEPEND}
	dev-util/pkgconfig
"

S="${WORKDIR}/${MY_P}"

MULTILIB_CHOST_TOOLS=(
	/usr/bin/pcre-config
)

src_prepare() {
	default
	sed -i -e "s:-lpcre ::" libpcrecpp.pc.in || die
	elibtoolize
}

multilib_src_configure() {
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--with-match-limit-recursion=$(usex recursion-limit 8192 MATCH_LIMIT)
		--enable-unicode-properties
		--enable-pcre16
		--enable-pcre32
		--enable-pcregrep-libz
		--enable-pcregrep-libbz2
		--enable-pcretest-libreadline
		--enable-shared
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable cxx cpp)
		$(use_enable jit) $(use_enable jit pcregrep-jit)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_compile() {
	emake V=1
}

multilib_src_install() {
	emake DESTDIR="${ED}" install
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}
