# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="base functions required by all BP systems"
HOMEPAGE="https://github.com/bp/bp-functions"
SNAPSHOT=f181af25432c9685d05a112d2357bef14e77c733
SRC_URI="https://github.com/bp/bp-functions/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	meson_src_install
	insopts -m 0644
	insinto /usr/lib/bp/
	doins functions.sh
}
