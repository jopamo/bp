# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib-minimal autotools

DESCRIPTION="Library for Neighbor Discovery Protocol"
HOMEPAGE="http://libndp.org"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/jpirko/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=e8b90ce2d6ebf846cb0c9a3255d4deacf075f9c4
	SRC_URI="https://github.com/jpirko/${PN}/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2"
SLOT="0"

src_prepare() {
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
		--disable-static
		--enable-logging
	)
	ECONF_SOURCE=${S} econf ${myconf[@]}
}
