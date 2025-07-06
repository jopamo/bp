# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Utility to change hard drive performance parameters"
HOMEPAGE="https://sourceforge.net/projects/hdparm/"
SRC_URI="mirror://sourceforge/hdparm/${P}.tar.gz"

LICENSE="BSD GPL-2" # GPL-2 only
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

src_prepare() {
	default
	use static && append-ldflags -static
}

src_configure() {
	append-lfs-flags
}

src_compile() {
	emake STRIP="true" CC="$(tc-getCC)"
}

src_install() {
	dobin hdparm contrib/idectl
}
