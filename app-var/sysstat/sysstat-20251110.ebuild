# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://pagesperso-orange.fr/sebastien.godard/"
SNAPSHOT=d5687be42acdac2ccc7388733ae7a9e75372bb38
SRC_URI="https://github.com/sysstat/sysstat/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sysstat-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static systemd"

src_configure() {
	tc-export AR
	use static && append-ldflags -static

	local myconf=(
		$(use_enable debug debuginfo)
		--disable-documentation
		--disable-install-cron
		--disable-nls
		--disable-stripping
		--enable-copy-only
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
	)
	sa_lib_dir=/usr/lib/sa \
	conf_dir=/etc \
	ECONF_SOURCE=${S} \
	econf "${myconf[@]}"

}

src_compile() {
	tc-export AR CC RANLIB

	local _makeargs=(
		prefix="${EPREFIX}/usr"
		CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS}"
		CHOWN=true
		MANGRPARG=''
	)
	emake "${_makeargs[@]}"
}

src_install() {
	keepdir /var/log/sa

	local _makeargs=(
		prefix="${EPREFIX}/usr"
		CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS}"
		DESTDIR="${D}"
		CHOWN=true
		MANGRPARG=''
	)
	emake "${_makeargs[@]}" install

	if use systemd; then
		insinto usr/lib/systemd/system
		insopts -m0644
		doins sysstat.service
	fi

	cleanup_install
}
