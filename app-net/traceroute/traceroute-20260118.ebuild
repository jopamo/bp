# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Utility to trace the route of IP packets"
HOMEPAGE="https://traceroute.sourceforge.net/"
SNAPSHOT=23e47345565fdfb992a94af564d6c3088ccd268e
SRC_URI="https://github.com/jopamo/traceroute/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"
