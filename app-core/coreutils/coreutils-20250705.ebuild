# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Standard GNU utilities (chmod, cp, dd, ls, sort, tr, head, wc, who,...)"
HOMEPAGE="https://www.gnu.org/software/coreutils/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl libcap multicall static xattr"

LIB_DEPEND="
	acl? ( app-core/acl[static-libs] )
	libcap? ( lib-core/libcap[static-libs] )
	xattr? ( app-core/attr[static-libs] )
"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs]} )"
DEPEND="
	${RDEPEND}
	static? ( ${LIB_DEPEND} )
	app-compression/xz-utils
"

src_prepare() {
	append-flags -fno-strict-aliasing

	default

	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	export ac_cv_{header_selinux_{context,flash,selinux}_h,search_setfilecon}=no
	export utils_cv_stdbuf_supported=no
	local myconf=(
		$(use_enable acl)
		$(use_enable libcap)
		$(use_enable multicall single-binary)
		$(use_enable xattr)
		--enable-no-install-program="groups,kill,su,uptime"
		--enable-install-program=hostname
		--disable-nls
		--enable-largefile
		--without-libgmp
	)

	export gl_cv_func_mknod_works=yes
	use static && append-ldflags -static

	econf "${myconf[@]}"
}

src_install() {
	default

	insinto /etc
	doins "${FILESDIR}"/LS_COLORS
}

