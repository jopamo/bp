# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="neutral and extensible mechanism for serializing structured data"
HOMEPAGE="https://developers.google.com/protocol-buffers/"
SRC_URI="https://github.com/protocolbuffers/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	autoreconf -f -i -Wall,no-obsolete
}
