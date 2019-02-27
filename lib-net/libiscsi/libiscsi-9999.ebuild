# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="iscsi client library and utilities"
HOMEPAGE="https://github.com/sahlberg/libiscsi"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/sahlberg/${PN}.git"
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=054528ed2db9755218ab5bec6ad7a6cf875d11e0
	SRC_URI="https://github.com/sahlberg/${PN}/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

SLOT="0"
LICENSE="GPL-2 LGPL-2"
IUSE="static-libs"

RDEPEND="lib-dev/libgcrypt:0="
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-werror
		$(use_enable static-libs static)
	)
	econf ${myconf[@]}
}
