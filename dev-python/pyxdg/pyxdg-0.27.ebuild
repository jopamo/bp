# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

MY_P=${PN}-rel-${PV}
DESCRIPTION="A Python module to deal with freedesktop.org specifications"
HOMEPAGE="https://freedesktop.org/wiki/Software/pyxdg https://cgit.freedesktop.org/xdg/pyxdg/"
SRC_URI="https://github.com/takluyver/pyxdg/archive/rel-${PV}.tar.gz -> ${MY_P}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
