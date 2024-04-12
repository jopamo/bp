# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

DESCRIPTION="A Bash beautifier for the masses."
HOMEPAGE="https://github.com/lovesegfault/beautysh"

SNAPSHOT=9845efc3ea3e86cc0d41465d720a47f521b2799c
SRC_URI="https://github.com/lovesegfault/beautysh/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	rm LICENSE
}
