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
	"${FILESDIR}"/0f0eca489e979b4a8526e521f962455e474a27a0.patch
	"${FILESDIR}"/1f52c8a50305ab07b029008a8c7d6318355944b3.patch
	"${FILESDIR}"/7cd35dbe44e9bf3023c61ea94117e45905f86db1.patch
	"${FILESDIR}"/8030da1b54606260b5e1af6b7dcf5ce2405cf2a8.patch
	"${FILESDIR}"/8c67abc3f5cfa8310dae21e5db464fd990cb71a2.patch
	"${FILESDIR}"/8dfead766c6e540b9175bb06b0be7fb3bb715620.patch
	"${FILESDIR}"/be92eaacb73faace76f048dc1b2555578caa843b.patch
	"${FILESDIR}"/dce069b617cf5e42fde707196eaf2ee8d62bc96c.patch
)

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	sed -i.bak -e "s/\$\(lib\)/\$\(get_libdir\)/g" "Make.Rules"
	multilib_copy_sources
}

multilib_src_compile() {
	tc-export AR CC RANLIB
	local BUILD_CC
	tc-export_build_env BUILD_CC
	append-cppflags -D_GNU_SOURCE
	default
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	use static-libs || rm "${ED}"usr/$(get_libdir)/libcap.a

	rm -rf "${ED}"usr/$(get_libdir)/security
	if multilib_is_native_abi && use pam; then
		dopammod pam_cap/pam_cap.so
		dopamsecurity '' pam_cap/capability.conf
	fi
}
