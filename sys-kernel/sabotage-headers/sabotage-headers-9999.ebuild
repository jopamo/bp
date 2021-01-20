# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="linux kernel headers (sanitized for use with musl)"
HOMEPAGE="https://github.com/sabotage-linux/kernel-headers"
EGIT_REPO_URI="https://github.com/sabotage-linux/kernel-headers.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_compile() {
	use amd64 && MYARCH=x86
	use arm64 && MYARCH=arm64

	emake ARCH=${MYARCH} prefix="${EPREFIX}"/usr/musl
}

src_install() {
	emake ARCH=${MYARCH} prefix="${EPREFIX}"/usr/musl DESTDIR="${ED}" install
}
