# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit multilib-minimal

DESCRIPTION="Implementation for atomic memory update operations"
HOMEPAGE="https://github.com/ivmai/libatomic_ops/"
SRC_URI="https://github.com/ivmai/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT boehm-gc GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

multilib_src_configure() {
	ECONF_SOURCE=${S} econf
}
