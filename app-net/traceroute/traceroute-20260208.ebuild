# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Utility to trace the route of IP packets"
HOMEPAGE="https://traceroute.sourceforge.net/"
SNAPSHOT=7c8ac15d0069209a3af3a857ef6f7dd895d37907
SRC_URI="https://github.com/jopamo/traceroute/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"
