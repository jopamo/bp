# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic linux-info meson systemd toolchain-funcs user git-r3

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"

EGIT_REPO_URI="https://github.com/systemd/systemd-stable.git"
EGIT_BRANCH="v$(ver_cut 1)-stable"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"

DEPEND="
	sys-app/acl
	app-compression/bzip2
	app-text/docbook-xml-dtd
	app-text/docbook-xsl-stylesheets
	dev-util/gperf
	dev-util/pkgconf
	lib-dev/libxslt:0
	lib-sys/libcap
	sys-app/coreutils
	sys-app/procps[kill(+)]
	sys-app/util-linux
	sys-devel/gettext
"

PDEPEND=">=sys-app/dbus-1.9.8[systemd]"

append-cflags -Wno-error=format-truncation

PATCHES=(
		"${FILESDIR}/disable_audit.patch"
		)

src_configure() {
	local emesonargs=(
		-Dacl=true
		-Dadm-group=false
		-Dapparmor=false
		-Daudit=false
		-Dbacklight=false
		-Dbinfmt=false
		-Dblkid=false
		-Dbzip2=false
		-Dcoredump=false
		-Ddbus=false
		-Ddefault-hierarchy=unified
		-Ddefault-kill-user-processes=false
		-Ddns-servers=""
		-Defi=false
		-Delfutils=false
		-Denvironment-d=false
		-Dfirstboot=false
		-Dgcrypt=false
		-Dglib=false
		-Dgnuefi=false
		-Dgnutls=false
		-Dgshadow=false
		-Dhalt-local=""
		-Dhibernate=false
		-Dhostnamed=false
		-Dhwdb=false
		-Didn=false
		-Dima=false
		-Dimportd=false
		-Dkill-path=/usr/bin/kill
		-Dkmod=false
		-Dldconfig=false
		-Dlibcryptsetup=false
		-Dlibcurl=false
		-Dlibidn2=false
		-Dlibidn=false
		-Dlibiptc=false
		-Dlocaled=false
		-Dlogind=false
		-Dlz4=false
		-Dmachined=true
		-Dmanpages=false
		-Dmicrohttpd=false
		-Dmyhostname=false
		-Dnetworkd=true
		-Dnls=false
		-Dnss-myhostname=false
		-Dnss-mymachines=false
		-Dnss-resolve=false
		-Dnss-systemd=false
		-Dntp-servers=""
		-Dpam=true
		-Dpamlibdir="${EPREFIX}"/usr/lib/security
		-Dpolkit=false
		-Dportabled=false
		-Dqrencode=false
		-Dquotacheck=false
		-Drandomseed=false
		-Drc-local=""
		-Dresolve=false
		-Drfkill=false
		-Drootlibdir="${EPREFIX}"/usr/lib
		-Drootprefix="${EPREFIX}"/usr
		-Dseccomp=true
		-Dselinux=false
		-Dsmack=false
		-Dsysusers=false
		-Dsysvinit-path=""
		-Dsysvrcnd-path=""
		-Dtelinit-path=""
		-Dtests=false
		-Dtimedated=false
		-Dtimesyncd=false
		-Dtmpfiles=true
		-Dtpm=false
		-Dutmp=false
		-Dvconsole=false
		-Dwheel-group=false
		-Dxkbcommon=false
		-Dxz=false
		-Dzlib=false
  	)
	meson_src_configure
}

