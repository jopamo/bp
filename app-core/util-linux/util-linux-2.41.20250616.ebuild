# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="stable/v$(ver_cut 1-2)"

inherit meson flag-o-matic

DESCRIPTION="a random collection of Linux utilities"
HOMEPAGE="https://github.com/util-linux/util-linux"
SNAPSHOT=48fbe43a5f2a252342fb4dea24702847608b3db1
SRC_URI="https://github.com/util-linux/util-linux/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 BSD-4 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="
    agetty audit bash-completion bfs bits blkdiscard blkpr blkzone blockdev
    btrfs cal chcpu chfn-chsh chmem choom col colcrt colrm cramfs cryptsetup
    cryptsetup-dlopen ctrlaltdel dmesg econf eject enosys exch fadvise fallocate
    fdformat fdisks findfs findmnt flock fsck fsfreeze fstrim getopt hardlink
    hexdump hwclock ipcmk ipcrm ipcs irqtop isosize kill last ldattach libblkid
    libfdisk liblastlog2 libmount libpcre2-posix libsmartcols libuser libutil
    libuuid libutempter line logger login look losetup lsblk lsclocks lsfd lsirq
    lslocks lslogins lsmem lsns magic mcookie mesg minix mkfs more mount
    mountpoint namei ncurses newgrp nls nologin nsenter pam
    partx pg pipesz pivot_root pylibmount python raw readline rename rev rfkill
    rtcwake runuser schedutils script scriptutils selinux setarch setpriv
    setterm slang smack su sulogin swapoff swapon switch_root systemd sysvinit test
    tinfo translate-docs tunelp ul unshare utmpdump uuidd vipw waitpid wall
    wdctl whereis widechar wipefs write zlib zramctl
"

DEPEND="
	app-fs/cryptsetup
	lib-core/libcap-ng
	cramfs? ( lib-core/zlib )
	ncurses? ( virtual/curses )
	pam? ( lib-core/pam )
	readline? ( lib-core/readline )
	kill? (
		!app-core/coreutils[kill]
		!app-core/procps[kill]
	)
"

BDEPEND="
	app-dev/pkgconf
	test? ( app-util/bc )
	app-kernel/linux-headers
"

