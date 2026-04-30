# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="AppArmor security profiles"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=7ef79ae3edaa323e33f4bb057f5daee437cf4bac
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
