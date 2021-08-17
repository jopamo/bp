# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="iscsi client library and utilities"
HOMEPAGE="https://github.com/sahlberg/libiscsi"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/sahlberg/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=054528ed2db9755218ab5bec6ad7a6cf875d11e0
	SRC_URI="https://github.com/sahlberg/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-core/libgcrypt"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-werror
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
