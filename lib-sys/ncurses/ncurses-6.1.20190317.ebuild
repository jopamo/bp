# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs versionator

DESCRIPTION="console display library"
HOMEPAGE="http://invisible-island.net/ncurses/ https://www.gnu.org/software/ncurses/"

MY_P="${PN}-$(replace_version_separator 2 -)"
SRC_URI="https://invisible-mirror.net/archives/ncurses/current/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"

SLOT="0/6"
KEYWORDS="amd64 arm64"
IUSE="gpm static-libs test"

DEPEND="gpm? ( lib-sys/gpm )"

PATCHES=(
	"${FILESDIR}/${PN}-6.0-unified.patch"
)

src_configure() {
	unset TERMINFO #115036
	tc-export_build_env BUILD_{CC,CPP}
	BUILD_CPPFLAGS+=" -D_GNU_SOURCE" #214642

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_with gpm gpm libgpm.so.1)
		--disable-termcap
		--with-terminfo-dirs="${EPREFIX}"/usr/share/terminfo
		--enable-pc-files
		--with-pkg-config="$(tc-getPKG_CONFIG)"
		--with-pkg-config-libdir="${EPREFIX}/usr/lib64/pkgconfig"
		--without-normal
		--with-symlinks
		--enable-overwrite
		--with-shared
		--without-debug
		--enable-colorfgbg
		--enable-echo
		--enable-widec
		--with-pthread
		--enable-ext-colors
		--without-manpages
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	local lib

	for lib in ncurses form panel menu ; do
    	echo "INPUT(-l${lib}tw)" > "${ED}"/usr/lib64/lib${lib}.so
    	echo "INPUT(-l${lib}tw)" > "${ED}"/usr/lib64/lib${lib}w.so
    	ln -sfv ${lib}tw.pc        "${ED}"/usr/lib64/pkgconfig/${lib}.pc
    	ln -sfv ${lib}tw.pc        "${ED}"/usr/lib64/pkgconfig/${lib}w.pc
	done

	echo "INPUT(-lncursestw)" > "${ED}"/usr/lib64/libcurses.so

	use static-libs || find "${ED}"/usr/ -name '*.a' -delete
}
