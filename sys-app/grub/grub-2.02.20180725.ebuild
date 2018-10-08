# Distributed under the terms of the GNU General Public License v2

EAPI=6

if [[ ${PV} == 9999  ]]; then
	inherit git-r3
	WANT_LIBTOOL=none
	EGIT_REPO_URI="https://git.savannah.gnu.org/git/grub.git"
else
	SNAPSHOT=c79ebcd18cf3e208e9dda5e2ae008f76c92fe451
	SRC_URI="http://git.savannah.gnu.org/cgit/grub.git/snapshot/grub-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64 x86"
fi

inherit autotools flag-o-matic multibuild toolchain-funcs

KEYWORDS="amd64 arm64 x86"

PATCHES=(
	"${FILESDIR}"/gfxpayload.patch
)

DEJAVU=dejavu-sans-ttf-2.37
UNIFONT=unifont-9.0.06
SRC_URI+=" fonts? ( mirror://gnu/unifont/${UNIFONT}/${UNIFONT}.pcf.gz )
	themes? ( mirror://sourceforge/dejavu/${DEJAVU}.zip )"

DESCRIPTION="GNU GRUB boot loader"
HOMEPAGE="https://www.gnu.org/software/grub/"

# Includes licenses for dejavu and unifont
LICENSE="GPL-3 fonts? ( GPL-2-with-font-exception ) themes? ( BitstreamVera )"
SLOT="2/${PVR}"
IUSE="debug device-mapper doc efiemu +fonts mount multislot nls static sdl test +themes truetype libzfs"

GRUB_ALL_PLATFORMS=( coreboot efi-32 efi-64 emu ieee1275 loongson multiboot qemu qemu-mips pc uboot xen xen-32 )
IUSE+=" ${GRUB_ALL_PLATFORMS[@]/#/grub_platforms_}"

REQUIRED_USE="
	grub_platforms_coreboot? ( fonts )
	grub_platforms_qemu? ( fonts )
	grub_platforms_ieee1275? ( fonts )
	grub_platforms_loongson? ( fonts )
"

RDEPEND="
	app-compression/xz-utils
	>=lib-sys/ncurses-5.2-r5:0=
	debug? (
		sdl? ( lib-media/libsdl )
	)
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	libzfs? ( sys-fs/zfs )
	mount? ( =sys-fs/fuse-2.9.9999 )
	truetype? ( lib-media/freetype:2= )
	ppc? ( sys-app/ibm-powerpc-utils sys-app/powerpc-utils )
	ppc64? ( sys-app/ibm-powerpc-utils sys-app/powerpc-utils )
"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	sys-app/help2man
	sys-app/texinfo
	fonts? ( lib-media/freetype:2 )
	grub_platforms_xen? ( app-misc/xen-tools:= )
	grub_platforms_xen-32? ( app-misc/xen-tools:= )
	static? (
		app-compression/xz-utils[static-libs(+)]
		truetype? (
			app-compression/lbzip2[static-libs(+)]
			lib-media/freetype[static-libs(+)]
			lib-sys/zlib[static-libs(+)]
		)
	)
	test? (
		sys-app/genromfs
		app-compression/cpio
		app-compression/lzop
		app-misc/qemu
		lib-dev/libisoburn
		sys-app/miscfiles
		sys-app/parted
		sys-fs/squashfs-tools
	)
	themes? (
		lib-media/freetype:2
	)
"
RDEPEND+="
	kernel_linux? (
		grub_platforms_efi-32? ( sys-app/efibootmgr )
		grub_platforms_efi-64? ( sys-app/efibootmgr )
	)
	!multislot? ( !sys-app/grub:0 !sys-app/grub-static )
	nls? ( sys-devel/gettext )
"

DEPEND+=" !!=lib-media/freetype-2.5.4"

RESTRICT="strip !test? ( test )"

QA_EXECSTACK="usr/bin/grub*-emu* usr/lib/grub/*"
QA_WX_LOAD="usr/lib/grub/*"
QA_MULTILIB_PATHS="usr/lib/grub/.*"

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
	fi
	default
}

src_prepare() {
	default

	sed -i -e /autoreconf/d autogen.sh || die

	if use multislot; then
		# fix texinfo file name, bug 416035
		sed -i -e 's/^\* GRUB:/* GRUB2:/' -e 's/(grub)/(grub2)/' docs/grub.texi || die
	fi

	sed -i \
		-e '/CFILESSRC.*=/s,american-english,words,' \
		tests/util/grub-fs-tester.in \
		|| die

	bash autogen.sh || die
	autopoint() { :; }
	eautoreconf
}

