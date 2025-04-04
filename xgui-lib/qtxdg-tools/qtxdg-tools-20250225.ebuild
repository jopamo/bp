# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="libqtxdg user tools"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=0ae6835400db5648d6d2fc95645bcee66cf2aec9
SRC_URI="https://github.com/lxqt/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"
