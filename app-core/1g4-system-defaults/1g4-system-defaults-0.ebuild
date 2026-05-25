# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit doins

DESCRIPTION="1g4 base system policy defaults"
HOMEPAGE="https://1g4.org/"
S=${WORKDIR}

LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="ipv6 router +server user-namespaces"

RDEPEND="
	app-core/kmod
	app-core/systemd
	app-core/util-linux
"

src_install() {
	insinto /usr/lib/corepkg/declarations/system
	doins "${FILESDIR}"/20-memory.conf

	insinto /usr/lib/modules-load.d
	newins "${FILESDIR}"/1g4-zram.modules-load 1g4-zram.conf

	insinto /usr/lib/modprobe.d
	newins "${FILESDIR}"/1g4-zram.modprobe 1g4-zram.conf

	insinto /usr/lib/sysctl.d
	newins "${FILESDIR}"/1g4-memory.sysctl 1g4-memory.conf
	newins "${FILESDIR}"/sysctl-hardening.conf 00-hardening.conf

	if ! use ipv6; then
		newins "${FILESDIR}"/sysctl-disable-ipv6.conf 10-disable-ipv6.conf
	fi

	if use server; then
		newins "${FILESDIR}"/sysctl-hardening-server.conf 80-server.conf
	fi

	if use router; then
		newins "${FILESDIR}"/sysctl-router.conf 90-router.conf
	fi

	if use user-namespaces; then
		echo "user.max_user_namespaces = 10000" > "${T}/99-max-user-namespaces.conf"
		doins "${T}/99-max-user-namespaces.conf"
	fi

	exeinto /usr/libexec
	newexe "${FILESDIR}"/1g4-zram-setup 1g4-zram-setup

	systemd_newunit "${FILESDIR}"/1g4-zram-setup.service 1g4-zram-setup.service
	systemd_enable_service sysinit.target 1g4-zram-setup.service
}

pkg_postinst() {
	elog "Installed 1g4 zram defaults."
	elog "The service is enabled for boot."
	elog "This package does not reset or reconfigure active swap during merge."
	elog "To apply on the running system explicitly:"
	elog "  systemctl daemon-reload"
	elog "  systemctl start 1g4-zram-setup.service"
}