grub_do() {
	multibuild_foreach_variant run_in_build_dir "$@"
}

grub_do_once() {
	multibuild_for_best_variant run_in_build_dir "$@"
}

grub_configure() {
	local platform

	case ${MULTIBUILD_VARIANT} in
		efi*) platform=efi ;;
		xen*) platform=xen ;;
		guessed) ;;
		*) platform=${MULTIBUILD_VARIANT} ;;
	esac

	case ${MULTIBUILD_VARIANT} in
		*-32)
			if [[ ${CTARGET:-${CHOST}} == x86_64* ]]; then
				local CTARGET=i386
			fi ;;
		*-64)
			if [[ ${CTARGET:-${CHOST}} == i?86* ]]; then
				local CTARGET=x86_64
				local -x TARGET_CFLAGS="-Os -march=x86-64 ${TARGET_CFLAGS}"
				local -x TARGET_CPPFLAGS="-march=x86-64 ${TARGET_CPPFLAGS}"
			fi ;;
	esac

	local myeconfargs=(
		--disable-werror
		--program-prefix=
		--libdir="${EPREFIX}"/usr/lib
		--htmldir="${EPREFIX}"/usr/share/doc/${PF}/html
		$(use_enable debug mm-debug)
		$(use_enable device-mapper)
		$(use_enable mount grub-mount)
		$(use_enable nls)
		$(use_enable themes grub-themes)
		$(use_enable truetype grub-mkfont)
		$(use_enable libzfs)
		$(use sdl && use_enable debug grub-emu-sdl)
		${platform:+--with-platform=}${platform}

		# Let configure detect this where supported
		$(usex efiemu '' '--disable-efiemu')
	)

	if use multislot; then
		myeconfargs+=( --program-transform-name="s,grub,grub2," )
	fi

	# Set up font symlinks
	ln -s "${WORKDIR}/${UNIFONT}.pcf" unifont.pcf || die
	if use themes; then
		ln -s "${WORKDIR}/${DEJAVU}/ttf/DejaVuSans.ttf" DejaVuSans.ttf || die
	fi

	local ECONF_SOURCE="${S}"
	econf "${myeconfargs[@]}"
}

src_configure() {
	# Bug 508758.
	replace-flags -O3 -O2

	# We don't want to leak flags onto boot code.
	export HOST_CCASFLAGS=${CCASFLAGS}
	export HOST_CFLAGS=${CFLAGS}
	export HOST_CPPFLAGS=${CPPFLAGS}
	export HOST_LDFLAGS=${LDFLAGS}
	unset CCASFLAGS CFLAGS CPPFLAGS LDFLAGS

	use static && HOST_LDFLAGS+=" -static"

	tc-ld-disable-gold #439082 #466536 #526348
	export TARGET_LDFLAGS="${TARGET_LDFLAGS} ${LDFLAGS}"
	unset LDFLAGS

	tc-export CC NM OBJCOPY RANLIB STRIP
	tc-export BUILD_CC # Bug 485592

	MULTIBUILD_VARIANTS=()
	local p
	for p in "${GRUB_ALL_PLATFORMS[@]}"; do
		use "grub_platforms_${p}" && MULTIBUILD_VARIANTS+=( "${p}" )
	done
	[[ ${#MULTIBUILD_VARIANTS[@]} -eq 0 ]] && MULTIBUILD_VARIANTS=( guessed )
	grub_do grub_configure
}

src_compile() {
	# Sandbox bug 404013.
	use libzfs && addpredict /etc/dfs:/dev/zfs

	grub_do emake
	use doc && grub_do_once emake -C docs html
}

src_test() {
	# The qemu dependency is a bit complex.
	# You will need to adjust QEMU_SOFTMMU_TARGETS to match the cpu/platform.
	grub_do emake check
}

src_install() {
	grub_do emake install DESTDIR="${D}"
	use doc && grub_do_once emake -C docs install-html DESTDIR="${D}"

	einstalldocs

	if use multislot; then
		mv "${ED%/}"/usr/share/info/grub{,2}.info || die
	fi

	insinto /etc/default
	newins "${FILESDIR}"/grub.default-3 grub
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog
		elog "You may consider installing the following optional packages:"
		optfeature "Detect other operating systems (grub-mkconfig)" sys-app/os-prober
		optfeature "Create rescue media (grub-mkrescue)" lib-dev/libisoburn
		optfeature "Enable RAID device detection" sys-fs/mdadm
	fi
}
