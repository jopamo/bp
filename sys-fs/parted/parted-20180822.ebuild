# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic multilib-minimal

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="https://www.gnu.org/software/parted"
SRC_URI="https://1g4.org/files/parted-20180822.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+debug device-mapper nls readline selinux static-libs"
RESTRICT="test"

RDEPEND="
	>=sys-fs/e2fsprogs-1.27
	device-mapper? ( >=sys-fs/lvm2-2.02.45 )
	readline? ( >=lib-sys/readline-5.2:0= >=lib-sys/ncurses-5.7-r7:0= )
	selinux? ( lib-sys/libselinux )"
DEPEND="
	${RDEPEND}
	nls? ( >=sys-devel/gettext-0.12.1-r2 )
	dev-util/pkgconfig
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	use elibc_uclibc && append-libs -liconv

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
		$(use_enable device-mapper)
		$(use_enable nls)
		$(use_enable selinux)
		$(use_enable static-libs static)
		$(use_with readline)
		--disable-rpath
		--disable-silent-rules
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
