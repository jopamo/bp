# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit toolchain-funcs libtool flag-o-matic  \
	pam python-single-r1 systemd autotools

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git"
else
	SNAPSHOT=65bcbf105bfc5f6510b8df8db09d9458f942c799
	SRC_URI="https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/snapshot/util-linux-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/util-linux/"

LICENSE="GPL-2 LGPL-2.1 BSD-4 MIT public-domain"
SLOT="0"
IUSE="build caps +cramfs fdformat kill ncurses nls pam python +readline static-libs +suid systemd test +tty-helpers udev unicode"

RDEPEND="caps? ( lib-sys/libcap-ng )
	cramfs? ( lib-sys/zlib )
	ncurses? ( >=lib-sys/ncurses-5.2-r2:0= )
	pam? ( lib-sys/pam )
	python? ( ${PYTHON_DEPS} )
	readline? ( lib-sys/readline:0= )
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

src_configure() {
	lfs_fallocate_test
	# The scanf test in a run-time test which fails while cross-compiling.
	# Blindly assume a POSIX setup since we require libmount, and libmount
	# itself fails when the scanf test fails. #531856
	tc-is-cross-compiler && export scanf_cv_alloc_modifier=ms
	export ac_cv_header_security_pam_misc_h=$(usex pam) #485486
	export ac_cv_header_security_pam_appl_h=$(usex pam) #545042

	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
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
		--with-systemdsystemunitdir=$(usex systemd "$(systemd_get_systemunitdir)" "no")
		$(use_enable caps setpriv)
		$(use_enable cramfs)
		$(use_enable fdformat)
		$(use_enable nls)
		$(use_enable suid makeinstall-chown)
		$(use_enable suid makeinstall-setuid)
		$(use_enable tty-helpers mesg)
		$(use_enable tty-helpers wall)
		$(use_enable tty-helpers write)
		$(use_with python)
		$(use_with readline)
		$(use_with systemd)
		$(use_with udev)
		$(usex ncurses "$(use_with unicode ncursesw)" '--without-ncursesw')
		$(usex ncurses "$(use_with !unicode ncurses)" '--without-ncurses')
		$(tc-has-tls || echo --disable-tls)
		$(use_enable unicode widechar)
		$(use_enable kill)
		$(use_enable static-libs static)
		$(usex ncurses '' '--without-tinfo')
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_test() {
	emake check
}

src_install() {
	default

	use python && python_optimize

	find "${ED}" -name "*.la" -delete || die

	if use pam; then
		newpamd "${FILESDIR}/runuser.pamd" runuser
		newpamd "${FILESDIR}/runuser-l.pamd" runuser-l
	fi
}
