# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson doins

DESCRIPTION="Y2038 safe wtmp implementation as PAM module using sqlite as database"
HOMEPAGE="https://github.com/jopamo/musl-bsd"
SNAPSHOT=272b109f5b3bdfb3008604461b4ddbff03c28b77
SRC_URI="https://github.com/thkukuk/wtmpdb/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	append-flags -D_GNU_SOURCE
	append-cflags -include unistd.h

	local emesonargs=(
    	-D man=disabled
    	-D wtmpdbd=enabled
    	-D compat-symlink=true
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	dobin "${FILESDIR}"/who
	dobin "${FILESDIR}"/w
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process

	systemctl enable --now \
    wtmpdb-update-boot.service \
    wtmpdb-rotate.timer      \
    wtmpdbd.socket
}
