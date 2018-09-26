# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Lua eselect module"
HOMEPAGE="https://www.gentoo.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

DEPEND="sys-app/eselect"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/eselect/modules/
	newins "${FILESDIR}"/lua.eselect-${PV} lua.eselect
}
