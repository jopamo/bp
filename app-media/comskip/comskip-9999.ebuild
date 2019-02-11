# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools

DESCRIPTION="Complete solution to record, convert and stream audio and video. Includes libavcodec"
HOMEPAGE="http://ffmpeg.org/"
EGIT_REPO_URI="https://github.com/erikkaashoek/Comskip.git"

SLOT="0"
LICENSE="GPL-3"

KEYWORDS="amd64 arm64"

DEPEND="lib-dev/argtable"

src_prepare() {
	eautoreconf
	default
}
