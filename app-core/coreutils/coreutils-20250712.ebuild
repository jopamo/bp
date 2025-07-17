# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Standard GNU utilities (chmod, cp, dd, ls, sort, tr, head, wc, who,...)"
HOMEPAGE="https://www.gnu.org/software/coreutils/"
SNAPSHOT=083f89528ed77d91fd780c5fc81652aef319934b
SRC_URI="https://github.com/coreutils/coreutils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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
BDEPEND="app-build/gnulib"

RESTRICT="network-sandbox"

src_prepare() {
	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib

	./bootstrap --no-git --gnulib-srcdir="${S}"/gnulib

	append-flags -fno-strict-aliasing

	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
	default
}

src_configure() {
	export ac_cv_{header_selinux_{context,flash,selinux}_h,search_setfilecon}=no
	export utils_cv_stdbuf_supported=no
	local myconf=(
		$(use_enable acl)
		$(use_enable libcap)
		$(use_enable multicall single-binary)
		$(use_enable xattr)
		--enable-no-install-program="who,groups,kill,su,uptime"
		--enable-install-program=hostname
		--disable-nls
		--enable-largefile
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

