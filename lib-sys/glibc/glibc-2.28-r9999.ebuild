# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit prefix toolchain-glibc git-r3 flag-o-matic

DESCRIPTION="GNU libc C library"
HOMEPAGE="https://www.gnu.org/software/libc/"

LICENSE="LGPL-2.1+ BSD HPND ISC inner-net rc PCRE"
RESTRICT="strip" # Strip ourself #46186
EMULTILIB_PKG="true"

EGIT_REPO_URI="git://sourceware.org/git/glibc.git"
EGIT_BRANCH="release/2.28/master"

KEYWORDS="amd64 arm64 x86"

RELEASE_VER=${PV}

GCC_BOOTSTRAP_VER="4.7.3-r1"

SRC_URI+=" multilib? ( mirror://gentoo/gcc-${GCC_BOOTSTRAP_VER}-multilib-bootstrap.tar.bz2 )"

IUSE="audit caps debug doc gd hardened multilib nscd selinux systemtap profile suid vanilla headers-only"


export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY} == cross-* ]] ; then
		export CTARGET=${CATEGORY#cross-}
	fi
fi

is_crosscompile() {
	[[ ${CHOST} != ${CTARGET} ]]
}

SLOT="2.2"

# General: We need a new-enough binutils/gcc to match upstream baseline.
# arch: we need to make sure our binutils/gcc supports TLS.
COMMON_DEPEND="
	nscd? ( selinux? (
		audit? ( sys-app/audit )
		caps? ( lib-sys/libcap )
	) )
	suid? ( caps? ( lib-sys/libcap ) )
	selinux? ( lib-sys/libselinux )
	systemtap? ( dev-util/systemtap )
"
DEPEND="${COMMON_DEPEND}
	!<sys-app/sandbox-1.6
	!<sys-app/portage-2.1.2
	doc? ( sys-app/texinfo )
"
RDEPEND="${COMMON_DEPEND}
	!sys-app/ps3-sources
	sys-app/gentoo-functions
	!lib-sys/nss-db
"

if [[ ${CATEGORY} == cross-* ]] ; then
	DEPEND+=" !headers-only? (
		>=${CATEGORY}/binutils-2.24
		>=${CATEGORY}/gcc-4.9
	)"
	[[ ${CATEGORY} == *-linux* ]] && DEPEND+=" ${CATEGORY}/stable-sources"
else
	DEPEND+="
		>=sys-devel/binutils-2.24
		>=sys-devel/gcc-4.9
		sys-kernel/stable-sources
	"
	RDEPEND+=" vanilla? ( !lib-sys/timezone-data )"
	PDEPEND+=" !vanilla? ( lib-sys/timezone-data )"
fi

