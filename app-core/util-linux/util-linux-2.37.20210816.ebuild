# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Various useful Linux utilities"
HOMEPAGE="https://www.kernel.org/pub/linux/utils/util-linux/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/karelzak/util-linux.git"
	EGIT_BRANCH="stable/v$(ver_cut 1-2)"
else
	SNAPSHOT=f59c8fd38dfee24b93ed54a6984f879499c34ec7
	SRC_URI="https://github.com/karelzak/util-linux/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2 LGPL-2.1 BSD-4 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+agetty build caps chfn-chsh cramfs fdformat hwclock +kill +libblkid
+libuuid line +login +mount mountpoint ncurses +nologin pam partx raw readline
rename rfkill +schedutils static-libs +su +suid +sulogin switch_root systemd test
tty-helpers udev uuidd vipw"

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
	dev-util/pkgconf
	test? ( sys-devel/bc )
	sys-kernel/linux-headers
"

src_prepare() {
	po/update-potfiles || die
	default
	eautoreconf
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	local myconf=(
		$(use_enable agetty)
		$(use_enable caps setpriv)
		$(use_enable chfn-chsh)
		$(use_enable cramfs)
		$(use_enable fdformat)
		$(use_enable hwclock)
		$(use_enable kill)
		$(use_enable libblkid)
		$(use_enable libuuid)
		$(use_enable line)
		$(use_enable login)
		$(use_enable mount)
		$(use_enable mountpoint)
		$(use_enable nologin)
		$(use_enable partx)
		$(use_enable raw)
		$(use_enable rename)
		$(use_enable rfkill)
		$(use_enable schedutils)
		$(use_enable static-libs static)
		$(use_enable su)
		$(use_enable suid makeinstall-chown)
		$(use_enable suid makeinstall-setuid)
		$(use_enable sulogin)
		$(use_enable switch_root)
		$(use_enable tty-helpers mesg)
		$(use_enable tty-helpers wall)
		$(use_enable tty-helpers write)
		$(use_enable uuidd)
		$(use_enable vipw)
		$(use_with readline)
		$(use_with systemd)
		$(use_with udev)
		$(usex ncurses '' '--without-tinfo')
		$(usex ncurses '' '--without-ncurses')
		--with-systemdsystemunitdir=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false")
		--enable-fs-paths-extra="${EPREFIX}/usr/sbin:${EPREFIX}/bin:${EPREFIX}/usr/bin"
		--disable-more
		--disable-nls
		--without-python
		--disable-fsck
		--enable-widechar
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
