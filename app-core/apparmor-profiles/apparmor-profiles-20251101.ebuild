# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Userspace utils and init scripts for the AppArmor application security system"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=87e360813f1147f9cd24a6aeae41fb5d1f840244
SRC_URI="https://gitlab.com/apparmor/apparmor/-/archive/${SNAPSHOT}/apparmor-${SNAPSHOT}.tar.bz2 -> apparmor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/apparmor-${SNAPSHOT}/profiles"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="~lib-core/libapparmor-${PV}"
DEPEND="${RDEPEND}"
