# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="http://www.radare.org"

SNAPSHOT=feed7220ebc0011d25dd61e59b7cad1f469a5fe5
SRC_URI="https://github.com/radareorg/radare2/archive/${SNAPSHOT}.tar.gz -> radare2-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/radare2-${SNAPSHOT}"

KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE="ssl +system-capstone"

DEPEND="
	ssl? ( virtual/ssl )
	system-capstone? ( lib-live/capstone )
"

filter-flags -Wl,-z,defs

src_configure() {
	local emesonargs=(
		$(meson_use ssl use_sys_openssl)
		$(meson_use system-capstone use_sys_capstone)
		-Duse_sys_magic=true
		-Duse_sys_zlib=true
		-Duse_sys_lz4=true
	)
		meson_src_configure
}
