# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3

DESCRIPTION="Cross-platform application development framework"
HOMEPAGE="https://www.qt.io/"
EGIT_REPO_URI="https://invent.kde.org/qt/qt/qtbase.git"
EGIT_BRANCH="kde/$(ver_cut 1).$(ver_cut 2)"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="mysql postgres sqlite systemd opengl vulkan +xkbcommon"

DEPEND="
	app-core/dbus
	lib-core/libpcre2
	lib-core/zlib
	lib-dev/double-conversion
	lib-live/glib
	lib-live/libinput
	xgui-live-lib/libxcb
	xgui-misc/freetype
	xgui-misc/harfbuzz
	xmedia-live-lib/libjpeg-turbo
	xmedia-live-lib/libpng
	xkbcommon? ( xgui-live-lib/libxkbcommon )
	mysql? ( app-server/mariadb )
	opengl? ( xmedia-live-lib/mesa )
	postgres? ( app-server/postgresql )
	sqlite? ( lib-core/sqlite )
	systemd? ( app-core/systemd )
	vulkan? ( xmedia-live-lib/vulkan-loader )
"
PDEPEND="xgui-live-lib/qtx11extras"

filter-flags -flto\*

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
		-dbus-linked
		-glib
		-no-compile-examples
		-no-pch
		-no-sql-{db2,ibase,oci,odbc,tds}
		-no-strip
		-libinput
		-openssl-linked
		-system-doubleconversion
		-system-freetype
		-system-harfbuzz
		-system-libjpeg
		-system-libpng
		-system-pcre
		-system-zlib
		$(usex arm64 '' -reduce-relocations)
		$(usex mysql -sql-mysql -no-sql-mysql)
		$(usex opengl -opengl -no-opengl)
		$(usex postgres -sql-psql -no-sql-psql)
		$(usex sqlite -sql-sqlite -no-sql-sqlite)
		$(usex sqlite -system-sqlite -no-sqlite)
		$(usex systemd -journald -no-journald)
		$(usex vulkan -vulkan -no-vulkan)
		$(usex xkbcommon -xkbcommon -no-xkbcommon)
    )
    einfo "Configuring with: ${myconf[@]}"
	"${S}"/configure "${myconf[@]}" || die "configure failed"
}

src_install() {
	make INSTALL_ROOT="${ED}" install
	cleanup_install

	dosym -r /usr/bin/qmake /usr/lib/qt$(ver_cut 1)/bin/qmake
}
