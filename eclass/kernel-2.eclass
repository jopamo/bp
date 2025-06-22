# Distributed under the terms of the GNU General Public License v2

# @ECLASS: kernel-2.eclass
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Minimal eclass for kernel packages based on stable git branches

inherit crossdev estack multiprocessing optfeature toolchain-funcs

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

HOMEPAGE="https://www.kernel.org/"
: "${LICENSE:="GPL-2"}"
RESTRICT="binchecks strip"
: "${LINUX_HOSTCFLAGS:="-Wall -Wstrict-prototypes -Os -fomit-frame-pointer -I${S}/include"}"

IUSE="+symlink"
# @FUNCTION: install_universal
# @USAGE:
# @DESCRIPTION:
# Fix permissions in tarball
install_universal() {
	chown -R 0:0 "${WORKDIR}"/* &>/dev/null
	chmod -R a+r-w+X,u+w "${WORKDIR}"/*
}

# @FUNCTION: install_headers
# @USAGE:
# @DESCRIPTION:
# Install headers (if you ship headers; optional)
install_headers() {
	local ddir=$(kernel_header_destdir)
	env_setup_kernel_makeopts
	emake headers_install INSTALL_HDR_PATH="${ED}${ddir}/.." "${KERNEL_MAKEOPTS[@]}"
	rm -rf "${ED}${ddir}/scsi" || die # optional, for glibc/uclibc/etc.
}

# @FUNCTION: install_sources
# @USAGE:
# @DESCRIPTION:
# Install sources from the stable git working tree
install_sources() {
	einfo ">>> Copying sources ..."
	install -d "${ED}/usr/src/linux-${PV}" || die
	cp -a "${WORKDIR}"/stable-*/. "${ED}/usr/src/linux-${PV}" || die
}

# @FUNCTION: postinst_sources
# @USAGE:
# @DESCRIPTION:
# Optionally symlink /usr/src/linux to this version
postinst_sources() {
	use symlink && K_SYMLINK=1

	if [[ ${K_SYMLINK} -gt 0 ]]; then
		if [[ -e ${EROOT}/usr/src/linux && ! -L ${EROOT}/usr/src/linux ]]; then
			die "${EROOT}/usr/src/linux exists and is not a symlink"
		fi
		ln -snf linux-${PV} "${EROOT}/usr/src/linux" || die
	fi

	optfeature "versioned kernel image installation and optionally automating tasks such as generating an initramfs or unified kernel image" \
		"sys-kernel/installkernel"
}

# Cross-compile support functions (optional, kept for completeness)
kernel_header_destdir() {
	[[ ${CTARGET} == ${CHOST} ]] && echo /usr/include || echo /usr/${CTARGET}/usr/include
}

env_setup_kernel_makeopts() {
	export KARCH=$(tc-arch-kernel)
	KERNEL_MAKEOPTS=( ARCH="${KARCH}" )
	if [[ ${CTARGET} != ${CHOST} ]]; then
		KERNEL_MAKEOPTS+=( CROSS_COMPILE="${CTARGET}-" )
	elif type -p ${CHOST}-ar >/dev/null; then
		KERNEL_MAKEOPTS+=( CROSS_COMPILE="${CHOST}-" )
	fi
	KERNEL_MAKEOPTS+=(
		HOSTCC="$(tc-getBUILD_CC)"
		CC="$(tc-getCC)"
		LD="$(tc-getLD)"
		AR="$(tc-getAR)"
		NM="$(tc-getNM)"
		OBJCOPY="$(tc-getOBJCOPY)"
		READELF="$(tc-getREADELF)"
		STRIP="$(tc-getSTRIP)"
	)
	export KERNEL_MAKEOPTS
}

# @FUNCTION: kernel-2_src_prepare
kernel-2_src_prepare() {
	debug-print "Applying any user patches"
	eapply_user
}

kernel-2_src_compile() { :; }
kernel-2_src_test()    { :; }

kernel-2_pkg_preinst() { :; }
kernel-2_pkg_setup()   { :; }

kernel-2_src_install() {
	install_universal
	[[ ${ETYPE} == headers ]] && install_headers
	[[ ${ETYPE} == sources ]] && install_sources
	dedup_symlink "${D}"
}
kernel-2_pkg_postinst() {
	[[ ${ETYPE} == sources ]] && postinst_sources
}
kernel-2_pkg_postrm()   { :; }

EXPORT_FUNCTIONS src_{prepare,compile,install,test} \
	pkg_{setup,preinst,postinst,postrm}
