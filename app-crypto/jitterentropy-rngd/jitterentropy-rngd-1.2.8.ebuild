# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info

DESCRIPTION="Jitter RNG daemon"
HOMEPAGE="https://www.chronox.de/jent.html"
SRC_URI="https://github.com/smuellerDD/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	sed -i 's/install: strip/install:/; /gzip -9/d' Makefile
}

src_configure() {
	filter-flags '*'
	append-cflags '-O0'
	default
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" \
		UNITDIR="/usr/lib/systemd/system" install
}
