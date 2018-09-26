# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils multilib multilib-minimal toolchain-funcs pam flag-o-matic

DESCRIPTION="POSIX 1003.1e capabilities"
HOMEPAGE="http://www.friedhoff.org/posixfilecaps.html"
SRC_URI="mirror://kernel/linux/libs/security/linux-privs/libcap2/${P}.tar.xz"

# it's available under either of the licenses
LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="pam static-libs"

# While the build system optionally uses gperf, we don't DEPEND on it because
# the build automatically falls back when it's unavailable.  #604802
RDEPEND=">=sys-app/attr-2.4.47[${MULTILIB_USEDEP}]
	pam? ( lib-sys/pam )"
DEPEND="${RDEPEND}
	sys-kernel/stable-sources"

PATCHES=(
	"${FILESDIR}"/${PN}-2.25-build-system-fixes.patch
	"${FILESDIR}"/${PN}-2.22-no-perl.patch
	"${FILESDIR}"/${PN}-2.25-ignore-RAISE_SETFCAP-install-failures.patch
	"${FILESDIR}"/${PN}-2.21-include.patch
	"${FILESDIR}"/${PN}-2.25-gperf.patch
)

src_prepare() {
	epatch "${PATCHES[@]}"
	eapply_user
	multilib_copy_sources
}

multilib_src_configure() {
	local pam
	if multilib_is_native_abi && use pam; then
		pam=yes
	else
		pam=no
	fi

	sed -i \
		-e "/^PAM_CAP/s:=.*:=${pam}:" \
		-e '/^DYNAMIC/s:=.*:=yes:' \
		-e '/^lib_prefix=/s:=.*:=$(prefix):' \
		-e "/^lib=/s:=.*:=$(get_libdir):" \
		Make.Rules
}

multilib_src_compile() {
	tc-export AR CC RANLIB
	local BUILD_CC
	tc-export_build_env BUILD_CC
	append-flags -lpam
	default
}

multilib_src_install() {
	emake DESTDIR="${D}" install
	cp -r "${ED}"/sbin "${ED}"/usr/
	rm -rf "${ED}"/sbin

	use static-libs || rm "${ED}"/usr/$(get_libdir)/libcap.a

	rm -rf "${ED}"/usr/$(get_libdir)/security
	if multilib_is_native_abi && use pam; then
		dopammod pam_cap/pam_cap.so
		dopamsecurity '' pam_cap/capability.conf
	fi
}
