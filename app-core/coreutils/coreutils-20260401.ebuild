# Distributed under the terms of the GNU General Public License v2

inherit autotools flag-o-matic qa-policy

DESCRIPTION="Standard GNU utilities (chmod, cp, dd, ls, sort, tr, head, wc, who,...)"
HOMEPAGE="https://www.gnu.org/software/coreutils/"

SNAPSHOT=8161e0d2d04b5faae002bb3c35d5d20d9362796c
SRC_URI="https://gitlab.com/pjo/coreutils/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.gz"
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

RESTRICT="network-sandbox"

src_prepare() {
	default

	# GitLab archive omits generated files required by autoreconf.
	./build-aux/gen-lists-of-programs.sh --autoconf > m4/cu-progs.m4 || die
	chmod a-w m4/cu-progs.m4 || die
	./build-aux/gen-lists-of-programs.sh --automake > src/cu-progs.mk || die
	chmod a-w src/cu-progs.mk || die
	./build-aux/gen-single-binary.sh src/local.mk > src/single-binary.mk || die
	chmod a-w src/single-binary.mk || die

	eautoreconf

	# GCC 15 warns that src_mode may be used uninitialized in copy_internal.
	sed -i -e 's/mode_t src_mode IF_LINT ( = 0);/mode_t src_mode = 0;/' src/copy.c || die

	append-flags -fno-strict-aliasing
	sed -i -e "s/UNKNOWN/${PV}/g" configure || die
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
