# Distributed under the terms of the GNU General Public License v2

inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"
HOMEPAGE="https://metacpan.org/release/IO-Socket-SSL"
SNAPSHOT=6182228f8fefc4edecd0caa9e60980ff42355a47
SRC_URI="https://github.com/noxxi/p5-io-socket-ssl/archive/${SNAPSHOT}.tar.gz -> p5-io-socket-ssl-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/p5-io-socket-ssl-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	core-perl/Net-SSLeay
"
BDEPEND="${RDEPEND}"
