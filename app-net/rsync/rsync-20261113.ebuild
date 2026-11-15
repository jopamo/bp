# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic toolchain-funcs

DESCRIPTION="BSD-licensed implementation of the rsync protocol"
HOMEPAGE="https://github.com/kristapsdz/openrsync"
SNAPSHOT=8235c68f11b4fad5e24849a01d04ea153c29ee28
SRC_URI="https://github.com/kristapsdz/openrsync/archive/${SNAPSHOT}.tar.gz -> openrsync-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/openrsync-${SNAPSHOT}"

LICENSE="ISC BSD BSD-2 public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="
	!static? ( lib-core/zlib )
	static? ( lib-core/zlib[static-libs(+)] )
"
RDEPEND="!static? ( lib-core/zlib )"
BDEPEND="app-dev/pkgconf"

PATCHES=( "${FILESDIR}/openrsync-gnu-make.patch" )

src_configure() {
	use static && append-ldflags -static

	./configure \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		CPPFLAGS="${CPPFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		PREFIX="${EPREFIX}/usr" \
		MANDIR="${EPREFIX}/usr/share/man" || die
}

src_compile() {
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)" LDADD_FTS= CFLAGS_FTS=
}

src_test() {
	local test opts
	for opts in "--protocol 27" "--protocol 27 -z"; do
		for test in test00_simple test1_minusa test2_minusexclude \
			test7_symlinks test8_times test19_linkdest test21_delopts; do
			mkdir -p "${T}/${test}" || die
			(
				cd "${T}/${test}" || exit
				CLIENT_RSYNC=0 SERVER_RSYNC=0 \
					tstdir="${S}/regress/functional" \
					rsync="${S}/openrsync ${opts} --rsync-path=${S}/openrsync" \
					sh "${S}/regress/functional/${test}.test"
			) || die "${test} failed (${opts})"
			rm -rf "${T:?}/${test}" || die
		done
	done
}

src_install() {
	dobin openrsync
	dosym openrsync /usr/bin/rsync
	doman openrsync.1 rsync.5 rsyncd.5
	dosym openrsync.1 /usr/share/man/man1/rsync.1
}

pkg_postinst() {
	ewarn "rsync now runs openrsync (protocol 27), not Samba rsync."
	ewarn "ACLs, xattrs, --files-from and --chmod are not supported."
}
