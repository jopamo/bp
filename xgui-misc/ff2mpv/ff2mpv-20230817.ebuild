# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-single-r1

DESCRIPTION="A Firefox add-on for playing URLs in mpv."
HOMEPAGE="https://addons.mozilla.org/en-US/firefox/addon/ff2mpv/"
SRC_URI="https://github.com/woodruffw/ff2mpv/archive/${PV}.tar.gz -> ${P}.tar.gz"

SNAPSHOT=96897a8a8151f85c06abfdc77c4048051a18d6ea
SRC_URI="https://github.com/woodruffw/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-net/yt-dlp"

src_prepare() {
	default
	sed -i -e "s/home\/william\/scripts\/ff2mpv/usr\/bin\/ff2mpv.py/g" "${PN}.json" || die
}

src_install() {
	python_doscript ${PN}.py

	insinto	/usr/lib/mozilla/native-messaging-hosts/
	doins ${PN}.json
}
