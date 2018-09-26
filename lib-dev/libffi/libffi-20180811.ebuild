# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools multilib-minimal

DESCRIPTION="a portable, high level programming interface to various calling conventions"
HOMEPAGE="https://sourceware.org/libffi/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/libffi/libffi.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=980908b47bbde09fab88ee4b2b61d8bc5d4378a7
	SRC_URI="https://github.com/libffi/libffi/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="MIT"
SLOT="0"

IUSE="debug static-libs"

ECONF_SOURCE=${S}

src_prepare() {
	${S}/autogen.sh
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
		$(use_enable debug)
	)
	econf ${myconf[@]}
}
