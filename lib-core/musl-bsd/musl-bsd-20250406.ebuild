# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A standalone library to implement GNU libc's obstack."
HOMEPAGE="https://github.com/void-linux/musl-obstack"

SNAPSHOT=0711585b34f15e20e854c04fb8fe5e682ff473db
SRC_URI="https://github.com/jopamo/musl-bsd/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="!lib-core/glibc"
