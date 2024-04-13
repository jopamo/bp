# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${P/_/-}"

inherit linux-info toolchain-funcs python-r1 xdg flag-o-matic

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://git.qemu.org/git/qemu.git"
	inherit git-r3
	SRC_URI=""
else
	SRC_URI="https://download.qemu.org/${MY_P}.tar.xz"
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+aio alsa bzip2 capstone +caps +curl debug +fdt fuse
	gnutls +gtk iscsi jack jemalloc +jpeg lzo multipath ncurses nfs nls numa
	opengl +oss +pin-upstream-blobs	plugins +png pulseaudio python sasl
	+seccomp sdl sdl-image selinux smartcard snappy ssh static static-user
	test udev usb	usbredir vde +vhost-net vhost-user-fs virgl virtfs
	+vnc vte xattr xen xfs zstd"

COMMON_TARGETS="
	aarch64
	alpha
	arm
	cris
	hppa
	i386
	m68k
	microblaze
	microblazeel
	mips
	mips64
	mips64el
	mipsel
	nios2
	or1k
	ppc
	ppc64
	riscv32
	riscv64
	s390x
	sh4
	sh4eb
	sparc
	sparc64
	x86_64
	xtensa
	xtensaeb
"
IUSE_SOFTMMU_TARGETS="
	${COMMON_TARGETS}
	avr
	lm32
	moxie
	rx
	tricore
	unicore32
"
IUSE_USER_TARGETS="
	${COMMON_TARGETS}
	aarch64_be
	armeb
	hexagon
	mipsn32
	mipsn32el
	ppc64abi32
	ppc64le
	sparc32plus
"

use_softmmu_targets=$(printf ' qemu_softmmu_targets_%s' ${IUSE_SOFTMMU_TARGETS})
use_user_targets=$(printf ' qemu_user_targets_%s' ${IUSE_USER_TARGETS})
IUSE+=" ${use_softmmu_targets} ${use_user_targets}"

RESTRICT="!test? ( test )"
# Allow no targets to be built so that people can get a tools-only build.
# Block USE flag configurations known to not work.
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	qemu_softmmu_targets_arm? ( fdt )
	qemu_softmmu_targets_microblaze? ( fdt )
	qemu_softmmu_targets_mips64el? ( fdt )
	qemu_softmmu_targets_ppc64? ( fdt )
	qemu_softmmu_targets_ppc? ( fdt )
	qemu_softmmu_targets_riscv32? ( fdt )
	qemu_softmmu_targets_riscv64? ( fdt )
	sdl-image? ( sdl )
	static? ( static-user !alsa !gtk !jack !opengl !pulseaudio !plugins !snappy )
	static-user? ( !plugins )
	vhost-user-fs? ( caps seccomp )
	virgl? ( opengl )
	virtfs? ( caps xattr )
	vte? ( gtk )
	multipath? ( udev )
	plugins? ( !static !static-user )
"

# Dependencies required for qemu tools (qemu-nbd, qemu-img, qemu-io, ...)
# and user/softmmu targets (qemu-*, qemu-system-*).
#
# Yep, you need both libcap and libcap-ng since virtfs only uses libcap.
#
# The attr lib isn't always linked in (although the USE flag is always
# respected).  This is because qemu supports using the C library's API
# when available rather than always using the external library.
ALL_DEPEND="
	lib-dev/libtasn1[static-libs(+)]
	lib-util/glib[static-libs(+)]
	lib-core/zlib[static-libs(+)]
	python? ( ${PYTHON_DEPS} )
	xattr? ( app-core/attr[static-libs(+)] )"