src_install() {
	meson_src_install

	dosym ../sysctl.conf /etc/sysctl.d/99-sysctl.conf

	rm -rf "${ED}"/etc/systemd/system/* || die
	rm -rf "${ED}"/etc/init.d
	rm -f "${ED}"/var/log/README
	rm -rf "${ED}"/usr/share/polkit-1
	rm -f "${ED}"/etc/systemd/logind.conf

	local udevdir=/usr/lib/udev

	keepdir /var/lib/systemd
	keepdir /var/log/journal

	mkdir -p "${ED}"/etc/systemd/user && keepdir /etc/systemd/user

	rm -rf etc/udev
	rm -f usr/bin/udevadm
	rm -f usr/lib64/systemd/system/initrd-udevadm-cleanup-db.service
	rm -f usr/lib64/systemd/system/sockets.target.wants/systemd-udevd-control.socket
	rm -f usr/lib64/systemd/system/sockets.target.wants/systemd-udevd-kernel.socket
	rm -f usr/lib64/systemd/system/sysinit.target.wants/systemd-udev-trigger.service
	rm -f usr/lib64/systemd/system/sysinit.target.wants/systemd-udevd.service
	rm -f usr/lib64/systemd/system/systemd-hwdb-update.service
	rm -f usr/lib64/systemd/system/systemd-udev-settle.service
	rm -f usr/lib64/systemd/system/systemd-udev-trigger.service
	rm -f usr/lib64/systemd/system/systemd-udevd-control.socket
	rm -f usr/lib64/systemd/system/systemd-udevd-kernel.socket
	rm -f usr/lib64/systemd/system/systemd-udevd.service
	rm -f usr/lib64/systemd/systemd-udevd
	rm -fr usr/lib64/udev

	rm -f usr/bin/busctl
	rm -f usr/bin/systemd-analyze
	rm -f usr/bin/systemd-cat
	rm -f usr/bin/systemd-cgls
	rm -f usr/bin/systemd-cgtop
	rm -f usr/bin/systemd-delta
	rm -f usr/bin/systemd-detect-virt
	rm -f usr/bin/systemd-escape
	rm -f usr/bin/systemd-machine-id-setup
	rm -f usr/bin/systemd-mount
	rm -f usr/bin/systemd-notify
	rm -f usr/bin/systemd-nspawn
	rm -f usr/bin/systemd-path
	rm -f usr/bin/systemd-run
	rm -f usr/bin/systemd-socket-activate
	rm -f usr/bin/systemd-stdio-bridge

	rm -fr etc/kernel
	rm -f usr/bin/kernel-install
	rm -fr usr/lib64/kernel

	rm -f usr/lib64/systemd/system/systemd-kexec.service

	# systemd-update system is nice and useful, but is not essential
	rm -f usr/lib64/systemd/system/sysinit.target.wants/systemd-update-done.service
	rm -f usr/lib64/systemd/system/system-update.target
	rm -f usr/lib64/systemd/system/systemd-update-done.service
	rm -f usr/lib64/systemd/system-generators/systemd-system-update-generator
	rm -f usr/lib64/systemd/systemd-update-done

	rm -f usr/lib64/systemd/system/sysinit.target.wants/systemd-update-done.service
	rm -f usr/lib64/systemd/system/system-update.target
	rm -f usr/lib64/systemd/system/systemd-update-done.service
	rm -f usr/lib64/systemd/system-generators/systemd-system-update-generator
	rm -f usr/lib64/systemd/systemd-update-done

	rm -f  usr/lib64/systemd/systemd-sleep
	rm -fr usr/lib64/systemd/system-sleep/
	rm -f  usr/lib64/systemd/system/systemd-suspend.service

	rm -fr etc/xdg
	rm -fr etc/X11

	rm -fr etc/init.d
	rm -f usr/lib64/systemd/system-generators/systemd-rc-local-generator
	rm -f usr/lib64/systemd/system-generators/systemd-sysv-generator
	rm -f usr/lib64/systemd/system/sockets.target.wants/systemd-initctl.socket
	rm -f usr/lib64/systemd/system/systemd-initctl.service
	rm -f usr/lib64/systemd/system/systemd-initctl.socket
	rm -f usr/lib64/systemd/systemd-initctl
	rm -f usr/lib64/systemd/systemd/halt-local.service
	rm -f usr/lib64/systemd/systemd/rc-local.service

}

pkg_postinst() {
	newusergroup messagebus
	enewgroup systemd-journal
	newusergroup systemd-network

	systemd_update_catalog
	systemd_reenable getty@tty1.service remote-fs.target
	systemd_reenable systemd-networkd.service
}
