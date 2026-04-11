# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="$(ver_cut 1-2)"

CMAKE_IN_SOURCE_BUILD=1

inherit flag-o-matic cmake

DESCRIPTION="Cross-platform application development framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=a01b10ce81fc771ad4dd2bc3bc28a40c2d2e0a68
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="gssapi mysql postgres sqlite systemd opengl vulkan xkbcommon"

DEPEND="
	lib-core/libinput
	xmedia-lib/libpng
	xgui-lib/harfbuzz
	lib-dev/double-conversion
	xgui-lib/freetype
	gssapi? ( app-crypto/mit-krb5 )
	mysql? ( app-server/mariadb )
	opengl? ( xgui-tools/mesa )
	postgres? ( app-server/postgresql )
	sqlite? ( lib-core/sqlite )
	systemd? ( app-core/systemd )
	vulkan? ( xmedia-lib/vulkan-loader )
	xkbcommon? ( xgui-lib/libxkbcommon )
"

src_prepare() {
	filter-flags -flto*

	sed -i -e "s|^\(QMAKE_CFLAGS_RELEASE.*\)|\1 ${CFLAGS}|" \
		mkspecs/common/gcc-base.conf
	sed -i -e "s|^\(QMAKE_LFLAGS_RELEASE.*\)|\1 ${LDFLAGS}|" \
		mkspecs/common/g++-unix.conf

	default

	local qtver
	qtver="$(sed -n 's/^MODULE_VERSION[[:space:]]*=[[:space:]]*//p' .qmake.conf)" || die
	[[ -n ${qtver} ]] || die "Failed to detect MODULE_VERSION from .qmake.conf"
	"${S}"/bin/syncqt.pl -version "${qtver}" -outdir "${S}" "${S}" || die
}

src_configure() {
	local reduce_relocations="-reduce-relocations"
	[[ ${ARCH} == arm64 ]] && reduce_relocations=""

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
		${reduce_relocations}
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
