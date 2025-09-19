# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Utility to change hard drive performance parameters"
HOMEPAGE="https://sourceforge.net/projects/hdparm/"

SNAPSHOT=bf155d4e65af766dd943fb3d73ea8fae76d73298
SRC_URI="https://salsa.debian.org/debian/hdparm/-/archive/${SNAPSHOT}/hdparm-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/hdparm-${SNAPSHOT}"

LICENSE="BSD GPL-2"
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
