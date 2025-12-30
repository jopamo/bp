# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic go-module git-r3

DESCRIPTION="Convert HTML to Markdown"
HOMEPAGE="https://github.com/JohannesKaufmann/html-to-markdown"
EGIT_REPO_URI="https://github.com/JohannesKaufmann/html-to-markdown"

LICENSE="MIT Apache-2.0 BSD BSD-2 MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build -trimpath -o html2markdown ./cli/html2markdown
}

src_install() {
	dobin html2markdown
}
