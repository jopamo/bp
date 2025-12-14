# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Perl script to check for commonly used bash features not defined by POSIX"
HOMEPAGE="https://packages.debian.org/devscripts https://salsa.debian.org/debian/devscripts"
EGIT_REPO_URI="https://salsa.debian.org/debian/devscripts"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-lang/perl"

S="${S}/scripts"
RESTRICT="test"

src_prepare() {
	default

	sed "s@###VERSION###@${PV}@" -i checkbashisms.pl || die
}

src_compile() { :; }

src_install() {
	newbin ${PN}.pl ${PN}
	doman ${PN}.1
}
