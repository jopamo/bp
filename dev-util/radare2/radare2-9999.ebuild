# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="unix-like reverse engineering framework and commandline tools"
HOMEPAGE="http://www.radare.org"

EGIT_REPO_URI="https://github.com/radare/radare2"
KEYWORDS="amd64 arm64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="ssl libressl +system-capstone"

RDEPEND="
	ssl? (
		!libressl? ( lib-dev/openssl:0= )
		libressl? ( lib-dev/libressl:0= )
	)
	system-capstone? ( lib-dev/capstone:0= )
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
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
