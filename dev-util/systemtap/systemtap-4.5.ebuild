# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info python-single-r1 flag-o-matic user

DESCRIPTION="A linux trace/probe tool"
HOMEPAGE="https://www.sourceware.org/systemtap/"
SRC_URI="https://www.sourceware.org/${PN}/ftp/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libvirt selinux sqlite +ssl test zeroconf"

RESTRICT="!test? ( test )"

CONFIG_CHECK="~KPROBES ~RELAY ~DEBUG_FS"
ERROR_KPROBES="${PN} requires support for KProbes Instrumentation (KPROBES) - this can be enabled in 'Instrumentation Support -> Kprobes'."
ERROR_RELAY="${PN} works with support for user space relay support (RELAY) - this can be enabled in 'General setup -> Kernel->user space relay support (formerly relayfs)'."
ERROR_DEBUG_FS="${PN} works best with support for Debug Filesystem (DEBUG_FS) - this can be enabled in 'Kernel hacking -> Debug Filesystem'."

filter-flags -Wl,-z,defs

pkg_setup() {
	linux-info_pkg_setup
	python-single-r1_pkg_setup

	enewgroup stapusr 156
	enewgroup stapsys 157
	enewgroup stapdev 158
}

src_prepare() {
	python_fix_shebang .

	sed -i \
		-e 's:-Werror::g' \
		configure.ac \
		Makefile.am \
		stapbpf/Makefile.am \
		stapdyn/Makefile.am \
		staprun/Makefile.am \
		testsuite/systemtap.unprivileged/unprivileged_probes.exp \
		testsuite/systemtap.unprivileged/unprivileged_myproc.exp \
		testsuite/systemtap.base/stmt_rel_user.exp \
		testsuite/systemtap.base/sdt_va_args.exp \
		testsuite/systemtap.base/sdt_misc.exp \
		testsuite/systemtap.base/sdt.exp \
		scripts/kprobes_test/gen_code.py \
		|| die "Failed to clean up sources"

	default
}

src_configure() {
	local myeconfargs=(
		--disable-docs
		--disable-grapher
		--disable-refdocs
		--disable-server
		--enable-pie
		--with-python3
		--without-java
		--without-openssl
		--without-python2-probes
		--without-rpm
		$(use_enable libvirt virt)
		$(use_enable sqlite)
		$(use_with zeroconf avahi)
		$(use_with ssl nss)
		$(use_with selinux)
	)
	PYTHON3="${PYTHON}" \
	econf "${myeconfargs[@]}"
}

src_install() {
	default
	python_optimize
}
