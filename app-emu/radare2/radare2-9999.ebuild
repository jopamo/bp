# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="http://www.radare.org"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/radareorg/radare2"
	inherit git-r3
else
	SNAPSHOT=262684f8e4cbcee37dce79960fe167beefbe04c4
	SRC_URI="https://github.com/radareorg/radare2/archive/${SNAPSHOT}.tar.gz -> radare2-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/radare2-${SNAPSHOT}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ssl +system-capstone"

RESTRICT="test network-sandbox"

DEPEND="
	app-compression/libzip
	ssl? ( virtual/ssl )
	system-capstone? ( app-emu/capstone )
"

src_configure() {
	filter-flags -Wl,-z,defs -flto*

	local emesonargs=(
		$(meson_use ssl use_sys_openssl)
		$(meson_use system-capstone use_sys_capstone)
		-Duse_sys_magic=true
		-Duse_sys_zlib=true
		--wrap-mode=default
		-Duse_sys_lz4=true
	)
		meson_src_configure
}
