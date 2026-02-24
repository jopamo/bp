# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A YAML parser and emitter in C++"
HOMEPAGE="https://github.com/jbeder/yaml-cpp"
SNAPSHOT=97d150e98b77faefa8f1d08f678a2121cfb4f08d
SRC_URI="https://github.com/jbeder/yaml-cpp/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"
