# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://freedesktop.org/wiki/Software/shared-mime-info"
SRC_URI="https://people.freedesktop.org/~hadess/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="lib-dev/libxml2"
DEPEND="lib-dev/glib
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

DOCS=( ChangeLog HACKING NEWS README )

src_configure() {
	export ac_cv_func_fdatasync=no #487504

	econf \
		$(use_enable test default-make-check) \
		--disable-update-mimedb
}

src_compile() {
	# FIXME: 0.91 fails with -j9 every second time like:
	# update_mime_database-update-mime-database.o: file not recognized: File truncated
	# collect2: ld returned 1 exit status
	emake -j1
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
