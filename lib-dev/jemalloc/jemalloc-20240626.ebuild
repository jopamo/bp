# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Jemalloc is a general-purpose scalable concurrent allocator"
HOMEPAGE="http://jemalloc.net/ https://github.com/jemalloc/jemalloc"

SNAPSHOT=c893fcd169fffca1b9d3156c6637a197765b82d0
SRC_URI="https://github.com/jemalloc/jemalloc/archive/${SNAPSHOT}.tar.gz -> jemalloc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jemalloc-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug lazy-lock static-libs stats xmalloc"

src_prepare() {
	echo "5.3.0-0-g${SNAPSHOT}" > "${S}/VERSION"
	default
	eautoreconf

	touch doc/jemalloc.{html,3}
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		$(use_enable debug)
		$(use_enable lazy-lock)
		$(use_enable stats)
		$(use_enable xmalloc)
		--disable-syscall
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
