# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="A YAML parser and emitter in C++"
HOMEPAGE="https://github.com/jbeder/yaml-cpp"
SNAPSHOT=bbf8bdb087bb3f3621ca0a5ace06047805f4e9f3
SRC_URI="https://github.com/jbeder/yaml-cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"
