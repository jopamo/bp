# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="dev"

inherit meson flag-o-matic dot-a

DESCRIPTION="Extremely Fast Compression algorithm"
HOMEPAGE="https://github.com/lz4/lz4"
SNAPSHOT=130f457aea830ab80e2e7b438408384fe8eefe07
SRC_URI="https://github.com/lz4/lz4/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/lz4-${SNAPSHOT}/build/meson

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_configure() {
	use static-libs && lto-guarantee-fat

	local emesonargs=(
		-Dtests=$(usex test true false)
		-Ddefault_library=$(usex static-libs both shared)
		-Dprograms=true
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	use static-libs && strip-lto-bytecode
}
