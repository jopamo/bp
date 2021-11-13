# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3

DESCRIPTION="Cross-platform application development framework"
HOMEPAGE="https://www.qt.io/"
EGIT_REPO_URI="https://invent.kde.org/qt/qt/qtbase.git"
EGIT_BRANCH="kde/$(ver_cut 1).$(ver_cut 2)"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="icu mysql postgres sqlite systemd opengl vulkan"

DEPEND="
	lib-dev/double-conversion
	lib-live/glib
	lib-core/libpcre2
	xgui-live-lib/libxcb
	xgui-misc/freetype
	xgui-misc/harfbuzz
	xmedia-live-lib/libjpeg-turbo
	xmedia-live-lib/libpng
	lib-core/sqlite
	lib-core/zlib
	app-core/dbus
	app-core/systemd
	mysql? ( app-server/mariadb )
	opengl? ( xmedia-live-lib/mesa )
	postgres? ( app-server/postgresql )
	sqlite? ( lib-core/sqlite )
	vulkan? ( xmedia-live-lib/vulkan-loader )
"
PDEPEND="xgui-live-lib/qtx11extras"

filter-flags -flto\=\*
append-cppflags -DOPENSSL_NO_PSK -DOPENSSL_NO_NEXTPROTONEG -Wno-deprecated-declarations -Wno-class-memaccess -Wno-packed-not-aligned

PATCHES=( "${FILESDIR}"/38a72af4fd311219779f89b2b78cd56d879f61db.patch )

src_prepare() {
	sed -i -e "s|^\(QMAKE_CFLAGS_RELEASE.*\)|\1 ${CFLAGS}|" \
		mkspecs/common/gcc-base.conf
	sed -i -e "s|^\(QMAKE_LFLAGS_RELEASE.*\)|\1 ${LDFLAGS}|" \
		mkspecs/common/g++-unix.conf

	default
}

src_configure() {
	local myconf=(
		-opensource -confirm-license
		-release
		-no-static
		-no-framework
		-no-rpath
		-prefix "${EPREFIX}"/usr
		-docdir "${EPREFIX}"/usr/share/doc/qt
		-headerdir "${EPREFIX}"/usr/include/qt
		-archdatadir "${EPREFIX}"/usr/lib/qt
		-datadir "${EPREFIX}"/usr/share/qt
		-sysconfdir "${EPREFIX}"/etc/xdg
		-examplesdir "${EPREFIX}"/usr/share/doc/qt/examples
		-system-harfbuzz
		-system-doubleconversion
		-system-pcre
		-system-zlib
		-system-libpng
		-system-libjpeg
		-system-freetype
		-glib
		-openssl-linked
		-no-compile-examples
		-no-pch
		-no-strip
		-dbus-linked
		-journald
		-no-sql-{db2,ibase,oci,odbc,tds}
		$(usex mysql -sql-mysql -no-sql-mysql)
		$(usex postgres -sql-psql -no-sql-psql)
		$(usex sqlite -system-sqlite -no-sqlite)
		$(usex sqlite -sql-sqlite -no-sql-sqlite)
		$(usex arm64 '' -reduce-relocations)
		$(usex opengl '' -no-opengl)
		$(usex vulkan -vulkan -no-vulkan)
    )
    einfo "Configuring with: ${myconf[@]}"
	"${S}"/configure "${myconf[@]}" || die "configure failed"
}

src_install() {
	make INSTALL_ROOT="${ED}" install
	cleanup_install

	dosym -r /usr/bin/qmake /usr/lib/qt5/bin/qmake
}
