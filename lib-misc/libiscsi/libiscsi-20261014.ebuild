# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="iscsi client library and utilities"
HOMEPAGE="https://github.com/sahlberg/libiscsi"
SNAPSHOT=e702c77cb5ae249d9fbbc523671312881414b635
SRC_URI="https://github.com/sahlberg/libiscsi/archive/${SNAPSHOT}.tar.gz -> libiscsi-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libiscsi-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-crypto/vesk"

src_prepare() {
	qa-policy-configure
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

src_install() {
	default
	qa-policy-install
}