# Dependencies required for qemu tools (qemu-nbd, qemu-img, qemu-io, ...)
# softmmu targets (qemu-system-*).
SOFTMMU_TOOLS_DEPEND="
	lib-core/libxml2[static-libs(+)]
	xgui-lib/pixman[static-libs(+)]
	aio? ( lib-dev/libaio[static-libs(+)] )
	alsa? ( xgui-tools/alsa-lib )
	bzip2? ( app-compression/bzip2[static-libs(+)] )
	capstone? ( lib-dev/capstone )
	caps? ( lib-core/libcap-ng[static-libs(+)] )
	curl? ( app-net/curl[static-libs(+)] )
	fdt? ( app-dev/dtc[static-libs(+)] )
	fuse? ( app-fs/fuse:3[static-libs(+)] )
	gnutls? (
		lib-core/nettle[static-libs(+)]
		net-libs/gnutls[static-libs(+)]
	)
	gtk? (
		xgui-lib/gtk3
		vte? ( xgui-lib/vte )
	)
	iscsi? ( lib-misc/libiscsi )
	jack? ( virtual/jack )
	jemalloc? ( lib-dev/jemalloc )
	jpeg? ( xmedia-lib/libjpeg-turbo[static-libs(+)] )
	lzo? ( lib-dev/lzo[static-libs(+)] )
	multipath? ( app-fs/multipath-tools )
	ncurses? (
		virtual/curses[static-libs(+)]
	)
	nfs? ( net-fs/libnfs[static-libs(+)] )
	numa? ( sys-process/numactl[static-libs(+)] )
	opengl? (
		xmedia-lib/libepoxy[static-libs(+)]
		xgui-tools/mesa[static-libs(+)]
	)
	png? ( xmedia-lib/libpng[static-libs(+)] )
	pulseaudio? ( xgui-misc/pulseaudio )
	sasl? ( lib-dev/cyrus-sasl[static-libs(+)] )
	seccomp? ( lib-core/libseccomp[static-libs(+)] )
	smartcard? ( >=app-emulation/libcacard-2.5.0[static-libs(+)] )
	snappy? ( app-compression/snappy:= )
	ssh? ( net-libs/libssh[static-libs(+)] )
	udev? ( virtual/libudev[static-libs(+)] )
	usb? ( lib-dev/libusb[static-libs(+)] )
	usbredir? ( app-core/usbredir[static-libs(+)] )
	virgl? ( xmedia-live-lib/virglrenderer[static-libs(+)] )
	virtfs? ( lib-core/libcap )
	xen? ( app-emulation/xen-tools:= )
	xfs? ( app-fs/xfsprogs[static-libs(+)] )
	zstd? ( app-compression/zstd[static-libs(+)] )
"

BDEPEND="
	$(python_gen_impl_dep)
	app-lang/perl
	app-build/texinfo
	app-dev/pkgconf
	gtk? ( nls? ( app-build/gettext ) )
	test? (
		lib-util/glib[utils]
		app-util/bc
	)
