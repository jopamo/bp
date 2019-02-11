# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils git-r3 multilib-minimal flag-o-matic

DESCRIPTION="Library to execute a function when a specific event occurs on a file descriptor"
HOMEPAGE="http://libevent.org/"
EGIT_REPO_URI="https://github.com/libevent/libevent"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug libressl +ssl static-libs test +threads"
RESTRICT="test"

DEPEND="
	ssl? (
		!libressl? ( >=lib-dev/openssl-1.0.1h-r2:0[${MULTILIB_USEDEP}] )
		libressl? ( lib-dev/libressl[${MULTILIB_USEDEP}] )
	)
"
RDEPEND="
	${DEPEND}
	!<=lib-dev/9libs-1.0
"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/event2/event-config.h
)

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	# fix out-of-source builds
	mkdir -p test || die

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--disable-samples
		$(use_enable debug debug-mode)
		$(use_enable debug malloc-replacement)
		$(use_enable ssl openssl)
		$(use_enable static-libs static)
		$(use_enable test libevent-regress)
		$(use_enable threads thread-support)
	)

	ECONF_SOURCE="${S}" econf ${myconf[@]}
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}
