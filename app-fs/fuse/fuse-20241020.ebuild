# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="An interface for filesystems implemented in userspace"
HOMEPAGE="https://github.com/libfuse/libfuse"

SNAPSHOT=3bf5ec7aff683d67f602db3490874fe108378aa0
SRC_URI="https://github.com/libfuse/libfuse/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/lib${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="3"
KEYWORDS="amd64 arm64"

src_install() {
	filter-flags -flto*

	meson_src_install
	rm -rf "${ED}"/etc/init.d
}
