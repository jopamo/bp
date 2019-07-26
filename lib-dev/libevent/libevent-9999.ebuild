# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3 flag-o-matic

DESCRIPTION="Library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://libevent.org/"
EGIT_REPO_URI="https://github.com/libevent/libevent"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug +ssl static-libs test"
RESTRICT="test"

DEPEND="ssl? ( >=lib-dev/libressl-1.0.1h-r2:0 )"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	# fix out-of-source builds
	mkdir -p test || die

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--disable-samples
		$(use_enable debug debug-mode)
		$(use_enable debug malloc-replacement)
		$(use_enable ssl openssl)
		$(use_enable static-libs static)
		$(use_enable test libevent-regress)
		--enable-thread-support
	)

	ECONF_SOURCE="${S}" econf ${myconf[@]}
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
