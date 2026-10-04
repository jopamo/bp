# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="OPENLDAP_REL_ENG_$(ver_cut 1)_$(ver_cut 2)"



DESCRIPTION="implementation of the Lightweight Directory Access Protocol"
HOMEPAGE="https://www.openldap.org"
SNAPSHOT=f46b74e75a9b79fec76655a9456ce643566d9558
SRC_URI="https://github.com/openldap/openldap/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/openldap-${SNAPSHOT}"

LICENSE="OpenLDAP Public License"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

src_configure() {
	local myconf=(
		$(use_enable ipv6)
		--disable-static
		--disable-debug
		--disable-slapd
		--disable-ndb
		--disable-sql
		--disable-shell
		--disable-bdb
		--disable-hdb
		--enable-dynamic

	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
