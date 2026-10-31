# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="glib-$(ver_cut 1)-$(ver_cut 2)"

inherit meson flag-o-matic qa-policy

DESCRIPTION="The GLib 2.90 library of C routines"
HOMEPAGE="https://www.gtk.org/"
SNAPSHOT=d809ccfe206949d2a9fffe50a2d1e8760263a028
GVDB_SNAPSHOT=2b42fc75f09dbe1cd1057580b5782b08f2dcb400
# lockstep-gitlink: GVDB_SNAPSHOT SNAPSHOT subprojects/gvdb
SRC_URI="
	https://github.com/GNOME/glib/archive/${SNAPSHOT}.tar.gz -> glib-${SNAPSHOT}.tar.gz
	https://github.com/GNOME/gvdb/archive/${GVDB_SNAPSHOT}.tar.gz -> gvdb-${GVDB_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/glib-${SNAPSHOT}"

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
BDEPEND="
	introspection? ( >=lib-dev/gobject-introspection-1.80 )
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
	"${FILESDIR}/0009-match-variant-type-equality-signature.patch"
	"${FILESDIR}/0010-match-core-variant-destroy-signatures.patch"
	"${FILESDIR}/0011-match-byte-slice-destroy-signature.patch"
	"${FILESDIR}/0012-match-variant-test-data-signature.patch"
	"${FILESDIR}/0013-match-object-type-callbacks.patch"
	"${FILESDIR}/0014-match-static-type-initializer-signatures.patch"
	"${FILESDIR}/0015-match-message-header-destroy-signature.patch"
	"${FILESDIR}/0016-match-weak-reference-callback-signatures.patch"
	"${FILESDIR}/0017-adapt-parameter-instance-initializers.patch"
	"${FILESDIR}/0018-match-parameter-pool-destroy-signature.patch"
	"${FILESDIR}/0019-match-module-type-callback-signatures.patch"
	"${FILESDIR}/0020-match-test-type-registration-callbacks.patch"
	"${FILESDIR}/0021-match-dynamic-type-initializer-signatures.patch"
	"${FILESDIR}/0022-match-manual-test-type-callbacks.patch"
	"${FILESDIR}/0023-match-interface-default-initializer-signature.patch"
	"${FILESDIR}/0024-match-qdata-test-duplicate-signature.patch"
)

src_unpack() {
	default
	rmdir "${S}/subprojects/gvdb" || die
	mv "${WORKDIR}/gvdb-${GVDB_SNAPSHOT}" "${S}/subprojects/gvdb" || die
}

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
