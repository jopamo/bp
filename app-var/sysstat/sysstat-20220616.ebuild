# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://pagesperso-orange.fr/sebastien.godard/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=24910006637c3d1778d4d66e093a32c127a91d4b
	SRC_URI="https://github.com/${PN}/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug lm-sensors static systemd"

DEPEND="lm-sensors? ( app-live/lm-sensors )"

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

	emake "${_makeargs[@]}"
}

src_install() {
	keepdir /var/log/sa

	emake "${_makeargs[@]}" install

	if use systemd; then
		insinto usr/lib/systemd/system
		insopts -m0644
		doins ${PN}.service
	fi

	cleanup_install
}
