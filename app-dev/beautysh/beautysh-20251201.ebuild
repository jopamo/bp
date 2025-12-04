# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1

DESCRIPTION="A Bash beautifier for the masses."
HOMEPAGE="https://github.com/lovesegfault/beautysh"
SNAPSHOT=18907582aeb81b3aa0457183f42e95e16ab68c92
SRC_URI="https://github.com/lovesegfault/beautysh/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="dev-python/colorama"

src_prepare() {
	default
	rm LICENSE
}
