# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="LTR-only FriBidi API/ABI compatibility shim"
HOMEPAGE="https://gitlab.com/pjo/fakebidi https://fribidi.org/"

SNAPSHOT=2958860d93a60fffb80b2144785a651d5534dc24
SRC_URI="https://gitlab.com/pjo/fakebidi/-/archive/${SNAPSHOT}/fakebidi-${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/fakebidi-${SNAPSHOT}

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"
