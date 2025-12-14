# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="release/$(ver_cut 1-2)/master"

inherit flag-o-matic doins

DESCRIPTION="GNU libc C library"
HOMEPAGE="https://www.gnu.org/software/libc/"
SNAPSHOT=4bfd05e2b8f69a1178272c60c17961a61e4e09b3
SRC_URI="https://github.com/1g4-mirror/glibc/archive/${SNAPSHOT}.tar.gz -> glibc-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/glibc-${SNAPSHOT}

LICENSE="LGPL-2.1+ BSD HPND ISC inner-net rc PCRE"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps debug nscd profile systemd static-libs static-pie"

BDEPEND="
	app-build/make
"
DEPEND="
	app-build/gcc
	virtual/linux-sources
	app-core/layout
"
RDEPEND="
	caps? ( lib-core/libcap )
"
PDEPEND="lib-core/tzdb"

PATCHES=(
	"${FILESDIR}"/0001-Disable-ldconfig-during-install.patch
)

check_devpts() {
	# Make sure devpts is mounted correctly for use w/out setuid pt_chown.

	# If merely building the binary package, then there's nothing to verify.
	[[ ${MERGE_TYPE} == "buildonly" ]] && return

	# Only sanity check when installing the native glibc.
	[[ ${ROOT} != "/" ]] && return

	if awk '$3 == "devpts" && $4 ~ /[, ]gid=5[, ]/ { exit 1 }' /proc/mounts ; then
		die "mount & fix your /dev/pts settings"
	fi
}

pkg_pretend() {
	# Make sure devpts is mounted correctly for use w/out setuid pt_chown
	check_devpts

	# Prevent native builds from downgrading
	if [[ ${MERGE_TYPE} != "buildonly" ]] && \
	   [[ ${ROOT} == "/" ]] ; then
		if has_version ">${CATEGORY}/${P}-r10000" ; then
			eerror "Sanity check to keep you from breaking your system:"
			eerror " Downgrading glibc is not a good idea."
			die
		fi

		if ! glibc_run_test '#include <pwd.h>\nint main(){return getpwuid(0)==0;}\n'
		then
			eerror "Your patched vendor kernel is broken."
			die
		fi

		if ! glibc_run_test '#include <unistd.h>\n#include <sys/syscall.h>\nint main(){return syscall(1000)!=-1;}\n'
		then
			eerror "Your old kernel is broken.  You need to update it to"
			eerror "a newer version as syscall(<bignum>) will break."
			die
		fi
	fi

	# Check for sanity of /etc/nsswitch.conf
	if [[ -e ${EROOT}/etc/nsswitch.conf ]] ; then
		local entry
		for entry in passwd group shadow; do
			if ! egrep -q "^[ \t]*${entry}:.*files" "${EROOT}"/etc/nsswitch.conf; then
				eerror "Your ${EROOT}/etc/nsswitch.conf is out of date."
				eerror "Please make sure you have 'files' entries for"
				eerror "'passwd:', 'group:' and 'shadow:' databases."
				die "nsswitch.conf has no 'files' provider in '${entry}'."
			fi
		done
	fi
}

