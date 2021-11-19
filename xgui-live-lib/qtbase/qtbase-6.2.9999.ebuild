# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_IN_SOURCE_BUILD=1

inherit flag-o-matic git-r3 cmake

DESCRIPTION="Cross-platform application development framework"
HOMEPAGE="https://www.qt.io/"
EGIT_REPO_URI="https://github.com/qt/${PN}.git"
EGIT_BRANCH=$(ver_cut 1).$(ver_cut 2)

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="mysql postgres sqlite systemd opengl vulkan"

DEPEND="
	app-core/dbus
	lib-core/libpcre2
	lib-core/zlib
	lib-dev/double-conversion
	lib-live/glib
	xgui-live-lib/libxcb
	xgui-misc/freetype
	xgui-misc/harfbuzz
	xmedia-live-lib/libjpeg-turbo
	xmedia-live-lib/libpng
	mysql? ( app-server/mariadb )
	opengl? ( xmedia-live-lib/mesa )
	postgres? ( app-server/postgresql )
	sqlite? ( lib-core/sqlite )
	systemd? ( app-core/systemd )
	vulkan? ( xmedia-live-lib/vulkan-loader )
"

filter-flags -flto\*
append-cppflags -DOPENSSL_NO_PSK -DOPENSSL_NO_NEXTPROTONEG -Wno-deprecated-declarations -Wno-class-memaccess -Wno-packed-not-aligned

src_prepare() {
	sed -i -e "s|^\(QMAKE_CFLAGS_RELEASE.*\)|\1 ${CFLAGS}|" \
		mkspecs/common/gcc-base.conf
	sed -i -e "s|^\(QMAKE_LFLAGS_RELEASE.*\)|\1 ${LDFLAGS}|" \
		mkspecs/common/g++-unix.conf

	cmake_src_prepare
}

src_configure() {
	local myconf=(
		-cmake-generator Ninja
		-opensource -confirm-license
		-release
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
		-dbus-linked
		-glib
		-no-framework
		-no-pch
		-no-rpath
		-no-sql-{db2,ibase,oci,odbc}
		-no-static
		-no-strip
		-openssl-linked
		$(usex arm64 '' -reduce-relocations)
		$(usex mysql -sql-mysql -no-sql-mysql)
		$(usex opengl '' -no-opengl)
		$(usex postgres -sql-psql -no-sql-psql)
		$(usex sqlite -sql-sqlite -no-sql-sqlite)
		$(usex sqlite -system-sqlite -no-sqlite)
		$(usex systemd -journald -no-journald)
		$(usex vulkan -vulkan -no-vulkan)
    )
    einfo "Configuring with: ${myconf[@]}"
	"${S}"/configure "${myconf[@]}" || die "configure failed"
}

src_install() {
	cmake_src_install

	dosym -r /usr/bin/qmake /usr/lib/qt$(ver_cut 1)/bin/qmake
}
