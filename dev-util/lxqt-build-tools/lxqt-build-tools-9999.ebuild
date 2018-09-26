# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="LXQt Build tools"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
else
	SRC_URI="http://downloads.lxqt.org/${PN}/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

KEYWORDS="amd64 arm64 x86"

LICENSE="BSD"
SLOT="0"

DEPEND="gui-lib/qtcore:5"

src_configure() {
	cmake-utils_src_configure
}
