# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="GNU Autoconf Macro Archive"
HOMEPAGE="https://www.gnu.org/software/autoconf-archive/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

src_install() {
	default
	rm -r "${ED}/usr/share/${PN}" || die
}
