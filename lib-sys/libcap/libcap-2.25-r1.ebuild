# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib multilib-minimal toolchain-funcs pam flag-o-matic

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="http://www.friedhoff.org/posixfilecaps.html"
SRC_URI="mirror://kernel/linux/libs/security/linux-privs/libcap2/${P}.tar.xz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="pam static-libs"

RDEPEND=">=sys-app/attr-2.4.47[${MULTILIB_USEDEP}]
	pam? ( lib-sys/pam )"
DEPEND="${RDEPEND}
	sys-kernel/stable-sources"

PATCHES=(
	"${FILESDIR}"/${PN}-2.25-build-system-fixes.patch
	"${FILESDIR}"/${PN}-2.22-no-perl.patch
	"${FILESDIR}"/${PN}-2.25-ignore-RAISE_SETFCAP-install-failures.patch
	"${FILESDIR}"/${PN}-2.25-gperf.patch
	"${FILESDIR}"/libcap-portage.patch
	"${FILESDIR}"/7cd35dbe44e9bf3023c61ea94117e45905f86db1.patch
	"${FILESDIR}"/8030da1b54606260b5e1af6b7dcf5ce2405cf2a8.patch
	"${FILESDIR}"/8dfead766c6e540b9175bb06b0be7fb3bb715620.patch
	"${FILESDIR}"/be92eaacb73faace76f048dc1b2555578caa843b.patch
)

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_compile() {
	tc-export AR CC RANLIB
	local BUILD_CC
	tc-export_build_env BUILD_CC
	append-flags -lpam
	append-cppflags -D_GNU_SOURCE
	default
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	use static-libs || rm "${ED}"/usr/$(get_libdir)/libcap.a

	rm -rf "${ED}"/usr/$(get_libdir)/security
	if multilib_is_native_abi && use pam; then
		dopammod pam_cap/pam_cap.so
		dopamsecurity '' pam_cap/capability.conf
	fi
}
