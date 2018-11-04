# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="Video Disk Recorder - turns a pc into a powerful set top box for DVB"
HOMEPAGE="http://www.tvdr.de/"
SRC_URI="ftp://ftp.tvdr.de/vdr/${P}.tar.bz2"

KEYWORDS="amd64 ~arm ~arm64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"

PATCHES=( "${FILESDIR}"/makefile.patch )

src_install() {
	mkdir -p "${ED}"/var/lib/vdr
	emake DESTDIR="${ED}" install

	rm -rf "${ED}"/var/cache
	rm -rf "${ED}"/usr/share/man
	systemd_dounit "${FILESDIR}"/vdr.service
	mkdir -p "${ED}"/srv/vdr/video
	mkdir -p "${ED}"/etc/vdr
}
