# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="the network swiss army knife"
HOMEPAGE="http://nc110.sourceforge.net/"
SNAPSHOT=f3a2f612b6efa6b95b548bf8df90a4bc98e78502
SRC_URI="https://github.com/jopamo/netcat/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="netcat"
SLOT="0"
KEYWORDS="amd64 arm64"
