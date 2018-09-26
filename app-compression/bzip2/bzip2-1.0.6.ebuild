# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal meson

DESCRIPTION="shared and static bzip2 libraries"
HOMEPAGE="http://www.bzip.org/"
SRC_URI="https://ftp.osuosl.org/pub/lfs/lfs-packages/8.1/${P}.tar.gz"
LICENSE="BZIP2"
SLOT="0/1"
KEYWORDS="amd64 arm64 x86"

src_prepare() {
	cp ${FILESDIR}/meson.build ${S}/
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local emesonargs=(
		-Dportage-rootpath="${ROOTPATH}"
		-Deprefix-default="${EPREFIX}"
		)
		meson_src_configure
}
