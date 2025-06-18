# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="libqtxdg user tools"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=2ea4bb0acbd1d97a7310b27aa2edb43a247cc8ab
SRC_URI="https://github.com/lxqt/qtxdg-tools/archive/${SNAPSHOT}.tar.gz -> qtxdg-tools-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qtxdg-tools-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="LGPL-2.1+"
SLOT="0"

BDEPEND="app-dev/lxqt-build-tools"
