# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An eselect module to manage /etc/fonts/conf.d symlinks"
HOMEPAGE="https://www.gentoo.org"
SRC_URI="https://gitweb.gentoo.org/proj/eselect-fontconfig.git/snapshot/eselect-fontconfig-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=app-var/eselect-1.2.3
		 >=fonts/fontconfig-2.4"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${S}"/fontconfig.eselect fontconfig.eselect
}
