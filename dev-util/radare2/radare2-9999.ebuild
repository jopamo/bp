# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 flag-o-matic

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="http://www.radare.org"

EGIT_REPO_URI="https://github.com/radare/radare2"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE="ssl +system-capstone"

RDEPEND="
	ssl? ( lib-dev/openssl:0= )
	system-capstone? ( lib-dev/capstone:0= )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_with ssl openssl)
		$(use_with system-capstone syscapstone)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm -rf ${ED}/usr/lib64/radare2/
}
