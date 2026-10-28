# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic qa-policy

DESCRIPTION="The GLib 2.88 library of C routines"
HOMEPAGE="https://www.gtk.org/"

if [[ ${PV} = *9999 ]]; then
	EGIT_BRANCH=glib-$(ver_cut 1)-$(ver_cut 2)
	EGIT_REPO_URI="https://github.com/GNOME/${PN}"
	inherit git-r3
else
	SRC_URI="https://download.gnome.org/sources/glib/$(ver_cut 1-2)/${P}.tar.xz
			https://ftp.pieskovisko.sk/slackware/slackware-current/source/l/glib2/${P}.tar.xz"
fi

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection static-libs"

DEPEND="
	app-core/attr
	app-core/util-linux[mount]
	app-tex/docbookz
	lib-core/libffi
	lib-core/libpcre2
	lib-core/libxslt
    app-core/util-linux
    lib-core/libxml2
    lib-core/zlib
"

PATCHES=(
	"${FILESDIR}/0001-keep-pre-cancelled-task-errors-worker-owned.patch"
	"${FILESDIR}/0002-require-explicit-gvdb.patch"
	"${FILESDIR}/0003-match-param-type-callbacks.patch"
	"${FILESDIR}/0004-call-boxed-registration-directly.patch"
	"${FILESDIR}/0005-preserve-non-fixture-callback-signatures.patch"
	"${FILESDIR}/0006-preserve-list-destroy-signatures.patch"
	"${FILESDIR}/0007-call-fixture-registration-directly.patch"
	"${FILESDIR}/0008-preserve-list-comparator-signatures.patch"
)

src_configure() {
	qa-policy-configure
	filter-flags -Wl,-z,defs

	append-flags -Wno-error=format
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
		-Ddtrace=disabled
		-Ddocumentation=false
		-Dlibmount=disabled
		-Dselinux=disabled
		-Dxattr=true
		-Dtests=false
		-Dgvdb:tests=false
		-Dnls=disabled
		$(meson_feature introspection)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	qa-policy-install
}

pkg_postinst() {
	mkdir -p "${EROOT}"/usr/share/glib-2.0/gettext/
	glib-compile-schemas "${EROOT}"/usr/share/glib-2.0/schemas/
}
