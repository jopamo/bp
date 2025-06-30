# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="http://www.friedhoff.org/posixfilecaps.html"
SNAPSHOT=a5753d029173d69b09f593da13575b19e17641ff
SRC_URI="https://github.com/1g4-mirror/libcap/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam static-libs"

RDEPEND="
	app-core/attr
	pam? ( lib-core/pam )
"
BDEPEND="virtual/linux-sources"

run_emake() {
	local args=(
		AR="$(tc-getAR)"
		CC="$(tc-getCC)"
		CFLAGS="${CFLAGS}"
		DYNAMIC="yes"
		GOLANG="no"
		KERNEL_HEADERS="${EPREFIX}"/usr/include
		LDFLAGS="${LDFLAGS}"
		OBJCOPY="$(tc-getOBJCOPY)"
		PAM_CAP="$(usex pam yes no)"
		RAISE_SETFCAP=no
		RANLIB="$(tc-getRANLIB)"
		SBINDIR="${EPREFIX}"/usr/bin
		exec_prefix="${EPREFIX}"
		lib="lib"
		lib_prefix="${EPREFIX}/usr"
		prefix="${EPREFIX}/usr"
		)
	emake "${args[@]}" "$@"
}

src_compile() {
	filter-flags -Wl,-z,defs
	append-flags -ffat-lto-objects
	append-cppflags -D_GNU_SOURCE

	use pam && append-flags -lpam

	tc-export AR CC RANLIB

	local BUILD_CC
	tc-export_build_env BUILD_CC

	run_emake
}

src_install() {
	run_emake DESTDIR="${D}" install

	if ! use static-libs; then
		rm "${ED}"/usr/lib/libcap.a
		rm "${ED}"/usr/lib/libpsx.a
		find "${ED}" -name '*.la' -delete
	fi

	if [[ -d "${ED}"/usr/lib/security ]] ; then
		rm -r "${ED}"/usr/lib/security || die
	fi

	if use pam; then
		insinto usr/lib/security/
		insopts -m 0644
		doins pam_cap/pam_cap.so

		insinto etc/security/
		insopts -m 0644
		doins pam_cap/capability.conf
	fi
}
