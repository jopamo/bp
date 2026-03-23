# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic qa-policy

DESCRIPTION="Standard GNU utilities (chmod, cp, dd, ls, sort, tr, head, wc, who,...)"
HOMEPAGE="https://www.gnu.org/software/coreutils/"
SNAPSHOT=58d88d243552209b7a62b9d070026208ba2ae428
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
	default

	rm -rf gnulib || die
	cp -a "${BROOT}"/usr/share/gnulib gnulib || die

	# app-build/gnulib is installed from a fixed tarball without git metadata.
	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib || die

	# The current app-build/gnulib snapshot exports struct aclinfo.u.__gl_acl_ch.
	sed -i -e 's/ai->u\._gl_acl_ch/ai->u.__gl_acl_ch/' src/ls.c || die

	# GCC 15 warns that src_mode may be used uninitialized in copy_internal.
	sed -i -e 's/mode_t src_mode IF_LINT ( = 0);/mode_t src_mode = 0;/' src/copy.c || die

	append-flags -fno-strict-aliasing
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	qa-policy-configure
	append-ldflags -no-pie -fno-PIE
	append-ldflags -Wl,-z,noexecstack
	replace-flags -O3 -O2

	export ac_cv_{header_selinux_{context,flash,selinux}_h,search_setfilecon}=no
	export utils_cv_stdbuf_supported=no
	local myconf=(
		$(use_enable acl)
		$(use_enable libcap)
		$(use_enable multicall single-binary)
		$(use_enable xattr)
		--enable-no-install-program="true,false,cp,who,groups,kill,su,uptime"
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

	qa-policy-install
}
