# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit toolchain-funcs libtool flag-o-matic  \
	pam python-single-r1 multilib-minimal systemd autotools

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git"
else
	SNAPSHOT=200769b6c0dff6863089ea2a9ff4ea9ccbd15d0f
	SRC_URI="https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/snapshot/util-linux-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/util-linux/"

LICENSE="GPL-2 LGPL-2.1 BSD-4 MIT public-domain"
SLOT="0"
IUSE="build caps +cramfs fdformat kill ncurses nls pam python +readline selinux static-libs +suid systemd test +tty-helpers udev unicode"

RDEPEND="caps? ( lib-sys/libcap-ng )
	cramfs? ( lib-sys/zlib )
	ncurses? ( >=lib-sys/ncurses-5.2-r2:0=[unicode?] )
	pam? ( lib-sys/pam )
	python? ( ${PYTHON_DEPS} )
	readline? ( lib-sys/readline:0= )
	selinux? ( >=lib-sys/libselinux-2.2.2-r4[${MULTILIB_USEDEP}] )
	!build? ( systemd? ( sys-app/systemd ) )
	udev? ( sys-app/systemd:= )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	test? ( sys-devel/bc )
	sys-kernel/stable-sources"

RDEPEND+="
	kill? (
		!sys-app/coreutils[kill]
		!sys-app/procps[kill]
	)
	!app-net/rfkill
	!sys-app/schedutils
	!sys-app/setarch
	!<sys-app/sysvinit-2.88-r7
	!<lib-sys/e2fsprogs-libs-1.41.8
	!<sys-fs/e2fsprogs-1.41.8
	!<sys-app/s390-tools-1.36.1-r1"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	${S}/autogen.sh
	default
	eautoreconf
	sed -i.bak -e "s/UNKNOWN/${PV}/g" "configure"
}

lfs_fallocate_test() {
	# Make sure we can use fallocate with LFS #300307
	cat <<-EOF > "${T}"/fallocate.${ABI}.c
		#define _GNU_SOURCE
		#include <fcntl.h>
		main() { return fallocate(0, 0, 0, 0); }
	EOF
	append-lfs-flags
	$(tc-getCC) ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} "${T}"/fallocate.${ABI}.c -o /dev/null >/dev/null 2>&1 \
		|| export ac_cv_func_fallocate=no
	rm -f "${T}"/fallocate.${ABI}.c
}

multilib_src_configure() {
	lfs_fallocate_test
	# The scanf test in a run-time test which fails while cross-compiling.
	# Blindly assume a POSIX setup since we require libmount, and libmount
	# itself fails when the scanf test fails. #531856
	tc-is-cross-compiler && export scanf_cv_alloc_modifier=ms
	export ac_cv_header_security_pam_misc_h=$(multilib_native_usex pam) #485486
	export ac_cv_header_security_pam_appl_h=$(multilib_native_usex pam) #545042

	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--disable-chfn-chsh
		--disable-login
		--disable-nologin
		--disable-su
		--docdir='${datarootdir}'/doc/${PF}
		--enable-agetty
		--enable-fs-paths-extra="${EPREFIX}/usr/sbin:${EPREFIX}/bin:${EPREFIX}/usr/bin"
		--enable-line
		--enable-partx
		--enable-raw
		--enable-rename
		--enable-rfkill
		--enable-schedutils
		--with-systemdsystemunitdir=$(multilib_native_usex systemd "$(systemd_get_systemunitdir)" "no")
		$(multilib_native_use_enable caps setpriv)
		$(multilib_native_use_enable cramfs)
		$(multilib_native_use_enable fdformat)
		$(multilib_native_use_enable nls)
		$(multilib_native_use_enable suid makeinstall-chown)
		$(multilib_native_use_enable suid makeinstall-setuid)
		$(multilib_native_use_enable tty-helpers mesg)
		$(multilib_native_use_enable tty-helpers wall)
		$(multilib_native_use_enable tty-helpers write)
		$(multilib_native_use_with python)
		$(multilib_native_use_with readline)
		$(multilib_native_use_with systemd)
		$(multilib_native_use_with udev)
		$(multilib_native_usex ncurses "$(use_with unicode ncursesw)" '--without-ncursesw')
		$(multilib_native_usex ncurses "$(use_with !unicode ncurses)" '--without-ncurses')
		$(tc-has-tls || echo --disable-tls)
		$(use_enable unicode widechar)
		$(use_enable kill)
		$(use_enable static-libs static)
		$(use_with selinux)
		$(usex ncurses '' '--without-tinfo')
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

multilib_src_compile() {
	if multilib_is_native_abi; then
		default
	else
		# build libraries only
		emake -f Makefile -f - mylibs \
			<<< 'mylibs: $(usrlib_exec_LTLIBRARIES) $(pkgconfig_DATA)'
	fi
}

multilib_src_test() {
	multilib_is_native_abi && emake check
}

multilib_src_install() {
	if multilib_is_native_abi; then
		default
	else
		emake DESTDIR="${D}" install-usrlib_execLTLIBRARIES \
			install-pkgconfigDATA install-uuidincHEADERS \
			install-nodist_blkidincHEADERS install-nodist_mountincHEADERS \
			install-nodist_smartcolsincHEADERS install-nodist_fdiskincHEADERS
	fi

	if multilib_is_native_abi; then
		use python && python_optimize
	fi
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die

	if use pam; then
		newpamd "${FILESDIR}/runuser.pamd" runuser
		newpamd "${FILESDIR}/runuser-l.pamd" runuser-l
	fi
}
