# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CLI QuickTime AAC/ALAC encoder for wine"
HOMEPAGE="https://github.com/nu774/qaac"
# Upstream qaac zip does not include iTunes runtime DLLs.
# Keep the bundled CoreAudioToolbox/CoreFoundation from the old iTunes set
# (7.9.7.x) because 7.9.8+ can glitch AAC CBR output.
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="qaac"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip mirror"

src_install() {
	mkdir -p "${ED}"/opt/qaac/
	cp -rp ${S}/* "${ED}"/opt/qaac/
}
