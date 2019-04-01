# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 flag-o-matic meson

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="http://www.radare.org"

EGIT_REPO_URI="https://github.com/radare/radare2"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE="ssl +system-capstone"

DEPEND="
	ssl? ( lib-dev/openssl:0= )
	system-capstone? ( lib-dev/capstone:0= )
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

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
