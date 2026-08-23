# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=700e10f91a65fae69520301926fb9819f16d292f

inherit toolchain-funcs

DESCRIPTION="Lightning Memory-Mapped Database"
HOMEPAGE="https://www.symas.com/lmdb/ https://github.com/LMDB/lmdb"
SRC_URI="https://github.com/LMDB/lmdb/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}/libraries/liblmdb"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

_lmdb_version() {
	awk '
		$1 == "#define" && $2 == "MDB_VERSION_MAJOR" { major = $3 }
		$1 == "#define" && $2 == "MDB_VERSION_MINOR" { minor = $3 }
		$1 == "#define" && $2 == "MDB_VERSION_PATCH" { patch = $3 }
		END {
			if (major != "" && minor != "" && patch != "")
				print major "." minor "." patch
		}
	' lmdb.h
}

src_prepare() {
	default
}

run_emake() {
	emake \
		AR="$(tc-getAR)" \
		CC="$(tc-getCC)" \
		LDFLAGS="${LDFLAGS}" \
		OPT= \
		XCFLAGS="${CFLAGS}" \
		bindir="${EPREFIX}/usr/bin" \
		includedir="${EPREFIX}/usr/include" \
		libdir="${EPREFIX}/usr/lib" \
		mandir="${EPREFIX}/usr/share/man" \
		prefix="${EPREFIX}/usr" \
		"$@"
}

src_compile() {
	run_emake all
}

src_install() {
	local lmdb_version=$(_lmdb_version)
	[[ -n ${lmdb_version} ]] || die "Failed to detect LMDB version from lmdb.h"

	run_emake DESTDIR="${ED}" install

	if ! use static-libs; then
		rm -f "${ED}/usr/lib/liblmdb.a" || die
	fi

	cat > "${T}/lmdb.pc" <<-EOF || die
prefix=${EPREFIX}/usr
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include

Name: lmdb
Description: Lightning Memory-Mapped Database
Version: ${lmdb_version}
Libs: -L\${libdir} -llmdb
Cflags: -I\${includedir}
EOF

	insinto /usr/lib/pkgconfig
	doins "${T}/lmdb.pc"
}
