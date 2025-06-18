# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="Lightweight Qt Plain-Text Editor"
HOMEPAGE="https://github.com/tsujan/FeatherPad"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/jopamo/featherpad"
	inherit git-r3
else
	SNAPSHOT=7895a75c432909ec49bc9957dcb084c55dde42e7
	SRC_URI="https://github.com/tsujan/FeatherPad/archive/${SNAPSHOT}.tar.gz -> FeatherPad-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/FeatherPad-${SNAPSHOT}"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase
	xgui-lib/qtsvg
	app-tex/hunspell
"

src_install() {
	cmake_src_install
	insinto /etc/xdg/featherpad
	doins "${FILESDIR}"/fp.conf
}