pkg_pretend() {
	# Make sure devpts is mounted correctly for use w/out setuid pt_chown
	check_devpts

	# Prevent native builds from downgrading
	if [[ ${MERGE_TYPE} != "buildonly" ]] && \
	   [[ ${ROOT} == "/" ]] && \
	   [[ ${CBUILD} == ${CHOST} ]] && \
	   [[ ${CHOST} == ${CTARGET} ]] ; then
		# The high rev # is to allow people to downgrade between -r# versions.
		# We want to block 2.20->2.19, but 2.20-r3->2.20-r2 should be fine.
		# Hopefully we never actually use a r# this high.
		if has_version ">${CATEGORY}/${P}-r10000" ; then
			eerror "Sanity check to keep you from breaking your system:"
			eerror " Downgrading glibc is not supported and a sure way to destruction"
			die "Aborting to save your system"
		fi

		if ! glibc_run_test '#include <pwd.h>\nint main(){return getpwuid(0)==0;}\n'
		then
			eerror "Your patched vendor kernel is broken.  You need to get an"
			eerror "update from whoever is providing the kernel to you."
			eerror "https://sourceware.org/bugzilla/show_bug.cgi?id=5227"
			eerror "https://bugs.gentoo.org/262698"
			die "Keeping your system alive, say thank you"
		fi

		if ! glibc_run_test '#include <unistd.h>\n#include <sys/syscall.h>\nint main(){return syscall(1000)!=-1;}\n'
		then
			eerror "Your old kernel is broken.  You need to update it to"
			eerror "a newer version as syscall(<bignum>) will break."
			eerror "https://bugs.gentoo.org/279260"
			die "Keeping your system alive, say thank you"
		fi
	fi

	# Users have had a chance to phase themselves, time to give em the boot
	if [[ -e ${EROOT}/etc/locale.gen ]] && [[ -e ${EROOT}/etc/locales.build ]] ; then
		eerror "You still haven't deleted ${EROOT}/etc/locales.build."
		eerror "Do so now after making sure ${EROOT}/etc/locale.gen is kosher."
		die "Lazy upgrader detected"
	fi

	if [[ ${CTARGET} == i386-* ]] ; then
		eerror "i386 CHOSTs are no longer supported."
		eerror "Chances are you don't actually want/need i386."
		eerror "Please read https://www.gentoo.org/doc/en/change-chost.xml"
		die "Please fix your CHOST"
	fi

	if [[ -e /proc/xen ]] && [[ $(tc-arch) == "x86" ]] && ! is-flag -mno-tls-direct-seg-refs ; then
		ewarn "You are using Xen but don't have -mno-tls-direct-seg-refs in your CFLAGS."
		ewarn "This will result in a 50% performance penalty when running with a 32bit"
		ewarn "hypervisor, which is probably not what you want."
	fi

	# Make sure host system is up to date #394453
	if has_version '<lib-sys/glibc-2.13' && \
	   [[ -n $(scanelf -qys__guard -F'#s%F' "${EROOT}"/lib*/l*-*.so) ]]
	then
		ebegin "Scanning system for __guard to see if you need to rebuild first ..."
		local files=$(
			scanelf -qys__guard -F'#s%F' \
				"${EROOT}"/*bin/ \
				"${EROOT}"/lib* \
				"${EROOT}"/usr/*bin/ \
				"${EROOT}"/usr/lib* | \
				egrep -v \
					-e "^${EROOT}/lib.*/(libc|ld)-2.*.so$" \
					-e "^${EROOT}/usr/sbin/(ldconfig|sln)$"
		)
		[[ -z ${files} ]]
		if ! eend $? ; then
			eerror "Your system still has old SSP __guard symbols.  You need to"
			eerror "rebuild all the packages that provide these files first:"
			eerror "${files}"
			die "old __guard detected"
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
				eerror "For more details see:"
				eerror "  https://wiki.gentoo.org/wiki/Project:Toolchain/nsswitch.conf_in_glibc-2.26"
				die "nsswitch.conf has no 'files' provider in '${entry}'."
			fi
		done
	fi
}

src_unpack() {
	use multilib && unpack gcc-${GCC_BOOTSTRAP_VER}-multilib-bootstrap.tar.bz2

	setup_env

	# Check NPTL support _before_ we unpack things to save some time
	check_nptl_support

	if [[ -n ${EGIT_REPO_URI} ]] ; then
		git-r3_src_unpack
	else
		unpack ${P}.tar.xz
	fi

	cd "${S}"
	touch locale/C-translit.h #185476 #218003
}

