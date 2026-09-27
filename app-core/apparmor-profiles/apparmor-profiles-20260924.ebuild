# Distributed under the terms of the GNU General Public License v2

PROPERTIES+=" source-payload"

DESCRIPTION="AppArmor security profiles"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=e2652b585c4b0d8e8da4f8b5df0ea670ed77530c
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
