# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="kmod-$(ver_cut 1).y"

inherit meson

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="https://git.kernel.org/?p=utils/kernel/kmod/kmod.git"
SNAPSHOT=6b93232c972b338e972a5d4ccc2651ff78cb359e
SRC_URI="https://github.com/kmod-project/kmod/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="tools zstd xz zlib ssl logging debug-messages build-tests manpages"

RESTRICT="test"

BDEPEND="
	app-dev/gtk-doc-am
	app-dev/pkgconf
"
DEPEND="
	ssl? ( virtual/ssl )
	zlib? ( lib-core/zlib )
	zstd? ( app-compression/zstd )
"

src_configure() {
	local emesonargs=(
		$(meson_feature zstd)
		$(meson_feature xz)
		$(meson_feature zlib)
		$(meson_feature ssl openssl)
		$(meson_use tools)
		$(meson_use logging logging)
		$(meson_use debug-messages)
		$(meson_use build-tests)
		$(meson_use manpages)
		-Ddocs=false
	)

	meson_src_configure "${emesonargs[@]}"
}