"
CDEPEND="
	!static? (
		${ALL_DEPEND//\[static-libs(+)]}
		${SOFTMMU_TOOLS_DEPEND//\[static-libs(+)]}
	)
"
DEPEND="${CDEPEND}
	app-kernel/linux-headers
	static? (
		${ALL_DEPEND}
		${SOFTMMU_TOOLS_DEPEND}
	)
	static-user? ( ${ALL_DEPEND} )"
RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-qemu )"

PATCHES=(
	"${FILESDIR}"/${PN}-2.11.1-capstone_include_path.patch
	"${FILESDIR}"/${PN}-5.2.0-disable-keymap.patch
	"${FILESDIR}"/${PN}-6.0.0-make.patch
)

QA_PREBUILT="
	usr/share/qemu/hppa-firmware.img
	usr/share/qemu/openbios-ppc
	usr/share/qemu/openbios-sparc64
	usr/share/qemu/openbios-sparc32
	usr/share/qemu/opensbi-riscv64-generic-fw_dynamic.elf
	usr/share/qemu/opensbi-riscv32-generic-fw_dynamic.elf
	usr/share/qemu/palcode-clipper
	usr/share/qemu/s390-ccw.img
	usr/share/qemu/s390-netboot.img
	usr/share/qemu/u-boot.e500
"

QA_WX_LOAD="usr/bin/qemu-i386
	usr/bin/qemu-x86_64
	usr/bin/qemu-alpha
	usr/bin/qemu-arm
	usr/bin/qemu-cris
	usr/bin/qemu-m68k
	usr/bin/qemu-microblaze
	usr/bin/qemu-microblazeel
	usr/bin/qemu-mips
	usr/bin/qemu-mipsel
	usr/bin/qemu-or1k
	usr/bin/qemu-ppc
	usr/bin/qemu-ppc64
	usr/bin/qemu-ppc64abi32
	usr/bin/qemu-sh4
	usr/bin/qemu-sh4eb
	usr/bin/qemu-sparc
	usr/bin/qemu-sparc64
	usr/bin/qemu-armeb
	usr/bin/qemu-sparc32plus
	usr/bin/qemu-s390x
	usr/bin/qemu-unicore32
"

filter-flags -flto\=\*

pkg_pretend() {
	if ! linux_config_exists; then
		eerror "Unable to check your kernel for KVM support"
	else
		CONFIG_CHECK="~KVM ~TUN ~BRIDGE"
		ERROR_KVM="You must enable KVM in your kernel to continue"
		ERROR_KVM_AMD="If you have an AMD CPU, you must enable KVM_AMD in"
		ERROR_KVM_AMD+=" your kernel configuration."
		ERROR_KVM_INTEL="If you have an Intel CPU, you must enable"
		ERROR_KVM_INTEL+=" KVM_INTEL in your kernel configuration."
		ERROR_TUN="You will need the Universal TUN/TAP driver compiled"
		ERROR_TUN+=" into your kernel or loaded as a module to use the"
		ERROR_TUN+=" virtual network device if using -net tap."
		ERROR_BRIDGE="You will also need support for 802.1d"
		ERROR_BRIDGE+=" Ethernet Bridging for some network configurations."
		use vhost-net && CONFIG_CHECK+=" ~VHOST_NET"
		ERROR_VHOST_NET="You must enable VHOST_NET to have vhost-net"
		ERROR_VHOST_NET+=" support"

		if use amd64 ; then
			if grep -q AuthenticAMD /proc/cpuinfo; then
				CONFIG_CHECK+=" ~KVM_AMD"
			elif grep -q GenuineIntel /proc/cpuinfo; then
				CONFIG_CHECK+=" ~KVM_INTEL"
			fi
		fi

		use python && CONFIG_CHECK+=" ~DEBUG_FS"
		ERROR_DEBUG_FS="debugFS support required for kvm_stat"

		# Now do the actual checks setup above
		check_extra_config
	fi
}

src_prepare() {
	default

	# Use correct toolchain to fix cross-compiling
	tc-export AR AS LD NM OBJCOPY PKG_CONFIG RANLIB STRINGS

	# Verbose builds
	MAKEOPTS+=" V=1"

	# Remove bundled copy of libfdt
	rm -r dtc || die
}

##
# configures qemu based on the build directory and the build type
# we are using.
#
qemu_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	local buildtype=$1
	local builddir="${S}/${buildtype}-build"

	mkdir "${builddir}"

	local conf_opts=(
		--prefix=/usr
		--sysconfdir=/etc
		--bindir=/usr/bin
		--libdir=/usr/lib
		--datadir=/usr/share
		--docdir=/usr/share/doc/${PF}/html
		--mandir=/usr/share/man
		--localstatedir=/var
		--disable-bsd-user
		--disable-containers # bug #732972
		--disable-guest-agent
		--disable-strip
		--disable-tcg-interpreter
		--disable-werror
		--disable-gcrypt
		--python="${PYTHON}"
		--cc="$(tc-getCC)"
		--cxx="$(tc-getCXX)"
		--host-cc="$(tc-getBUILD_CC)"
		$(use_enable debug debug-info)
		$(use_enable debug debug-tcg)
		--disable-docs
		$(use_enable nls gettext)
		$(use_enable plugins)
		$(use_enable xattr attr)
	)

	# Disable options not used by user targets. This simplifies building
	# static user targets (USE=static-user) considerably.
	conf_notuser() {
		if [[ ${buildtype} == "user" ]] ; then
			echo "--disable-${2:-$1}"
		else
			use_enable "$@"
		fi
	}
	# Enable option only for softmmu build, but not 'user' or 'tools'
	conf_softmmu() {
		if [[ ${buildtype} == "softmmu" ]] ; then
			use_enable "$@"
		else
			echo "--disable-${2:-$1}"
		fi
	}
	# Enable option only for tools build, but not 'user' or 'softmmu'
	conf_tools() {
		if [[ ${buildtype} == "tools" ]] ; then
			use_enable "$@"
		else
			echo "--disable-${2:-$1}"
		fi
	}
	conf_opts+=(
		--disable-brlapi
		$(conf_notuser aio linux-aio)
		$(conf_notuser bzip2)
		$(conf_notuser capstone)
		$(conf_notuser caps cap-ng)
		$(conf_notuser curl)
		$(conf_notuser fdt)
		$(conf_notuser fuse)
		--disable-glusterfs
		$(conf_notuser gnutls)
		$(conf_notuser gnutls nettle)
		$(conf_notuser gtk)
		--disable-rdma
		$(conf_notuser iscsi libiscsi)
		--disable-linux-io-uring
		$(conf_notuser jemalloc jemalloc)
		$(conf_notuser jpeg vnc-jpeg)
		--enable-kvm
		$(conf_notuser lzo)
		$(conf_notuser multipath mpath)
		$(conf_notuser ncurses curses)
		$(conf_notuser nfs libnfs)
		$(conf_notuser numa)
		$(conf_notuser opengl)
		$(conf_notuser png vnc-png)
		--disable-rbd
		$(conf_notuser sasl vnc-sasl)
		--disable-sdl
		--disable-sdl-image
		$(conf_notuser seccomp)
		--enable-slirp
		$(conf_notuser smartcard)
		$(conf_notuser snappy)
		$(conf_notuser ssh libssh)
		$(conf_notuser udev libudev)
		$(conf_notuser usb libusb)
		$(conf_notuser usbredir usb-redir)
		--disable-vde
		$(conf_notuser vhost-net)
		$(conf_notuser vhost-user-fs)
		$(conf_tools vhost-user-fs virtiofsd)
		$(conf_notuser virgl virglrenderer)
		$(conf_softmmu virtfs)
		$(conf_notuser vnc)
		$(conf_notuser vte)
		$(conf_notuser xen)
		$(conf_notuser xen xen-pci-passthrough)
		$(conf_notuser xfs xfsctl)
		# use prebuilt keymaps, bug #759604
		--disable-xkbcommon
		$(conf_notuser zstd)
	)

	if [[ ${buildtype} == "user" ]] ; then
		conf_opts+=( --disable-libxml2 )
	else
		conf_opts+=( --enable-libxml2 )
	fi

	if [[ ! ${buildtype} == "user" ]] ; then
		# audio options
		local audio_opts=(
			# Note: backend order matters here: #716202
			# We iterate from higher-level to lower level.
			$(usex pulseaudio pa "")
			$(usev jack)
			$(usev sdl)
			$(usev alsa)
			$(usev oss)
		)
		conf_opts+=(
			--audio-drv-list=$(printf "%s," "${audio_opts[@]}")
		)
	fi

	case ${buildtype} in
	user)
		conf_opts+=(
			--enable-linux-user
			--disable-system
			--disable-blobs
			--disable-tools
		)
		local static_flag="static-user"
		;;
	softmmu)
		conf_opts+=(
			--disable-linux-user
			--enable-system
			--disable-tools
		)
		local static_flag="static"
		;;
	tools)
		conf_opts+=(
			--disable-linux-user
			--disable-system
			--disable-blobs
			--enable-tools
		)
		local static_flag="static"
		;;
	esac

	local targets="${buildtype}_targets"
	[[ -n ${targets} ]] && conf_opts+=( --target-list="${!targets}" )

	# We always want to attempt to build with PIE support as it results
	# in a more secure binary. But it doesn't work with static or if
	# the current GCC doesn't have PIE support.
	if use ${static_flag}; then
		conf_opts+=( --static --disable-pie )
	else
		tc-enables-pie && conf_opts+=( --enable-pie )
	fi

	# Meson will not use a cross-file unless cross_prefix is set.
	tc-is-cross-compiler && conf_opts+=( --cross-prefix="${CHOST}-" )

	# Plumb through equivalent of EXTRA_ECONF to allow experiments
	# like bug #747928.
	conf_opts+=( ${EXTRA_CONF_QEMU} )

	echo "../configure ${conf_opts[*]}"
	cd "${builddir}"
	../configure "${conf_opts[@]}" || die "configure failed"
}

