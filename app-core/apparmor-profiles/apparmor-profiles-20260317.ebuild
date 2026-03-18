# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="AppArmor security profiles"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=75de3a53a40b993b6e6dcdc7964c11876dc49699
SRC_URI="https://gitlab.com/apparmor/apparmor/-/archive/${SNAPSHOT}/apparmor-${SNAPSHOT}.tar.bz2 -> apparmor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/apparmor-${SNAPSHOT}/profiles"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="~app-core/apparmor-${PV}"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		~app-core/apparmor-utils-${PV}
	)
"

src_test() {
	emake USE_SYSTEM=1 check
}
