# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="gdb-$(ver_cut 1)-branch"

PYTHON_COMPAT=( python3_13 )

inherit flag-o-matic python-single-r1 qa-policy toolchain-funcs

DESCRIPTION="GNU debugger"
HOMEPAGE="https://sourceware.org/gdb/"
SNAPSHOT=fc111c4cb24f36e51db96324f8aff8e0b4b131e8
SRC_URI="https://github.com/1g4-mirror/binutils-gdb/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/binutils-gdb-${SNAPSHOT}"

LICENSE="GPL-3+ FDL-1.3 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="client lzma multitarget python server test xml"

REQUIRED_USE="
	lzma? ( client )
	multitarget? ( client )
	python? ( ${PYTHON_REQUIRED_USE} )
	python? ( client )
	test? ( client )
	xml? ( client )
	|| ( client server )
"

COMMON_DEPEND="
	server? ( !app-dev/gdbserver )
	client? (
		app-compression/zstd
		virtual/curses
		lib-core/gmp
		lib-core/mpfr
		lib-core/readline
		lib-core/zlib
		lib-misc/xxhash
		lzma? ( app-compression/xz-utils )
		python? ( ${PYTHON_DEPS} )
		xml? ( lib-core/expat )
	)
"

RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"
BDEPEND="
	app-build/gettext
	app-build/texinfo
	app-lang/perl
	client? (
		app-build/bison
		app-build/flex
		test? ( app-dev/dejagnu )
	)
"

PATCHES=( "${FILESDIR}"/gdb-17.20260304-flex-yyunput.patch )

GDB_BUILD_DIR="${WORKDIR}/${P}-build"

_gdb_install_server_manpage() {
	local docdir="${T}/gdbserver-doc"
	local bfd_version_date

	rm -rf -- "${docdir}" || die
	mkdir -p -- "${docdir}" || die

	bfd_version_date=$(sed -n -e 's/^.* BFD_VERSION_DATE \(.*\)$/\1/p' "${S}/bfd/version.h") || die
	[[ -n ${bfd_version_date} ]] || die "failed to determine BFD_VERSION_DATE"

	sed -e "s/DATE/${bfd_version_date}/" \
		< "${S}/gdb/version.in" > "${docdir}/version.subst" || die
	{
		printf '@set GDBVN %s\n' "$(sed q "${docdir}/version.subst")"
		printf '%s\n' '@set BUGURL @uref{http://www.gnu.org/software/gdb/bugs/}'
		printf '%s\n' '@set BUGURL_DEFAULT'
		printf '%s\n' '@set SYSTEM_READLINE'
	} > "${docdir}/GDBvn.texi" || die
	cp -- "${S}/gdb/doc/all-cfg.texi" "${docdir}/gdb-cfg.texi" || die

	pushd "${docdir}" >/dev/null || die
		perl "${S}/etc/texi2pod.pl" -Dman -Dgdbserver \
			< "${S}/gdb/doc/gdb.texinfo" > gdbserver.pod || die
		pod2man \
			--section=1 \
			--release="gdb-$(sed q version.subst)" \
			gdbserver.pod | sed -e '/^.if n .na/d' > gdbserver.1 || die
	popd >/dev/null || die

	doman "${docdir}/gdbserver.1"
}

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	default
	use elibc_musl && eapply "${FILESDIR}"/termios.patch

	# Avoid redefining struct user_gcs when the kernel UAPI already provides it
	sed -i \
		-e 's/^#ifndef GCS_MAGIC$/#ifndef NT_ARM_GCS\n#define NT_ARM_GCS 0x410/' \
		-e 's/^#endif \/\* GCS_MAGIC \*\/$/#endif \/* NT_ARM_GCS *\//' \
		gdb/arch/aarch64-gcs-linux.h || die
}

src_configure() {
	strip-flags
	replace-flags "-D_FORTIFY_SOURCE=3" "-D_FORTIFY_SOURCE=2"
	append-flags -fpermissive
	qa-policy-configure

	local myconf=(
		$(use multitarget && echo --enable-targets=all)
		$(use_enable server gdbserver auto)
		$(usex client '' '--disable-gdb')
		$(use_with lzma)
		$(use_with python python "${EPYTHON}")
		$(use_with xml expat)
		--disable-dependency-tracking
		--disable-install-libbfd
		--disable-install-libiberty
		--disable-werror
		--disable-{binutils,etc,gas,gold,gprof,gprofng,ld}
		--enable-64-bit-bfd
		--enable-tui
		--with-separate-debug-dir="${EPREFIX}"/usr/lib/debug
		--with-system-readline
		--with-system-zlib
		--without-guile
	)

	export ac_cv_path_pkg_config_prog_path="$(tc-getPKG_CONFIG)"

	mkdir "${GDB_BUILD_DIR}" || die
	pushd "${GDB_BUILD_DIR}" >/dev/null || die
		ECONF_SOURCE=${S} econf "${myconf[@]}"
	popd >/dev/null
}

src_compile() {
	emake -C "${GDB_BUILD_DIR}"
}

src_test() {
	use test || return 0
	emake -C "${GDB_BUILD_DIR}" check
}

src_install() {
	if use server && ! use client; then
		emake -C "${GDB_BUILD_DIR}"/gdbserver DESTDIR="${D}" install
		_gdb_install_server_manpage
	else
		emake -C "${GDB_BUILD_DIR}" DESTDIR="${D}" install
	fi

	if use client; then
		find "${ED}"/usr -name libiberty.a -delete || die

		# Remove shared info pages
		rm "${ED}"/usr/share/info/{annotate,bfd,ctf-spec,sframe-spec}.info* || die
	fi

	if use client && use python; then
		python_optimize "${ED}"/usr/share/gdb/python/gdb
	fi

	cleanup_install
	qa-policy-install
}
