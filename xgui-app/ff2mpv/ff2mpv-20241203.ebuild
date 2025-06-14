# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-single-r1

DESCRIPTION="A Firefox add-on for playing URLs in mpv."
HOMEPAGE="https://addons.mozilla.org/en-US/firefox/addon/ff2mpv/"

SNAPSHOT=b312d7e816a99f4c7abd96b3d6ce57d1fca5bc3c
SRC_URI="https://github.com/woodruffw/ff2mpv/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xmedia-app/yt-dlp"

src_prepare() {
	default
	sed -i -e "s/home\/william\/scripts\/ff2mpv/usr\/bin\/ff2mpv.py/g" "ff2mpv.json" || die
}

src_install() {
	python_doscript ff2mpv.py

	insinto	/usr/lib/mozilla/native-messaging-hosts/
	doins ff2mpv.json
}
