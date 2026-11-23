# Distributed under the terms of the GNU General Public License v2

inherit flag-o-matic doins toolchain-funcs linux-info qa-policy

DESCRIPTION="Userspace utils and init scripts for the AppArmor application security system"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=8f7e3c0555dfe366f9d04b7b4b8035ae18d957a4
SRC_URI="https://gitlab.com/apparmor/apparmor/-/archive/${SNAPSHOT}/apparmor-${SNAPSHOT}.tar.bz2 -> apparmor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/apparmor-${SNAPSHOT}/parser"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="~lib-core/libapparmor-${PV}"
DEPEND="${RDEPEND}"
BDEPEND="
	app-build/bison
	app-build/flex
	app-lang/perl
	test? ( dev-pypi/pytest dev-pypi/pytest-xdist )
"

CONFIG_CHECK="SECURITY_APPARMOR"

PATCHES=(
	"${FILESDIR}/generate-parser-tables-with-awk.patch"
	"${FILESDIR}/lexer-buffer-after-flex-definitions.patch"
)

src_prepare() {
	default

	sed -e '/^AALIB =/ s/-Bstatic/-Bdynamic/' -i Makefile || die

	# Keep the init helpers and parser at their packaged paths.
	sed -i \
		-e 's:/lib/apparmor/rc\.apparmor\.functions:/usr/libexec/rc.apparmor.functions:g' \
		-e 's:/sbin/apparmor_parser:/usr/bin/apparmor_parser:g' \
		-e 's:/usr/sbin/aa-status:/usr/bin/aa-status:g' \
		../init/{apparmor.systemd,profile-load,rc.apparmor.functions} || die
	sed -i 's:/lib/apparmor/apparmor\.systemd:/usr/lib/apparmor/apparmor.systemd:' \
		../init/aa-teardown || die

	# bug 634782
	sed -e "s/cpp/$(tc-getCPP) -/" \
		-i ../common/list_capabilities.sh \
		-i ../common/list_af_names.sh || die
}

src_configure() {
	# ODR violations (bug #863524)
	filter-lto
	QA_POLICY_LTO_FLAVOR=none
	qa-policy-configure

	default
}

src_compile() {
	emake \
		AR="$(tc-getAR)" \
		CC="$(tc-getCC)" \
		CPP="$(tc-getCPP) -" \
		CXX="$(tc-getCXX)" \
		USE_SYSTEM=1
}

src_test() {
	emake CXX="$(tc-getCXX)" USE_SYSTEM=1 check
}

src_install() {
	emake \
		SBINDIR="${ED}/usr/bin" \
		CPP="$(tc-getCPP) -" \
		DESTDIR="${ED}" \
		USE_SYSTEM=1 \
		install

	emake -C ../init \
		APPARMOR_BIN_PREFIX="${ED}/usr/libexec" \
		SBINDIR="${ED}/usr/bin" \
		DESTDIR="${ED}" \
		DISTRO=unknown \
		install

	dodir /etc/apparmor.d/disable

	insinto /usr/lib/systemd/system
	doins "${FILESDIR}/apparmor.service"

	exeinto /usr/lib/apparmor/
	doexe ../init/apparmor.systemd
	dobin ../init/aa-teardown

	cleanup_install
	qa-policy-install
}
