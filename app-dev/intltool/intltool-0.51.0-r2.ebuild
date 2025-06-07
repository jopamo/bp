# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Internationalization Tool Collection"
HOMEPAGE="https://launchpad.net/intltool/"
SRC_URI="https://launchpad.net/intltool-0.51.0/trunk/${PV}/+download/${P}.tar.gz
		http://sources.openelec.tv/mirror/intltool/${P}.tar.gz
		http://ftp.lfs-matrix.net/pub/clfs/conglomeration/intltool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}"/intltool-0.51.0-0.50.2-absolute-paths.patch
	"${FILESDIR}"/intltool-0.51.0-0.51.0-perl-5.22.patch
	"${FILESDIR}"/intltool-0.51.0-0.51.0-perl-5.26.patch
)
