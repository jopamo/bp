# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools toolchain-funcs multilib-minimal

DESCRIPTION="Jemalloc is a general-purpose scalable concurrent allocator"
HOMEPAGE="http://jemalloc.net/ https://github.com/jemalloc/jemalloc"
SRC_URI="https://github.com/jemalloc/jemalloc/releases/download/${PV}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0/2"
KEYWORDS="amd64 arm64 x86"
IUSE="debug hardened +hugepages lazy-lock static-libs stats xmalloc"

MULTILIB_WRAPPED_HEADERS=( /usr/include/jemalloc/jemalloc.h )

QA_CONFIGURE_OPTIONS="--enable-static --disable-static --enable-shared --disable-shared"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	local myconf=()

	if use hardened ; then
		myconf+=( --disable-syscall )
	fi

	myconf+=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
		$(use_enable lazy-lock)
		$(use_enable stats)
		$(use_enable xmalloc)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	touch doc/{jemalloc.3,jemalloc.html}
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	if [[ ${CHOST} == *-darwin* ]] ; then
		# fixup install_name, #437362
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libjemalloc.2.dylib \
			"${ED}"/usr/$(get_libdir)/libjemalloc.2.dylib || die
	fi
	use static-libs || find "${ED}" -name '*.a' -delete
}
