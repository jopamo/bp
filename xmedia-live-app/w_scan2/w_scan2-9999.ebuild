# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Scan for DVB-C/DVB-T/DVB-S channels (w_scan fork)"
HOMEPAGE="https://github.com/stefantalpalaru/w_scan2"
EGIT_REPO_URI="https://github.com/stefantalpalaru/w_scan2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}