src_prepare() {
	if just_headers ; then
		if [[ -e ports/sysdeps/mips/preconfigure ]] ; then
			# mips peeps like to screw with us.  if building headers,
			# we don't have a real compiler, so we can't let them
			# insert -mabi on us.
			sed -i '/CPPFLAGS=.*-mabi/s|.*|:|' ports/sysdeps/mips/preconfigure || die
			find ports/sysdeps/mips/ -name Makefile -exec sed -i '/^CC.*-mabi=/s:-mabi=.*:-D_MIPS_SZPTR=32:' {} +
		fi
	fi

	default

	gnuconfig_update

	cd "${WORKDIR}"
	find . -name configure -exec touch {} +

	# Fix permissions on some of the scripts.
	chmod u+x "${S}"/scripts/*.sh
	filter-ldflags "${CFLAGS}"
}

glibc_do_configure() {
	# Glibc does not work with gold (for various reasons) #269274.
	tc-ld-disable-gold

	# CXX isnt handled by the multilib system, so if we dont unset here
	# we accumulate crap across abis
	unset CXX

	einfo "Configuring glibc for $1"

	if use doc ; then
		export MAKEINFO=makeinfo
	else
		export MAKEINFO=/dev/null
	fi

	local v
	for v in ABI CBUILD CHOST CTARGET CBUILD_OPT CTARGET_OPT CC CXX LD {AS,C,CPP,CXX,LD}FLAGS MAKEINFO ; do
		einfo " $(printf '%15s' ${v}:)   ${!v}"
	done

	# The glibc configure script doesn't properly use LDFLAGS all the time.
	export CC="$(tc-getCC ${CTARGET}) ${LDFLAGS}"
	einfo " $(printf '%15s' 'Manual CC:')   ${CC}"

	# Some of the tests are written in C++, so we need to force our multlib abis in, bug 623548
	export CXX="$(tc-getCXX ${CTARGET}) $(get_abi_CFLAGS)"
	einfo " $(printf '%15s' 'Manual CXX:')   ${CXX}"


	# Since SELinux support is only required for nscd, only enable it if:
	# 1. USE selinux
	# 2. only for the primary ABI on multilib systems
	# 3. Not a crosscompile
	if ! is_crosscompile && use selinux ; then
		if use multilib ; then
			if is_final_abi ; then
				myconf+=( --with-selinux )
			else
				myconf+=( --without-selinux )
			fi
		else
			myconf+=( --with-selinux )
		fi
	else
		myconf+=( --without-selinux )
	fi

	# Force a few tests where we always know the answer but
	# configure is incapable of finding it.
	if is_crosscompile ; then
		export \
			libc_cv_c_cleanup=yes \
			libc_cv_forced_unwind=yes
	fi

	myconf+=(
		--without-cvs
		--disable-werror
		--enable-bind-now
		--enable-add-ons
		--enable-stack-protector=strong
		--enable-stackguard-randomization
		--build=${CBUILD_OPT:-${CBUILD}}
		--host=${CTARGET_OPT:-${CTARGET}}
		$(use_enable profile)
		$(use_with gd)
		--with-headers=$(alt_build_headers)
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--mandir="${EPREFIX}"/usr/share/man
		--infodir="${EPREFIX}"/usr/share/info
		$(in_iuse systemtap && use_enable systemtap)
		$(in_iuse nscd && use_enable nscd)
		${EXTRA_ECONF}
	)

	# We rely on lib-sys/timezone-data for timezone tools normally.
	myconf+=( $(use_enable vanilla timezone-tools) )

	ac_cv_lib_audit_audit_log_user_avc_message=$(in_iuse audit && usex audit || echo no)
	ac_cv_lib_cap_cap_init=$(in_iuse caps && usex caps || echo no)

	export libc_cv_rootsbindir="${EPREFIX}"/usr/sbin
	export libc_cv_slibdir="${EPREFIX}"/usr/$(get_libdir)
	export libc_cv_hashstyle=no

	local builddir=$(builddir "$1")
	mkdir -p "${builddir}"
	cd "${builddir}"
	set -- "${S}"/configure "${myconf[@]}"
	echo "$@"
	"$@" || die "failed to configure glibc"

	# If we're trying to migrate between ABI sets, we need
	# to lie and use a local copy of gcc.  Like if the system
	# is built with MULTILIB_ABIS="amd64 x86" but we want to
	# add x32 to it, gcc/glibc don't yet support x32.
	if [[ -n ${GCC_BOOTSTRAP_VER} ]] && use multilib ; then
		echo 'main(){}' > "${T}"/test.c
		if ! $(tc-getCC ${CTARGET}) ${CFLAGS} ${LDFLAGS} "${T}"/test.c -Wl,-emain -lgcc 2>/dev/null ; then
			sed -i -e '/^CC = /s:$: -B$(objdir)/../'"gcc-${GCC_BOOTSTRAP_VER}/${ABI}:" config.make || die
		fi
	fi
}

glibc_headers_configure() {
	export ABI=default

	local builddir=$(builddir "headers")
	mkdir -p "${builddir}"
	cd "${builddir}"

	# if we don't have a compiler yet, we can't really test it now ...
	# hopefully they don't affect header generation, so let's hope for
	# the best here ...
	local v vars=(
		ac_cv_header_cpuid_h=yes
		libc_cv_{386,390,alpha,arm,hppa,ia64,mips,{powerpc,sparc}{,32,64},sh,x86_64}_tls=yes
		libc_cv_asm_cfi_directives=yes
		libc_cv_broken_visibility_attribute=no
		libc_cv_c_cleanup=yes
		libc_cv_forced_unwind=yes
		libc_cv_gcc___thread=yes
		libc_cv_mlong_double_128=yes
		libc_cv_mlong_double_128ibm=yes
		libc_cv_ppc_machine=yes
		libc_cv_ppc_rel16=yes
		libc_cv_predef_fortify_source=no
		libc_cv_visibility_attribute=yes
		libc_cv_z_combreloc=yes
		libc_cv_z_execstack=yes
		libc_cv_z_initfirst=yes
		libc_cv_z_nodelete=yes
		libc_cv_z_nodlopen=yes
		libc_cv_z_relro=yes
		libc_mips_abi=${ABI}
		libc_mips_float=$([[ $(tc-is-softfloat) == "yes" ]] && echo soft || echo hard)
		# These libs don't have configure flags.
		ac_cv_lib_audit_audit_log_user_avc_message=no
		ac_cv_lib_cap_cap_init=no
	)

	einfo "Forcing cached settings:"
	for v in "${vars[@]}" ; do
		einfo " ${v}"
		export ${v}
	done

	# Blow away some random CC settings that screw things up. #550192
	if [[ -d ${S}/sysdeps/mips ]]; then
		pushd "${S}"/sysdeps/mips >/dev/null
		sed -i -e '/^CC +=/s:=.*:= -D_MIPS_SZPTR=32:' mips32/Makefile mips64/n32/Makefile || die
		sed -i -e '/^CC +=/s:=.*:= -D_MIPS_SZPTR=64:' mips64/n64/Makefile || die

		# Force the mips ABI to the default.  This is OK because the set of
		# installed headers in this phase is the same between the 3 ABIs.
		# If this ever changes, this hack will break, but that's unlikely
		# as glibc discourages that behavior.
		# https://crbug.com/647033
		sed -i -e 's:abiflag=.*:abiflag=_ABIO32:' preconfigure || die

		popd >/dev/null
	fi

	local myconf=()
	myconf+=(
		--disable-werror
		--disable-profile
		--build=${CBUILD_OPT:-${CBUILD}}
		--host=${CTARGET_OPT:-${CTARGET}}
		--with-headers=$(alt_build_headers)
		--prefix="${EPREFIX}/usr"
		${EXTRA_ECONF}
	)

	# Nothing is compiled here which would affect the headers for the target.
	# So forcing CC/CFLAGS is sane.
	local headers_only_CC=$(tc-getBUILD_CC)
	local headers_only_CFLAGS="-O1 -pipe"
	local headers_only_CPPFLAGS="-U_FORTIFY_SOURCE"
	local headers_only_LDFLAGS=""
	set -- "${S}"/configure "${myconf[@]}"
	echo \
		"CC=${headers_only_CC}" \
		"CFLAGS=${headers_only_CFLAGS}" \
		"CPPFLAGS=${headers_only_CPPFLAGS}" \
		"LDFLAGS=${headers_only_LDFLAGS}" \
		"$@"
	CC=${headers_only_CC} \
	CFLAGS=${headers_only_CFLAGS} \
	CPPFLAGS=${headers_only_CPPFLAGS} \
	LDFLAGS="" \
	"$@" || die "failed to configure glibc"
}

do_src_configure() {
	if just_headers ; then
		glibc_headers_configure
	else
		glibc_do_configure nptl
	fi
}

src_configure() {
	foreach_abi do_src_configure
}

do_src_compile() {
	emake -C "$(builddir nptl)" || die "make nptl for ${ABI} failed"
}

src_compile() {
	if just_headers ; then
		return
	fi

	foreach_abi do_src_compile
}

glibc_src_test() {
	cd "$(builddir $1)"
	emake check
}

do_src_test() {
	local ret=0

	glibc_src_test nptl
	: $(( ret |= $? ))

	return ${ret}
}

src_test() {
	if just_headers ; then
		return
	fi
	# Give tests more time to complete.
	export TIMEOUTFACTOR=5

	foreach_abi do_src_test || die "tests failed"
}

glibc_do_src_install() {
	local builddir=$(builddir nptl)
	cd "${builddir}"

	emake install_root="${D}$(alt_prefix)" install || die

	# Normally upstream_pv is ${PV}. Live ebuilds are exception, there we need
	# to infer upstream version:
	# '#define VERSION "2.26.90"' -> '2.26.90'
	local upstream_pv=$(sed -n -r 's/#define VERSION "(.*)"/\1/p' "${S}"/version.h)

	if [[ -e ${ED}$(alt_usrlibdir)/libm-${upstream_pv}.a ]] ; then
		# Move versioned .a file out of libdir to evade portage QA checks
		# instead of using gen_usr_ldscript(). We fix ldscript as:
		# "GROUP ( /usr/lib64/libm-<pv>.a ..." -> "GROUP ( /usr/lib64/glibc-<pv>/libm-<pv>.a ..."
		sed -i "s@\(libm-${upstream_pv}.a\)@${P}/\1@" "${ED}"$(alt_usrlibdir)/libm.a || die
		dodir $(alt_usrlibdir)/${P}
		mv "${ED}"$(alt_usrlibdir)/libm-${upstream_pv}.a "${ED}"$(alt_usrlibdir)/${P}/libm-${upstream_pv}.a || die
	fi

	# We'll take care of the cache ourselves
	rm -f "${ED}"/etc/ld.so.cache

	# Everything past this point just needs to be done once ...
	is_final_abi || return 0

	# Make sure the non-native interp can be found on multilib systems even
	# if the main library set isn't installed into the right place.  Maybe
	# we should query the active gcc for info instead of hardcoding it ?
	local i ldso_abi ldso_name
	local ldso_abi_list=(
		# x86
		amd64   /usr/lib64/ld-linux-x86-64.so.2
		x32     /usr/libx32/ld-linux-x32.so.2
		x86     /usr/lib/ld-linux.so.2
	)
	case $(tc-endian) in
	little)
		ldso_abi_list+=(
			# arm
			arm64   /usr/lib64/ld-linux-aarch64.so.1
		)
		;;
	big)
		ldso_abi_list+=(
			# arm
			arm64   /usr/lib64/ld-linux-aarch64_be.so.1
		)
		;;
	esac

	for (( i = 0; i < ${#ldso_abi_list[@]}; i += 2 )) ; do
		ldso_abi=${ldso_abi_list[i]}
		has ${ldso_abi} $(get_install_abis) || continue

		ldso_name="$(alt_prefix)${ldso_abi_list[i+1]}"
		if [[ ! -L ${ED}/${ldso_name} && ! -e ${ED}/${ldso_name} ]] ; then
			dosym ../$(get_abi_LIBDIR ${ldso_abi})/${ldso_name##*/} ${ldso_name}
		fi
	done

	# With devpts under Linux mounted properly, we do not need the pt_chown
	# binary to be setuid.  This is because the default owners/perms will be
	# exactly what we want.
	if in_iuse suid && ! use suid ; then
		find "${ED}" -name pt_chown -exec chmod -s {} +
	fi

	#################################################################
	# EVERYTHING AFTER THIS POINT IS FOR NATIVE GLIBC INSTALLS ONLY #
	# Make sure we install some symlink hacks so that when we build
	# a 2nd stage cross-compiler, gcc finds the target system
	# headers correctly.  See gcc/doc/gccinstall.info
	if is_crosscompile ; then
		# We need to make sure that /lib and /usr/lib always exists.
		# gcc likes to use relative paths to get to its multilibs like
		# /usr/lib/../lib64/.  So while we don't install any files into
		# /usr/lib/, we do need it to exist.
		cd "${ED}"$(alt_libdir)/..
		[[ -e lib ]] || mkdir lib
		cd "${ED}"$(alt_usrlibdir)/..
		[[ -e lib ]] || mkdir lib

		dosym usr/include $(alt_prefix)/sys-include
		return 0
	fi

	# Files for Debian-style locale updating
	dodir /usr/share/i18n
	sed \
		-e "/^#/d" \
		-e "/SUPPORTED-LOCALES=/d" \
		-e "s: \\\\::g" -e "s:/: :g" \
		"${S}"/localedata/SUPPORTED > "${ED}"/usr/share/i18n/SUPPORTED \
		|| die "generating /usr/share/i18n/SUPPORTED failed"

	# Make sure all the ABI's can find the locales and so we only
	# have to generate one set
	local a
	keepdir /usr/$(get_libdir)/locale
	for a in $(get_install_abis) ; do
		if [[ ! -e ${ED}/usr/$(get_abi_LIBDIR ${a})/locale ]] ; then
			dosym ../$(get_libdir)/locale /usr/$(get_abi_LIBDIR ${a})/locale
		fi
	done

	cd "${S}"

	# Install misc network config files
	insinto /etc
	doins nscd/nscd.conf posix/gai.conf nss/nsswitch.conf

	if use nscd ; then
		local nscd_args=(
			-e "s:@PIDFILE@:$(strings "${ED}"/usr/sbin/nscd | grep nscd.pid):"
		)

		sed -i "${nscd_args[@]}" "${ED}"/etc/init.d/nscd

		systemd_dounit nscd/nscd.service
		systemd_newtmpfilesd nscd/nscd.tmpfiles nscd.conf
	fi

	echo 'LDPATH="include ld.so.conf.d/*.conf"' > "${T}"/00glibc
	doenvd "${T}"/00glibc

	# Prevent overwriting of the /etc/localtime symlink.  We'll handle the
	# creation of the "factory" symlink in pkg_postinst().
	rm -f "${ED}"/etc/localtime

	# locale-gen install
	insinto /usr/bin && doins "${FILESDIR}/locale-gen/locale-gen"
	insinto /etc/ && doins "${FILESDIR}/locale-gen/locale.gen"

	cp -r "${ED}"/{lib,lib64,bin,sbin} "${ED}"/usr/
	rm -rf "${ED}"/{lib,lib64,bin,sbin}
}

