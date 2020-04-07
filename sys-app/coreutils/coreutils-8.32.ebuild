# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic python-any-r1 toolchain-funcs

DESCRIPTION="Standard GNU utilities (chmod, cp, dd, ls, sort, tr, head, wc, who,...)"
HOMEPAGE="https://www.gnu.org/software/coreutils/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl caps gmp multicall nls static test xattr"

LIB_DEPEND="acl? ( sys-app/acl[static-libs] )
	caps? ( lib-sys/libcap )
	gmp? ( lib-dev/gmp:=[static-libs] )
	xattr? ( sys-app/attr[static-libs] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs]} )
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	app-compression/xz-utils
	test? (
		dev-lang/perl
		dev-util/strace
		${PYTHON_DEPS}
		$(python_gen_any_dep 'dev-python/pyinotify[${PYTHON_USEDEP}]')
	)"

append-flags -fno-strict-aliasing

pkg_setup() {
	if use test ; then
		python-any-r1_pkg_setup
	fi
}

src_configure() {
	export ac_cv_{header_selinux_{context,flash,selinux}_h,search_setfilecon}=no

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-no-install-program="groups,kill,su,uptime"
		--enable-install-program=hostname
		--enable-largefile
		$(use caps || echo --disable-libcap)
		$(use_enable nls)
		$(use_enable acl)
		$(use_enable multicall single-binary)
		$(use_enable xattr)
		$(use_with gmp)
	)
	if tc-is-cross-compiler && [[ ${CHOST} == *linux* ]] ; then
		export fu_cv_sys_stat_statfs2_bsize=yes #311569
		export gl_cv_func_realpath_works=yes #416629
	fi

	export gl_cv_func_mknod_works=yes #409919
	use static && append-ldflags -static && sed -i '/elf_sys=yes/s:yes:no:' configure #321821

	econf "${myconf[@]}"
}

src_test() {
	# Known to fail with FEATURES=usersandbox (bug #439574):
	#   -  tests/du/long-from-unreadable.sh} (bug #413621)
	#   -  tests/rm/deep-2.sh (bug #413621)
	#   -  tests/dd/no-allocate.sh (bug #629660)
	if has usersandbox $FEATURES ; then
		ewarn "You are emerging ${P} with 'usersandbox' enabled." \
			"Expect some test failures or emerge with 'FEATURES=-usersandbox'!"
	fi

	# Non-root tests will fail if the full path isn't
	# accessible to non-root users
	chmod -R go-w "${WORKDIR}"
	chmod a+rx "${WORKDIR}"

	# coreutils tests like to do `mount` and such with temp dirs
	# so make sure /etc/mtab is writable #265725
	# make sure /dev/loop* can be mounted #269758
	mkdir -p "${T}"/mount-wrappers
	mkwrap() {
		local w ww
		for w in "$@" ; do
			ww="${T}/mount-wrappers/${w}"
			cat <<-EOF > "${ww}"
				#!${EPREFIX}/bin/sh
				exec env SANDBOX_WRITE="\${SANDBOX_WRITE}:/etc/mtab:/dev/loop" $(type -P $w) "\$@"
			EOF
			chmod a+rx "${ww}"
		done
	}
	mkwrap mount umount

	addwrite /dev/full
	env PATH="${T}/mount-wrappers:${PATH}" \
	emake -j1 -k check
}

src_install() {
	default

	insinto /etc
	doins ${FILESDIR}/DIR_COLORS

	rm -rf "${ED%/}"/usr/share/man
}

