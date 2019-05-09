# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils git-r3 autotools

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://freedesktop.org/wiki/Software/shared-mime-info"
EGIT_REPO_URI="https://github.com/freedesktop/xdg-shared-mime-info.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-dev/libxml2"
DEPEND="lib-dev/glib
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconf"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf --disable-update-mimedb
}

src_install() {
	default

	# in prefix, install an env.d entry such that prefix patch is used/added
	if use prefix; then
		echo "XDG_DATA_DIRS=\"${EPREFIX}/usr/share\"" > "${T}"/50mimeinfo || die
		doenvd "${T}"/50mimeinfo
	fi
}

pkg_postinst() {
	use prefix && export XDG_DATA_DIRS="${EPREFIX}"/usr/share
	xdg_mimeinfo_database_update
}
