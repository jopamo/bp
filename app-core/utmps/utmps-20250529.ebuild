# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic doins

DESCRIPTION="an implementation of the utmpx.h family of functions"
HOMEPAGE="https://skarnet.org/software/utmps/"

SNAPSHOT=032501caf08b163647ab958301d014443d461c19
SRC_URI="https://github.com/skarnet/utmps/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

#SRC_URI="https://skarnet.org/software/utmps/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"

DEPEND="app-core/skalibs"

src_configure() {
	#append-flags -ffat-lto-objects
	filter-flags -flto*
	filter-flags -Wl,-z,defs

	local myconf=(
		--enable-shared
		--disable-allstatic
		--libexecdir="${EPREFIX}"/usr/lib
		--with-pkgconfig
		--enable-libc-includes
		--with-include=/usr/include/utmps
		--enable-pkgconfig
		--with-utmp-socket=/run/utmps/.utmpd-socket
		--enable-utmp

	)

	econf "${myconf[@]}"
}

src_compile() {
	default
	cc ${CFLAGS} "${FILESDIR}/ipcwrap.c" -o ipcwrap || die
}

src_install() {
	default
	dobin ipcwrap

	newtmpfiles "${FILESDIR}/${PN}-tmpfiles" "${PN}.conf"

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/utmpd@.service
		doins "${FILESDIR}"/wtmpd@.service
		doins "${FILESDIR}"/utmpd.socket
		doins "${FILESDIR}"/wtmpd.socket
	fi
}

pkg_postinst() {
	sysusers_process
	tmpfiles_process
}
