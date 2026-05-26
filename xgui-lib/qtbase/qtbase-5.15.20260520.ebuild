# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="kde/$(ver_cut 1-2)"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Cross-platform application development framework"
HOMEPAGE="https://www.qt.io/"

SNAPSHOT=fbed962c3195ab3952fa54d40e012ad1a4fdc42b
SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="gssapi keep-la mysql postgres sqlite systemd opengl vulkan xkbcommon"
REQUIRED_USE="xkbcommon"

DEPEND="
	virtual/dbus
	lib-core/libpcre2
	lib-core/zlib
	lib-dev/double-conversion
	lib-core/glib
	lib-core/libinput
	xgui-lib/libX11
	xgui-lib/libXext
	xgui-lib/libxcb[xkb]
	xgui-lib/xcb-util
	xgui-lib/xcb-util-image
	xgui-lib/xcb-util-keysyms
	xgui-lib/xcb-util-renderutil
	xgui-lib/xcb-util-wm
	xgui-lib/freetype
	xgui-lib/harfbuzz
	xmedia-lib/libjpeg-turbo
	xmedia-lib/libpng
	gssapi? ( app-crypto/mit-krb5 )
	mysql? ( app-server/mariadb )
	opengl? ( xgui-tools/mesa )
	postgres? ( app-server/postgresql )
	sqlite? ( lib-core/sqlite )
	systemd? ( app-core/systemd )
	vulkan? ( xmedia-lib/vulkan-loader )
	xkbcommon? ( xgui-lib/libxkbcommon[X] )
"
PDEPEND="
	xgui-lib/qtsvg:$(ver_cut 1)
	xgui-lib/qttools:$(ver_cut 1)
	xgui-lib/qtx11extras:$(ver_cut 1)
"

qtbase_qmakespec() {
	if tc-is-clang; then
		local cxx
		cxx=$(tc-getCXX)
		if "${cxx}" -E -x c++ - -v </dev/null 2>&1 | grep -q '/c++/v1'; then
			echo linux-clang-libc++
		else
			echo linux-clang
		fi
	else
		echo linux-g++
	fi
}

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
	local qtplatform
	[[ ${ARCH} == arm64 ]] && reduce_relocations=""
	qtplatform=$(qtbase_qmakespec)

	local myconf=(
		-opensource -confirm-license
		-release
		-no-static
		-no-framework
		-no-rpath
		-platform "${qtplatform}"
		-prefix "${EPREFIX}"/usr
		-docdir "${EPREFIX}"/usr/share/doc/qt$(ver_cut 1)
		-headerdir "${EPREFIX}"/usr/include/qt$(ver_cut 1)
		-archdatadir "${EPREFIX}"/usr/lib/qt$(ver_cut 1)
		-datadir "${EPREFIX}"/usr/share/qt$(ver_cut 1)
		-sysconfdir "${EPREFIX}"/etc/xdg
		-examplesdir "${EPREFIX}"/usr/share/doc/qt$(ver_cut 1)/examples
		-dbus-linked
		-glib
		-no-compile-examples
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
		-xcb
		${reduce_relocations}
		$(usex gssapi -feature-gssapi -no-feature-gssapi)
		$(usex mysql -sql-mysql -no-sql-mysql)
		$(usex opengl -opengl -no-opengl)
		$(usex postgres -sql-psql -no-sql-psql)
		$(usex sqlite -sql-sqlite -no-sql-sqlite)
		$(usex sqlite -system-sqlite -no-sqlite)
		$(usex systemd -journald -no-journald)
		$(usex vulkan -vulkan -no-vulkan)
		$(usex xkbcommon -xkbcommon -no-xkbcommon)
    )
	einfo "Using Qt platform spec: ${qtplatform}"
    einfo "Configuring with: ${myconf[@]}"
	"${S}"/configure "${myconf[@]}" || die "configure failed"
}

src_install() {
	make INSTALL_ROOT="${ED}" install
	cleanup_install

	dosym -r /usr/bin/qmake /usr/lib/qt$(ver_cut 1)/bin/qmake

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