glibc_headers_install() {
	local builddir=$(builddir "headers")
	cd "${builddir}"
	emake install_root="${D}$(alt_prefix)" install-headers

	insinto $(alt_headers)/gnu
	doins "${S}"/include/gnu/stubs.h

	# Make sure we install the sys-include symlink so that when
	# we build a 2nd stage cross-compiler, gcc finds the target
	# system headers correctly.  See gcc/doc/gccinstall.info
	dosym usr/include $(alt_prefix)/sys-include
}

src_install() {
	if just_headers ; then
		export ABI=default
		glibc_headers_install
		return
	fi

	foreach_abi glibc_do_src_install
	src_strip

	fperms +x /usr/bin/locale-gen
}

pkg_preinst() {
	# nothing to do if just installing headers
	just_headers && return

	# prepare /etc/ld.so.conf.d/ for files
	mkdir -p "${EROOT}"/etc/ld.so.conf.d

	[[ ${ROOT} != "/" ]] && return 0
	[[ -d ${ED}/usr/$(get_libdir) ]] || return 0
	[[ -z ${BOOTSTRAP_RAP} ]] && glibc_sanity_check
}

pkg_postinst() {
	# nothing to do if just installing headers
	just_headers && return

	if ! tc-is-cross-compiler && [[ -x ${EROOT}/usr/sbin/iconvconfig ]] ; then
		# Generate fastloading iconv module configuration file.
		"${EROOT}"/usr/sbin/iconvconfig --prefix="${ROOT}"
	fi

	if ! is_crosscompile && [[ ${ROOT} == "/" ]] ; then
		# Reload init ... if in a chroot or a diff init package, ignore
		# errors from this step #253697
		/usr/sbin/telinit U 2>/dev/null
	fi

	# Check for sanity of /etc/nsswitch.conf, take 2
	if [[ -e ${EROOT}/etc/nsswitch.conf ]] && ! has_version sys-lib/libnss-nis ; then
		local entry
		for entry in passwd group shadow; do
			if egrep -q "^[ \t]*${entry}:.*nis" "${EROOT}"/etc/nsswitch.conf; then
				ewarn ""
				ewarn "Your ${EROOT}/etc/nsswitch.conf uses NIS. Support for that has been"
				ewarn "removed from glibc and is now provided by the package"
				ewarn "  sys-lib/libnss-nis"
				ewarn "Install it now to keep your NIS setup working."
				ewarn ""
			fi
		done
	fi
}
