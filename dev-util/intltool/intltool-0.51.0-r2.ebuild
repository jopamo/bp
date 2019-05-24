# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Internationalization Tool Collection"
HOMEPAGE="https://launchpad.net/intltool/"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=(
	# Fix handling absolute paths in single file key output, bug #470040
	# https://bugs.launchpad.net/intltool/+bug/1168941
	"${FILESDIR}"/${PN}-0.50.2-absolute-paths.patch
	"${FILESDIR}"/${PN}-0.51.0-perl-5.22.patch
	"${FILESDIR}"/${PN}-0.51.0-perl-5.26.patch
)
