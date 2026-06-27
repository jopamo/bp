# Distributed under the terms of the GNU General Public License v2

inherit perl-module

DESCRIPTION="Date conversion for HTTP date formats"
HOMEPAGE="https://metacpan.org/release/HTTP-Date"
SNAPSHOT=d316cc0df6755961e01cd234a375189a35e305c6
SRC_URI="https://github.com/libwww-perl/HTTP-Date/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"
