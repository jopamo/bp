# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A lightweight and fast battery icon that sits in your system tray"
HOMEPAGE="https://github.com/ColinJones/cbatticon"
SRC_URI="https://github.com/ColinJones/cbatticon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	strip-linguas -i .
}

src_compile() {
	emake \
		V=1 \
		VERSION="${PF}" \
		WITH_NOTIFY=0 \
		WITH_GTK3=1
}

src_install() {
	emake \
		DESTDIR="${D}" \
		LANGUAGES="${LINGUAS}" \
		V=1 VERSION="${PF}" \
		install
	default
}
