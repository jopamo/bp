# Distributed under the terms of the GNU General Public License v2

inherit meson qa-policy

DESCRIPTION="C library and command-line tools for JSON Object Signing and Encryption"
HOMEPAGE="https://github.com/latchset/jose"
SRC_URI="https://github.com/latchset/jose/releases/download/v${PV}/${P}.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-core/jansson
	lib-core/zlib
	virtual/ssl
"
DEPEND="${RDEPEND}"

src_configure() {
	qa-policy-configure
	local emesonargs=( -Ddocs=disabled )
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
