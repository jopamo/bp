# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="release/$(ver_cut 1-2)/master"

inherit flag-o-matic

DESCRIPTION="GNU libc C library"
HOMEPAGE="https://www.gnu.org/software/libc/"

SNAPSHOT=c8e10f14328518954072df64aafd574e67cfdde5
SRC_URI="https://github.com/1g4-mirror/glibc/archive/${SNAPSHOT}.tar.gz -> glibc-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/glibc-${SNAPSHOT}

LICENSE="LGPL-2.1+ BSD HPND ISC inner-net rc PCRE"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps debug nscd profile systemd static-libs +static-pie tmpfilesd"

BDEPEND="
	app-build/make
"
DEPEND="
	app-build/gcc
	app-kernel/linux-headers
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

	cd "${WORKDIR}"
	find . -name configure -exec touch {} +

	# Fix permissions on some of the scripts.
	chmod u+x "${S}"/scripts/*.sh

	#sed -i 's/\-Wl,\-z,defs\ //' "${S}"/elf/Makefile || die
	#cp "${FILESDIR}"/setuid.c "${S}"/sysdeps/unix/sysv/linux/ || die
	#cp "${FILESDIR}"/libc-start.c "${S}"/csu/ || die
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

	export libc_cv_rootsbindir="${EPREFIX}"/usr/bin
	export libc_cv_slibdir="${EPREFIX}"/usr/lib
	export libc_cv_hashstyle=no

	mkdir -p "${WORKDIR}/build"
	cd "${WORKDIR}/build"
	set -- "${S}"/configure "${myconf[@]}"
	echo "$@"
	"$@" || die "failed to configure glibc"
}

src_compile() {
	emake -C "${WORKDIR}/build"
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

		if use tmpfilesd; then
			insopts -m 0644
			insinto /usr/lib/tmpfiles.d
			newins nscd/nscd.tmpfiles nscd.conf
		fi
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

	mv "${ED}"/bin/{ldconfig,sln} "${ED}"/usr/bin && rm -rf "${ED}"/bin

	cleanup_install

	echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" > "${ED}"/usr/share/i18n/locales/SUPPORTED

	dodir /usr/lib/locale

	use debug && dostrip -x /usr/lib/ld-linux-x86-64.so.2
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
		# Generate fastloading iconv module configuration file.
		"${EROOT}"/usr/bin/iconvconfig --prefix="${ROOT}"
	fi

	if [[ ${ROOT} == "/" ]] ; then
		# Reload init ... if in a chroot or a diff init package, ignore
		# errors from this step #253697
		/usr/bin/telinit U 2>/dev/null
	fi

	"${EROOT}"/usr/bin/locale-gen
}
