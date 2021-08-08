# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="linux kernel headers (sanitized for use with musl)"
HOMEPAGE="https://github.com/sabotage-linux/kernel-headers"
EGIT_REPO_URI="https://github.com/sabotage-linux/kernel-headers.git"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/sabotage-linux/kernel-headers.git"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=67221a865a5196bca7de7b2c23f6671b6b8633bb
	SRC_URI="https://github.com/sabotage-linux/kernel-headers/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/kernel-headers-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

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
