# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=5f42263298db3fbb1e2780acc59be1ff8146abd8

inherit meson

DESCRIPTION="Search and query ebuilds"
HOMEPAGE="https://github.com/vaeth/eix/"
SRC_URI="https://github.com/vaeth/eix/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +dep +jumbo-build +required-use sqlite swap-remote tmpfilesd tools"

DEPEND="
	app-var/push
	app-var/quoter
	sqlite? ( lib-core/sqlite )
"

pkg_setup() {
	local old_cache="${EROOT}/var/cache/${PN}"
	test -f "${old_cache}" && rm -f -- "${old_cache}"
}

src_prepare() {
	sed -i -e "s'/'${EPREFIX}/'" -- "${S}"/tmpfiles.d/eix.conf || die
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use debug debugging)
		$(meson_use dep dep-default)
		$(meson_use jumbo-build)
		$(meson_use prefix always-accept-keywords)
		$(meson_use required-use required-use-default)
		$(meson_use sqlite)
		$(meson_use swap-remote)
		$(meson_use tools separate-tools)
		-Deprefix-default="${EPREFIX}"
		-Dextra-doc=false
		-Dnls=false
		-Dprotobuf=false
		)
		meson_src_configure
}

src_install() {
	meson_src_install

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		doins tmpfiles.d/eix.conf
	fi
}

pkg_postinst() {
	local obs="${EROOT}/var/cache/eix.previous"
	if test -f "${obs}"; then
		ewarn "Found obsolete ${obs}, please remove it"
	fi
}

pkg_postrm() {
	if [ -z "${REPLACED_BY_VERSION}" ]; then
		rm -r -- "${EROOT}/var/cache/${PN}" || die
	fi
}
