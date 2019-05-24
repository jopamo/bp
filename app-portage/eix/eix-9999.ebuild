# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson tmpfiles git-r3

EGIT_REPO_URI="https://github.com/vaeth/${PN}.git"

DESCRIPTION="Search and query ebuilds"
HOMEPAGE="https://github.com/vaeth/eix/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug +dep +jumbo-build +required-use sqlite swap-remote tools nls"

RDEPEND="sys-app/push
	>=sys-app/quoter-3.0-r2
	nls? ( sys-devel/gettext )
	sqlite? ( lib-sys/sqlite )"

DEPEND="${RDEPEND}
		>=sys-devel/gettext-0.19.6"

pkg_setup() {
	local old_cache="${EROOT}var/cache/${PN}"
	test -f "${old_cache}" && rm -f -- "${old_cache}"
}

src_prepare() {
	sed -i -e "s'/'${EPREFIX}/'" -- "${S}"/tmpfiles.d/eix.conf || die
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use jumbo-build)
		$(meson_use sqlite)
		$(meson_use tools separate-tools)
		$(meson_use nls)
		$(meson_use debug debugging)
		$(meson_use swap-remote)
		$(meson_use prefix always-accept-keywords)
		$(meson_use dep dep-default)
		$(meson_use required-use required-use-default)
		-Dzsh-completion="${EPREFIX}/usr/share/zsh/site-functions"
		-Dportage-rootpath="${ROOTPATH}"
		-Deprefix-default="${EPREFIX}"
		-Dextra-doc=false
		)
		meson_src_configure
}

src_install() {
	meson_src_install
	dotmpfiles tmpfiles.d/eix.conf
}

pkg_postinst() {
	local obs="${EROOT}var/cache/eix.previous"
	if test -f "${obs}"; then
		ewarn "Found obsolete ${obs}, please remove it"
	fi
	tmpfiles_process eix.conf
}

pkg_postrm() {
	if [ -z "${REPLACED_BY_VERSION}" ]; then
		rm -rf -- "${EROOT}var/cache/${PN}"
	fi
}
