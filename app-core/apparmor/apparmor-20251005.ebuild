# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic doins toolchain-funcs linux-info

DESCRIPTION="Userspace utils and init scripts for the AppArmor application security system"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=d32985d9d74ff46c0b7fa3dea76b3ae3de605edb
SRC_URI="https://gitlab.com/apparmor/apparmor/-/archive/${SNAPSHOT}/apparmor-${SNAPSHOT}.tar.bz2 -> apparmor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/apparmor-${SNAPSHOT}/parser"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="~lib-core/libapparmor-${PV}"
DEPEND="${RDEPEND}"

CONFIG_CHECK="SECURITY_APPARMOR"

src_prepare() {
	default

	sed -e '/^AALIB =/ s/-Bstatic/-Bdynamic/' -i Makefile || die

	# Install rc.apparmor.functions to Gentoo-appropriate location
	sed -e '/install-indep: indep/a\\tinstall -m 755 -d ${DESTDIR}/usr/libexec' -i Makefile || die
	sed -e 's:rc.apparmor.functions $(APPARMOR_BIN_PREFIX):rc.apparmor.functions ${DESTDIR}/usr/libexec:' \
		-i Makefile || die
	sed -e ':^APPARMOR_FUNCTIONS=: s:/lib/apparmor/:/usr/libexec/:' -i apparmor.systemd || die
	sed -e 's:\. /lib/apparmor/rc.apparmor.functions:\. /usr/libexec/rc.apparmor.functions:' -i profile-load || die

	# remove warning about missing file that controls features
	# we don't currently support
	sed -e "/installation problem/ctrue" -i rc.apparmor.functions || die

	# bug 634782
	sed -e "s/cpp/$(tc-getCPP) -/" \
		-i ../common/list_capabilities.sh \
		-i ../common/list_af_names.sh || die
}

src_configure() {
	# ODR violations (bug #863524)
	filter-lto

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
	    USR_SBINDIR="${ED}/usr/bin" \
		CPP="$(tc-getCPP) -" \
		DESTDIR="${ED}" \
		DISTRO="unknown" \
		USE_SYSTEM=1 \
		install

	dodir /etc/apparmor.d/disable

	systemd_newunit "${FILESDIR}/apparmor.service" apparmor.service

	exeinto /usr/lib/apparmor/
	doexe apparmor.systemd

	dedup_symlink "${ED}"
	cleanup_install
}