src_configure() {
	local target

	python_setup

	softmmu_targets= softmmu_bins=()
	user_targets= user_bins=()

	for target in ${IUSE_SOFTMMU_TARGETS} ; do
		if use "qemu_softmmu_targets_${target}"; then
			softmmu_targets+=",${target}-softmmu"
			softmmu_bins+=( "qemu-system-${target}" )
		fi
	done

	for target in ${IUSE_USER_TARGETS} ; do
		if use "qemu_user_targets_${target}"; then
			user_targets+=",${target}-linux-user"
			user_bins+=( "qemu-${target}" )
		fi
	done

	softmmu_targets=${softmmu_targets#,}
	user_targets=${user_targets#,}

	[[ -n ${softmmu_targets} ]] && qemu_src_configure "softmmu"
	[[ -n ${user_targets}    ]] && qemu_src_configure "user"
	qemu_src_configure "tools"
}

src_test() {
	if [[ -n ${softmmu_targets} ]]; then
		cd "${S}/softmmu-build"
		emake check
	fi
}

qemu_python_install() {
	python_domodule "${S}/python/qemu"

	python_doscript "${S}/scripts/kvm/vmxcap"
	python_doscript "${S}/scripts/qmp/qmp-shell"
	python_doscript "${S}/scripts/qmp/qemu-ga-client"
}

src_install() {
	if [[ -n ${user_targets} ]]; then
		cd "${S}/user-build"
		emake DESTDIR="${ED}" install

		# Install binfmt handler init script for user targets.
		generate_initd
		doinitd "${T}/qemu-binfmt"

		# Install binfmt/qemu.conf.
		insinto "/usr/share/qemu/binfmt.d"
		doins "${T}/qemu.conf"
	fi

	if [[ -n ${softmmu_targets} ]]; then
		cd "${S}/softmmu-build"
		emake DESTDIR="${ED}" install

		# This might not exist if the test failed. #512010
		[[ -e check-report.html ]] && dodoc check-report.html

		insinto usr/lib/udev/rules.d
		doins "${FILESDIR}"/65-kvm.rules

		if use python; then
			python_foreach_impl qemu_python_install
		fi
	fi

	cd "${S}/tools-build"
	emake DESTDIR="${ED}" install

	# Install config file example for qemu-bridge-helper
	insinto "/etc/qemu"
	doins "${FILESDIR}/bridge.conf"

	# Disallow stripping of prebuilt firmware files.
	dostrip -x ${QA_PREBUILT}

	cleanup_install
}
