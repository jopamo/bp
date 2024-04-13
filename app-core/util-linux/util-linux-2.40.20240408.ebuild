# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="a random collection of Linux utilities"
HOMEPAGE="https://github.com/util-linux/util-linux"

SNAPSHOT=5de7172a3e59b6861bff0b7baa6f0cad321ab3ff
SRC_URI="https://github.com/util-linux/util-linux/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/util-linux-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 BSD-4 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="
	agetty btrfs build cal caps chfn-chsh chmem cramfs eject
	fallocate fdformat fstrim hardlink hwclock ipcmk ipcrm ipcs
	irqtop kill libblkid libuuid last line logger login
	losetup lscpu lsfd lsirq lslogins lsmem lsns mesg mkfs
	mount mountpoint ncurses newgrp nologin nsenter pam partx
	pipesz pivot_root python raw readline rename rfkill runuser
	schedutils scriptutils setpriv static-libs su suid
	sulogin swapon switch_root systemd test tty-helpers tunelp
	udev ul unshare utmpdump uuidd vipw wdctl whereis wipefs
	zramctl
"

DEPEND="
	caps? ( lib-core/libcap-ng )
	cramfs? ( lib-core/zlib )
	ncurses? ( virtual/curses )
	pam? ( lib-core/pam )
	readline? ( lib-core/readline )
	kill? (
		!app-core/coreutils[kill]
		!app-core/procps[kill]
	)
	!build? ( systemd? ( app-core/systemd ) )
"

BDEPEND="
	app-dev/pkgconf
	test? ( app-util/bc )
	app-kernel/linux-headers
"

src_prepare() {
	po/update-potfiles || die
	default
	eautoreconf
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	use wipefs && filter-flags -Wl,-z,defs

	local myconf=(
		$(use_enable agetty)
		$(use_enable cal)
		$(use_enable caps setpriv)
		$(use_enable chfn-chsh)
		$(use_enable chmem)
		$(use_enable cramfs)
		$(use_enable eject)
		$(use_enable fallocate)
		$(use_enable fdformat)
		$(use_enable fstrim)
		$(use_enable hardlink)
		$(use_enable hwclock)
		$(use_enable ipcmk)
		$(use_enable ipcrm)
		$(use_enable ipcs)
		$(use_enable irqtop)
		$(use_enable kill)
		$(use_enable last)
		$(use_enable libblkid)
		$(use_enable libuuid)
		$(use_enable line)
		$(use_enable logger)
		$(use_enable login)
		$(use_enable losetup)
		$(use_enable lscpu)
		$(use_enable lsfd)
		$(use_enable lsirq)
		$(use_enable lslogins)
		$(use_enable lsmem)
		$(use_enable lsns)
		$(use_enable mkfs)
		$(use_enable mount)
		$(use_enable mountpoint)
		$(use_enable newgrp)
		$(use_enable nologin)
		$(use_enable nsenter)
		$(use_enable partx)
		$(use_enable pipesz)
		$(use_enable pivot_root)
		$(use_enable raw)
		$(use_enable rename)
		$(use_enable rfkill)
		$(use_enable runuser)
		$(use_enable schedutils)
		$(use_enable scriptutils)
		$(use_enable static-libs static)
		$(use_enable su)
		$(use_enable suid makeinstall-chown)
		$(use_enable suid makeinstall-setuid)
		$(use_enable sulogin)
		$(use_enable swapon)
		$(use_enable switch_root)
		$(use_enable tty-helpers mesg)
		$(use_enable tty-helpers wall)
		$(use_enable tty-helpers write)
		$(use_enable tunelp)
		$(use_enable ul)
		$(use_enable unshare)
		$(use_enable utmpdump)
		$(use_enable uuidd)
		$(use_enable vipw)
		$(use_enable wdctl)
		$(use_enable whereis)
		$(use_enable wipefs)
		$(use_enable zramctl)
		$(use_with btrfs)
		$(use_with ncurses tinfo)
		$(use_with ncurses ncursesw)
		$(use_with python)
		$(use_with readline)
		$(use_with systemd)
		$(use_with udev)
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--enable-fs-paths-extra="${EPREFIX}/usr/sbin:${EPREFIX}/usr/bin"
		--disable-asciidoc
		--disable-bfs
		--disable-cramfs
		--disable-fsck
		--disable-minix
		--disable-more
		--disable-nls
		--disable-plymouth_support
		--disable-rpath
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
