# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="Date conversion for HTTP date formats"
HOMEPAGE="https://metacpan.org/release/HTTP-Date"
SNAPSHOT=8786c34865150134bd591218926bbf0fe102f2bc
SRC_URI="https://github.com/libwww-perl/HTTP-Date/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"
