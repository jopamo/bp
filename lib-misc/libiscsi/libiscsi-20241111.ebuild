# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="iscsi client library and utilities"
HOMEPAGE="https://github.com/sahlberg/libiscsi"

SNAPSHOT=7d1c926bd6168b2b4c5700e6083bd07a7d2b130c
SRC_URI="https://github.com/sahlberg/libiscsi/archive/${SNAPSHOT}.tar.gz -> libiscsi-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libiscsi-${SNAPSHOT}"

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