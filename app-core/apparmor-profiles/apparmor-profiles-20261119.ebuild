# Distributed under the terms of the GNU General Public License v2

PROPERTIES+=" source-payload"

DESCRIPTION="AppArmor security profiles"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=8f7e3c0555dfe366f9d04b7b4b8035ae18d957a4
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
		~app-core/apparmor-${PV}
		~app-core/apparmor-utils-${PV}
	)
"

src_prepare() {
	pushd .. >/dev/null || die
	eapply "${FILESDIR}/profiles-test-use-configured-parser.patch"
	popd >/dev/null || die
	default
}

src_test() {
	emake USE_SYSTEM=1 check
}
