# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=69087ced3cb6082f7dcfb4fc2dcaa3b68a7e2e8c
UPSTREAM_PV=0.9.35
LMDB_SOVER=0

inherit toolchain-funcs

DESCRIPTION="Lightning Memory-Mapped Database"
HOMEPAGE="https://www.symas.com/lmdb/ https://github.com/LMDB/lmdb"
SRC_URI="https://github.com/LMDB/lmdb/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}/libraries/liblmdb"

LICENSE="OPENLDAP"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default

	sed -i \
		-e 's!^SOEXT.*!SOEXT = .so.'"${LMDB_SOVER}"'!' \
		-e 's!shared -o!shared -Wl,-soname,liblmdb.so.'"${LMDB_SOVER}"' -o!' \
		Makefile || die
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
	run_emake liblmdb.so.${LMDB_SOVER} liblmdb.a mdb_stat mdb_copy mdb_dump mdb_load
}

src_install() {
	run_emake DESTDIR="${ED}" install
	dosym liblmdb.so.${LMDB_SOVER} /usr/lib/liblmdb.so

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
Version: ${UPSTREAM_PV}
Libs: -L\${libdir} -llmdb
Cflags: -I\${includedir}
EOF

	insinto /usr/lib/pkgconfig
	doins "${T}/lmdb.pc"
}
