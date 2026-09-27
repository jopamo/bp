# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="iscsi client library and utilities"
HOMEPAGE="https://github.com/sahlberg/libiscsi"
SNAPSHOT=2f568c66202cdfb8af7c8817708db8e19a9164f8
SRC_URI="https://github.com/sahlberg/libiscsi/archive/${SNAPSHOT}.tar.gz -> libiscsi-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libiscsi-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="lib-core/libgcrypt"

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
