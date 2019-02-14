# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils autotools

MY_PV=${PV/_p/+nmu}
DESCRIPTION="Library for handling paper characteristics"
HOMEPAGE="http://packages.debian.org/unstable/source/libpaper"
SRC_URI="http://ftp.debian.org/debian/pool/main/libp/libpaper/libpaper_1.1.24+nmu5.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

S="${WORKDIR}/${P}+nmu5"

src_prepare() {
	sed -e "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" -i configure.ac || die
	eautoreconf
}

src_configure() {
	ECONF_SOURCE="${S}"	econf \
		--disable-static
}

src_install_all() {
	find "${ED}" -name "*.la" -delete || die

	dodir /etc
	(paperconf 2>/dev/null || echo a4) > "${ED}"/etc/papersize \
		|| die "papersize config failed"

	if ! has_version app-text/libpaper ; then
		echo
		elog "run e.g. \"paperconfig -p letter\" as root to use letter-pagesizes"
		echo
	fi
}
