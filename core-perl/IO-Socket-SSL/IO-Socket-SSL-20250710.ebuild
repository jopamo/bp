# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
SNAPSHOT=a9f98837d37e744235cb9045a015486763246d9f
SRC_URI="https://github.com/noxxi/p5-io-socket-ssl/archive/${SNAPSHOT}.tar.gz -> p5-io-socket-ssl-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/p5-io-socket-ssl-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"
