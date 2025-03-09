# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An eselect module to manage /etc/fonts/conf.d symlinks"
HOMEPAGE="https://www.gentoo.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-var/eselect
		 fonts/fontconfig
"

src_unpack() {
	default
	mkdir "${S}"
}

src_install() {
	insinto /usr/share/eselect/modules
	doins "${FILESDIR}"/fontconfig.eselect
}
