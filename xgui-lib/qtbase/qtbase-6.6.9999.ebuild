EAPI=8

CMAKE_IN_SOURCE_BUILD=1

inherit flag-o-matic git-r3 cmake

DESCRIPTION="Cross-platform application development framework"
HOMEPAGE="https://www.qt.io/"
EGIT_REPO_URI="https://github.com/qt/${PN}.git"
EGIT_BRANCH=$(ver_cut 1).$(ver_cut 2)

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="gssapi mysql postgres sqlite systemd opengl vulkan +xkbcommon"

DEPEND="
	lib-live/libinput
	gssapi? ( app-crypto/mit-krb5 )
	mysql? ( app-server/mariadb )
	opengl? ( xgui-misc/mesa )
	postgres? ( app-server/postgresql )
	sqlite? ( lib-core/sqlite )
	systemd? ( app-core/systemd )
	vulkan? ( xmedia-live-lib/vulkan-loader )
	xkbcommon? ( xgui-live-lib/libxkbcommon )
"

src_prepare() {
	filter-flags -flto*

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
		-bindir "${EPREFIX}"/usr/lib/qt$(ver_cut 1)/bin
		-docdir "${EPREFIX}"/usr/share/doc/qt$(ver_cut 1)
		-headerdir "${EPREFIX}"/usr/include/qt$(ver_cut 1)
		-archdatadir "${EPREFIX}"/usr/lib/qt$(ver_cut 1)
		-datadir "${EPREFIX}"/usr/share/qt$(ver_cut 1)
		-sysconfdir "${EPREFIX}"/etc/xdg
		-examplesdir "${EPREFIX}"/usr/share/doc/qt$(ver_cut 1)/examples
		-dbus-linked
		-glib
		-no-pch
		-no-sql-{db2,ibase,oci,odbc}
		-no-strip
		-libinput
		-no-accessibility
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
	cmake_src_install
}