src_prepare() {
	default

	chmod u+x "${S}"/scripts/*.sh || die

	local f

	# amd64 64-bit ABI
	f="${S}/sysdeps/unix/sysv/linux/x86_64/64/configure"
	if [[ -f ${f} ]]; then
		sed -i \
			-e "s|libc_cv_slibdir='/lib64'|libc_cv_slibdir='/usr/lib'|g" \
			-e "s|libc_cv_rtlddir='/lib64'|libc_cv_rtlddir='/usr/lib'|g" \
			"${f}" || die
	fi

	# amd64 x32 ABI fragment exists in tree and can leak into ldd RTLDLIST
	f="${S}/sysdeps/unix/sysv/linux/x86_64/x32/configure"
	if [[ -f ${f} ]]; then
		sed -i \
			-e "s|libc_cv_slibdir='/libx32'|libc_cv_slibdir='/usr/lib'|g" \
			-e "s|libc_cv_rtlddir='/libx32'|libc_cv_rtlddir='/usr/lib'|g" \
			"${f}" || die
	fi

	# arm64
	f="${S}/sysdeps/unix/sysv/linux/aarch64/configure"
	if [[ -f ${f} ]]; then
		sed -i \
			-e "s|libc_cv_slibdir='/lib64'|libc_cv_slibdir='/usr/lib'|g" \
			-e "s|libc_cv_rtlddir='/lib'|libc_cv_rtlddir='/usr/lib'|g" \
			"${f}" || die
	fi

	# sanity checks
	grep -nE "libc_cv_(s|rt)libdir='/(lib64|lib)'" \
		"${S}/sysdeps/unix/sysv/linux/x86_64/64/configure" && die "x86_64/64 still uses /lib or /lib64"

	grep -nE "libc_cv_(s|rt)libdir='/libx32'" \
		"${S}/sysdeps/unix/sysv/linux/x86_64/x32/configure" && die "x86_64/x32 still uses /libx32"

	grep -nE "libc_cv_(s|rt)libdir='/(lib64|lib)'" \
		"${S}/sysdeps/unix/sysv/linux/aarch64/configure" && die "aarch64 still uses /lib or /lib64"
}

src_configure() {
	replace-flags -O0 -O1
	filter-flags -flto*
	filter-flags -D_FORTIFY_SOURCE*
	filter-flags -Wl,-z,defs
	filter-flags -fstack-protector-strong
	filter-flags -fassociative-math
	filter-flags -fno-semantic-interposition
	filter-flags -Wl,--gc-sections

	use debug && append-flags -fno-builtin-strlen

	export MAKEINFO=/dev/null

	myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--build=${CBUILD_OPT:-${CBUILD}}
		--disable-crypt
		--disable-timezone-tools
		--disable-werror
		--enable-add-ons
		--enable-bind-now
	    --enable-kernel=4.4
        --enable-multi-arch
		--enable-stack-protector=strong
		--enable-stackguard-randomization
		--host=${CTARGET_OPT:-${CTARGET}}
		--infodir="${EPREFIX}"/usr/share/info
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--localstatedir="${EPREFIX}"/var
		--mandir="${EPREFIX}"/usr/share/man
		--prefix="${EPREFIX}"/usr
		--sbindir="${EPREFIX}"/usr/bin
		--sysconfdir="${EPREFIX}"/etc
		--without-cvs
		--without-selinux
		$(in_iuse nscd && use_enable nscd)
		$(use_enable profile)
		$(use_enable static-pie)
	)

	ac_cv_lib_cap_cap_init=$(in_iuse caps && usex caps || echo no)

	export libc_cv_rootsbindir=/usr/bin
	export libc_cv_slibdir=/usr/lib
	export libc_cv_rtlddir=/usr/lib
	export libc_cv_hashstyle=no

	mkdir -p "${WORKDIR}/build"
	cd "${WORKDIR}/build" || die

cat > configparms <<'EOF'
slibdir=/usr/lib
rtlddir=/usr/lib
sbindir=/usr/bin
rootsbindir=/usr/bin
EOF

	set -- "${S}"/configure "${myconf[@]}"
	echo "$@"
	"$@" || die "failed to configure glibc"
}

src_compile() {
	cd "${WORKDIR}/build"
	emake

	if grep -q "/usr/lib64" elf/ldd.bash ; then
		grep -n "RTLDLIST" elf/ldd.bash || true
		die "build produced ldd with /usr/lib64 in RTLDLIST"
	fi
}

src_test() {
	# Give tests more time to complete.
	export TIMEOUTFACTOR=5

	cd "${WORKDIR}/build"
	emake check
}

src_install() {
	cd "${WORKDIR}/build"

	emake install_root="${ED}" install || die

	# We'll take care of the cache ourselves
	rm -f "${ED}"/etc/ld.so.cache

	find "${ED}" -name pt_chown -exec chmod -s {} +

	#################################################################
	# EVERYTHING AFTER THIS POINT IS FOR NATIVE GLIBC INSTALLS ONLY #

	# Files for Debian-style locale updating
	dodir /usr/share/i18n
	sed \
		-e "/^#/d" \
		-e "/SUPPORTED-LOCALES=/d" \
		-e "s: \\\\::g" -e "s:/: :g" \
		"${S}"/localedata/SUPPORTED > "${ED}"/usr/share/i18n/SUPPORTED \
		|| die "generating /usr/share/i18n/SUPPORTED failed"

	cd "${S}"

	# Install misc network config files
	insinto /etc
	doins nscd/nscd.conf posix/gai.conf nss/nsswitch.conf

	if use nscd ; then
		local nscd_args=(
			-e "s:@PIDFILE@:$(strings "${ED}"/usr/bin/nscd | grep nscd.pid):"
		)

		sed -i "${nscd_args[@]}" "${ED}"/etc/init.d/nscd

		if use systemd; then
			insinto /usr/lib/systemd/system
			insopts -m 0644
			doins nscd/nscd.service
		fi

		newtmpfiles nscd/nscd.tmpfiles nscd.conf
	fi

	echo 'LDPATH="include ld.so.conf.d/*.conf"' > "${T}"/00glibc
	doenvd "${T}"/00glibc

	# Prevent overwriting of the /etc/localtime symlink.  We'll handle the
	# creation of the "factory" symlink in pkg_postinst().
	rm -f "${ED}"/etc/localtime

	# locale-gen install
	insinto /usr/bin && doins "${FILESDIR}/locale-gen/locale-gen"
	insinto /etc/ && doins "${FILESDIR}/locale-gen/locale.gen"

	fperms +x /usr/bin/locale-gen

	cleanup_install

	echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > "${ED}"/usr/share/i18n/locales/SUPPORTED

	dodir /usr/lib/locale

	use debug && dostrip -x /usr/lib/ld-linux-x86-64.so.2

	insinto /etc
	doins "${FILESDIR}"/nsswitch.conf
}

pkg_preinst() {
	# prepare /etc/ld.so.conf.d/ for files
	mkdir -p "${EROOT}"/etc/ld.so.conf.d

	[[ ${ROOT} != "/" ]] && return 0
	[[ -d ${ED}/usr/lib ]] || return 0
	[[ -z ${BOOTSTRAP_RAP} ]] && glibc_sanity_check
}

pkg_postinst() {
	if [[ -x ${EROOT}/usr/bin/iconvconfig ]] ; then
		"${EROOT}"/usr/bin/iconvconfig --prefix="${ROOT}"
	fi

	if [[ ${ROOT} == "/" ]] ; then
		# keep /usr/lib as the only real lib directory
		ln -sfn usr/lib "${EROOT}"/lib
		ln -sfn usr/lib "${EROOT}"/lib64

		# if you ever created /usr/lib64 previously, kill it
		if [[ -d ${EROOT}/usr/lib64 && ! -L ${EROOT}/usr/lib64 ]] ; then
			rm -rf "${EROOT}"/usr/lib64 || die
		fi
		if [[ -L ${EROOT}/usr/lib64 ]] ; then
			rm -f "${EROOT}"/usr/lib64 || die
		fi

		/usr/bin/telinit U 2>/dev/null
	fi

	"${EROOT}"/usr/bin/locale-gen
}

