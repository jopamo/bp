# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a library and collection of command line digital forensics tools"
HOMEPAGE="https://www.sleuthkit.org/"
SNAPSHOT=b20199682d17cbd1df5cbb7b65dbf2fa101c6943
SRC_URI="https://github.com/sleuthkit/sleuthkit/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="network-sandbox"

src_prepare() {
	default
	eautoreconf
}
