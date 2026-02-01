# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Self-contained, header-only C JSON tokenizer"
HOMEPAGE="https://github.com/jopamo/jstok"
SNAPSHOT=d533361044e7e70220620f70d6ca69c477cc339f
SRC_URI="https://github.com/jopamo/jstok/archive/${SNAPSHOT}.tar.gz -> jstok-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jstok-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
