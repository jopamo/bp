# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library of routines for joining a machine to Active Directory (without samba)"
HOMEPAGE="https://github.com/freedesktop/realmd-adcli"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/freedesktop/realmd-adcli"
	inherit git-r3
else
SNAPSHOT=ff253ca7ce76faee0b47e0ed36bc8c75c6b69f79
	SRC_URI="https://gitlab.freedesktop.org/realmd/adcli/-/archive/${SNAPSHOT}/adcli-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
	S="${WORKDIR}/realmd-adcli-${SNAPSHOT}"
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-net/openldap
	app-net/cyrus-sasl
"

src_prepare() {
	default
	eautoreconf
}
