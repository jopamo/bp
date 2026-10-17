# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic qa-policy

DESCRIPTION="Extremely Fast Compression algorithm"
HOMEPAGE="https://github.com/lz4/lz4"
SNAPSHOT=48bfbfe351c5d6ea87d4af5557705e87755844e0
SRC_URI="https://github.com/lz4/lz4/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lz4-${SNAPSHOT}/build/meson"

LICENSE="BSD-2 GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

src_configure() {
	qa-policy-configure
	local emesonargs=(
		-Dtests=$(usex test true false)
		-Ddefault_library=$(usex static-libs both shared)
		-Dprograms=true
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}
