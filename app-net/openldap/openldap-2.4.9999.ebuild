# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="File transfer program to keep remote files into sync"
HOMEPAGE="https://www.openldap.org"
EGIT_REPO_URI="https://github.com/openldap/openldap.git"
EGIT_BRANCH="OPENLDAP_REL_ENG_$(ver_cut 1)_$(ver_cut 2)"

LICENSE="OpenLDAP Public License"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
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
