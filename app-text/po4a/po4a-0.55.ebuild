# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit perl-module

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://po4a.alioth.debian.org"
SRC_URI="https://github.com/mquinson/po4a/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=sys-devel/gettext-0.13
	app-text/openjade
	lib-dev/libxslt
"
DEPEND="${RDEPEND}
	dev-perl/SGMLSpm
	dev-perl/Unicode-LineBreak
	dev-perl/YAML-Tiny
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd"
