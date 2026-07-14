# Distributed under the terms of the GNU General Public License v2

inherit perl-module

DESCRIPTION="Date conversion for HTTP date formats"
HOMEPAGE="https://metacpan.org/release/HTTP-Date"
SNAPSHOT=e603a348b21b54c8a225de375a80da0b2c30e5ed
SRC_URI="https://github.com/libwww-perl/HTTP-Date/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"
