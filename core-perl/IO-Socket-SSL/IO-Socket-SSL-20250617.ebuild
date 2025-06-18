# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
SNAPSHOT=3f74b384ddff8bcbba6d427a8d6596561fa341aa
SRC_URI="https://github.com/noxxi/p5-io-socket-ssl/archive/${SNAPSHOT}.tar.gz -> p5-io-socket-ssl-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/p5-io-socket-ssl-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"
