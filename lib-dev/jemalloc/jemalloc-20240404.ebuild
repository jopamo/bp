# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Jemalloc is a general-purpose scalable concurrent allocator"
HOMEPAGE="http://jemalloc.net/ https://github.com/jemalloc/jemalloc"

SNAPSHOT=5081c16bb49a0c9d1dde3cbd7dfb2e97c2827ea4
SRC_URI="https://github.com/${PN}/jemalloc/archive/${SNAPSHOT}.tar.gz -> jemalloc-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jemalloc-${SNAPSHOT}"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/${PN}/jemalloc"
	inherit
else
	SNAPSHOT=5081c16bb49a0c9d1dde3cbd7dfb2e97c2827ea4
	SRC_URI="https://github.com/${PN}/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug lazy-lock static-libs stats xmalloc"

src_prepare() {
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
