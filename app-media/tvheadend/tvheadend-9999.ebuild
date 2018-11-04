# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 systemd

DESCRIPTION="Tvheadend is a TV streaming server and digital video recorder"
HOMEPAGE="https://tvheadend.org/"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="systemd"

DEPEND="
	${RDEPEND}
	app-media/ffmpeg
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-tvhcsa \
		--disable-libav \
		--disable-libx265 \
		--disable-libtheora \
		--disable-bundle \
		--disable-libvorbis
}

src_install() {
	default

	use systemd &&
		systemd_dounit "${FILESDIR}"/tvheadend.service
}