src_configure() {
	local emesonargs=(
    $(meson_feature  tinfo)
    $(meson_feature ncurses ncursesw)
    $(meson_feature  slang)
    $(meson_feature  cryptsetup)
    $(meson_feature  cryptsetup-dlopen)
    $(meson_feature  zlib)
    $(meson_feature  readline)
    $(meson_feature  nls)
    $(meson_feature  libutil)
    $(meson_feature  libutempter)
    $(meson_feature  libpcre2-posix)
    $(meson_feature  libuser)
    $(meson_feature  selinux)
    $(meson_feature  audit)
    $(meson_feature  smack)
    $(meson_feature  magic)
    $(meson_feature  econf)
    $(meson_feature  systemd)
    $(meson_feature  sysvinit)
    $(meson_feature  btrfs)
    $(meson_feature  widechar)
    $(meson_feature  translate-docs)

    $(meson_feature agetty          build-agetty)
    $(meson_feature bash-completion build-bash-completion)
    $(meson_feature bfs             build-bfs)
    $(meson_feature bits            build-bits)
    $(meson_feature blkdiscard      build-blkdiscard)
    $(meson_feature blkpr           build-blkpr)
    $(meson_feature blkzone         build-blkzone)
    $(meson_feature blockdev        build-blockdev)
    $(meson_feature cal             build-cal)
    $(meson_feature chcpu           build-chcpu)
    $(meson_feature chfn-chsh       build-chfn-chsh)
    $(meson_feature chmem           build-chmem)
    $(meson_feature choom           build-choom)
    $(meson_feature col             build-col)
    $(meson_feature colcrt          build-colcrt)
    $(meson_feature colrm           build-colrm)
    $(meson_feature cramfs          build-cramfs)
    $(meson_feature ctrlaltdel      build-ctrlaltdel)
    $(meson_feature dmesg           build-dmesg)
    $(meson_feature eject           build-eject)
    $(meson_feature enosys          build-enosys)
    $(meson_feature exch            build-exch)
    $(meson_feature fadvise         build-fadvise)
    $(meson_feature fallocate       build-fallocate)
    $(meson_feature fdformat        build-fdformat)
    $(meson_feature fdisks          build-fdisks)
    $(meson_feature findfs          build-findfs)
    $(meson_feature findmnt         build-findmnt)
    $(meson_feature flock           build-flock)
    $(meson_feature fsck            build-fsck)
    $(meson_feature fsfreeze        build-fsfreeze)
    $(meson_feature fstrim          build-fstrim)
    $(meson_feature getopt          build-getopt)
    $(meson_feature hardlink        build-hardlink)
    $(meson_feature hexdump         build-hexdump)
    $(meson_feature hwclock         build-hwclock)
    $(meson_feature ipcmk           build-ipcmk)
    $(meson_feature ipcrm           build-ipcrm)
    $(meson_feature ipcs            build-ipcs)
    $(meson_feature irqtop          build-irqtop)
    $(meson_feature isosize         build-isosize)
    $(meson_feature kill            build-kill)
    $(meson_feature last            build-last)
    $(meson_feature ldattach        build-ldattach)
    $(meson_feature libblkid        build-libblkid)
    $(meson_feature libfdisk        build-libfdisk)
    $(meson_feature liblastlog2     build-liblastlog2)
    $(meson_feature libmount        build-libmount)
    $(meson_feature libsmartcols    build-libsmartcols)
    $(meson_feature libuuid         build-libuuid)
    $(meson_feature line            build-line)
    $(meson_feature logger          build-logger)
    $(meson_feature login           build-login)
    $(meson_feature look            build-look)
    $(meson_feature losetup         build-losetup)
    $(meson_feature lsblk           build-lsblk)
    $(meson_feature lsclocks        build-lsclocks)
    $(meson_feature lsfd            build-lsfd)
    $(meson_feature lsirq           build-lsirq)
    $(meson_feature lslocks         build-lslocks)
    $(meson_feature lslogins        build-lslogins)
    $(meson_feature lsmem           build-lsmem)
    $(meson_feature lsns            build-lsns)
    $(meson_feature mcookie         build-mcookie)
    $(meson_feature mesg            build-mesg)
    $(meson_feature minix           build-minix)
    $(meson_feature mkfs            build-mkfs)
    $(meson_feature more            build-more)
    $(meson_feature mount           build-mount)
    $(meson_feature mountpoint      build-mountpoint)
    $(meson_feature namei           build-namei)
    $(meson_feature newgrp          build-newgrp)
    $(meson_feature nologin         build-nologin)
    $(meson_feature nsenter         build-nsenter)
    $(meson_feature pam			    build-pam-lastlog2)
    $(meson_feature partx           build-partx)
    $(meson_feature pg              build-pg)
    $(meson_feature pipesz          build-pipesz)
    $(meson_feature pivot_root      build-pivot_root)
    $(meson_feature pylibmount      build-pylibmount)
    $(meson_feature raw             build-raw)
    $(meson_feature rename          build-rename)
    $(meson_feature rev             build-rev)
    $(meson_feature rfkill          build-rfkill)
    $(meson_feature rtcwake         build-rtcwake)
    $(meson_feature runuser         build-runuser)
    $(meson_feature schedutils      build-schedutils)
    $(meson_feature script          build-script)
    $(meson_feature scriptutils     build-scriptutils)
    $(meson_feature setarch         build-setarch)
    $(meson_feature setpriv         build-setpriv)
    $(meson_feature setterm         build-setterm)
    $(meson_feature su              build-su)
    $(meson_feature sulogin         build-sulogin)
    $(meson_feature swapoff         build-swapoff)
    $(meson_feature swapon          build-swapon)
    $(meson_feature switch_root     build-switch_root)
    $(meson_feature tunelp          build-tunelp)
    $(meson_feature ul              build-ul)
    $(meson_feature unshare         build-unshare)
    $(meson_feature utmpdump        build-utmpdump)
    $(meson_feature uuidd           build-uuidd)
    $(meson_feature vipw            build-vipw)
    $(meson_feature waitpid         build-waitpid)
    $(meson_feature wall            build-wall)
    $(meson_feature wdctl           build-wdctl)
    $(meson_feature whereis         build-whereis)
    $(meson_feature wipefs          build-wipefs)
    $(meson_feature write           build-write)
    $(meson_feature zramctl         build-zramctl)

    $(meson_feature python build-python)
    -Dpython="${EPYTHON}"
    -Dpamlibdir="${EPREFIX}"/usr/lib/security
    -Dlogin-lastlogin=false
    -Dtty-setgid=true
	)
	meson_src_configure
}
