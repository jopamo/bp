# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="a portable, high level programming interface to various calling conventions"
HOMEPAGE="https://sourceware.org/libffi/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libffi/libffi.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=8fa88373a1d433c675b11200ccd58418e91f81e4
	SRC_URI="https://github.com/libffi/libffi/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"

IUSE="debug static-libs"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_enable debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
