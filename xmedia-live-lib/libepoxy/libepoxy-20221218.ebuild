# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Epoxy is a library for handling OpenGL function pointer management for you"
HOMEPAGE="https://github.com/anholt/libepoxy"

SNAPSHOT=2df68f811fc1a5f0a6d372ecdb887333ad3f540f
SRC_URI="https://github.com/anholt/libepoxy/archive/${SNAPSHOT}.tar.gz -> libepoxy-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libepoxy-${SNAPSHOT}"

if [[ ${PV} == 9999 ]]; then
	inherit
	EGIT_REPO_URI="https://github.com/anholt/libepoxy"
else
	SRC_URI="https://github.com/anholt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-misc/mesa
	xgui-live-app/util-macros
"