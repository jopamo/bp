# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qmake-utils

DESCRIPTION="Cross-platform application development framework"
HOMEPAGE="https://www.qt.io/"

if [[ ${PV} == *9999 ]]; then
	EGIT_BRANCH="kde/$(ver_cut 1).$(ver_cut 2)"
	EGIT_REPO_URI="https://github.com/qt/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=a43df98d037ad07cf096ef2f775958ceba743613
	SRC_URI="https://invent.kde.org/qt/qt/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="gssapi keep-la mysql postgres sqlite systemd opengl vulkan xkbcommon"

DEPEND="
	app-core/dbus
	lib-core/libpcre2
	lib-core/zlib
	lib-dev/double-conversion
	lib-util/glib
	lib-util/libinput
	xgui-lib/libxcb
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
	xkbcommon? ( xgui-lib/libxkbcommon )
"
PDEPEND="
	xgui-lib/qtsvg:$(ver_cut 1)=
	xgui-lib/qttools:$(ver_cut 1)=
	xgui-lib/qtx11extras:$(ver_cut 1)=
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
		$(usex arm64 '' -reduce-relocations)
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
