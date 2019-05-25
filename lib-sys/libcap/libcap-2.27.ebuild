# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs pam flag-o-matic

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="http://www.friedhoff.org/posixfilecaps.html"
SRC_URI="mirror://kernel/linux/libs/security/linux-privs/libcap2/${P}.tar.xz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="pam static-libs"

RDEPEND=">=sys-app/attr-2.4.47
	pam? ( lib-sys/pam )"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers"

PATCHES=(
	"${FILESDIR}"/${PN}-2.25-build-system-fixes.patch
	"${FILESDIR}"/${PN}-2.25-ignore-RAISE_SETFCAP-install-failures.patch
	"${FILESDIR}"/libcap-portage.patch
)

src_compile() {
	use pam && append-flags -lpam
	tc-export AR CC RANLIB
	local BUILD_CC
	tc-export_build_env BUILD_CC
	append-cppflags -D_GNU_SOURCE
	default
}

src_install() {
	emake DESTDIR="${D}" install

	use static-libs || rm "${ED}"/usr/lib64/libcap.a

	rm -rf "${ED}"/usr/lib64/security
	if use pam; then
		dopammod pam_cap/pam_cap.so
		dopamsecurity '' pam_cap/capability.conf
	fi
}
