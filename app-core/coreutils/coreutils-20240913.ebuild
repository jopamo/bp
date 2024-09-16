# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Standard GNU utilities (chmod, cp, dd, ls, sort, tr, head, wc, who,...)"
HOMEPAGE="https://www.gnu.org/software/coreutils/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl caps gmp multicall musl static xattr"

LIB_DEPEND="
	acl? ( app-core/acl[static-libs] )
	caps? ( lib-core/libcap )
	gmp? ( lib-core/gmp[static-libs] )
	xattr? ( app-core/attr[static-libs] )
"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs]} )"
DEPEND="
	${RDEPEND}
	static? ( ${LIB_DEPEND} )
	app-compression/xz-utils
"

append-flags -fno-strict-aliasing

src_prepare() {
	default
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	export ac_cv_{header_selinux_{context,flash,selinux}_h,search_setfilecon}=no

	local myconf=(
		--enable-no-install-program="groups,kill,su,uptime"
		--enable-install-program=hostname
		--enable-largefile
		--disable-nls
		$(use caps || echo --disable-libcap)
		$(use_enable acl)
		$(use_enable multicall single-binary)
		$(use_enable xattr)
		$(use_with gmp libgmp)
	)

	export gl_cv_func_mknod_works=yes #409919
	use static && append-ldflags -static && sed -i '/elf_sys=yes/s:yes:no:' configure #321821

	econf "${myconf[@]}"
	#use musl || econf "${myconf[@]}"
	#use musl && CFLAGS="-I/usr/include/utmps" LIBS="-lutmps -lskarnet" econf "${myconf[@]}"
}

src_install() {
	default

	insinto /etc
	doins "${FILESDIR}"/LS_COLORS
}

