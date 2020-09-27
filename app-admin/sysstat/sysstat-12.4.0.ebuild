# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic systemd toolchain-funcs

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://pagesperso-orange.fr/sebastien.godard/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug nls lm-sensors static systemd"

DEPEND="
	nls? ( sys-devel/gettext )
	lm-sensors? ( sys-app/lm-sensors:= )
"

_makeargs=(
  prefix="${EPREFIX}/usr"
  CFLAGS="${CFLAGS}"
  LDFLAGS="${LDFLAGS}"
  DESTDIR="${D}"
  CHOWN=true
  MANGRPARG=''
)

src_configure() {
	tc-export AR
	use static && append-ldflags -static

	local myconf=(
		$(use_enable debug debuginfo)
		$(use_enable lm-sensors sensors)
		$(use_enable nls)
		--enable-copy-only
		--disable-documentation
		--disable-install-cron
		--disable-stripping
		--with-systemdsystemunitdir=$(systemd_get_systemunitdir)
	)
	sa_lib_dir=/usr/lib/sa \
		conf_dir=/etc \
		ECONF_SOURCE=${S} \
		econf "${myconf[@]}"

}

src_compile() {
	tc-export AR CC RANLIB

	emake "${_makeargs[@]}"
}

src_install() {
	keepdir /var/log/sa

	emake "${_makeargs[@]}" install

	use systemd && systemd_dounit ${PN}.service

	cleanup_install
}
