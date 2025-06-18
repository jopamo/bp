# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Command-line utility and library for lossy compression of PNG images"
HOMEPAGE="https://pngquant.org/ https://github.com/kornelski/pngquant"
EGIT_REPO_URI="https://github.com/kornelski/${PN}.git"

LICENSE="GPL-3 HPND rwpng"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin "target/release/${PN}"
	doman ${PN}.1
}
