# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="master"

DESCRIPTION="console display library"
HOMEPAGE="http://invisible-island.net/ncurses/ https://www.gnu.org/software/ncurses/"
SNAPSHOT=d5dc8a4a7c15474652d73dee37d905c8205f6ab4
SRC_URI="https://github.com/ThomasDickey/ncurses-snapshots/archive/${SNAPSHOT}.tar.gz -> ncurses-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/ncurses-snapshots-${SNAPSHOT}"

MY_P="ncurses-$(ver_rs 2 -)"

SRC_URI="https://invisible-mirror.net/archives/ncurses/current/${MY_P}.tgz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	sed -i 's/for opt in -L$libdir @EXTRA_PKG_LDFLAGS@ @LIBS@/for opt in -L$libdir @LIBS@/' \
    	misc/gen-pkgconfig.in

	sed -i 's/for opt in -L$libdir @EXTRA_PKG_LDFLAGS@ $LIBS/for opt in -L$libdir $LIBS/' \
    	misc/ncurses-config.in
}

src_configure() {
    local myconf=(
		--disable-rpath-hack
		--disable-setuid-environ
		--disable-stripping
		--with-cxx-shared
        --disable-root-access
        --enable-colorfgbg
        --enable-echo
        --enable-ext-colors
        --enable-overwrite
        --enable-pc-files
        --enable-symlinks
        --enable-termcap
        --enable-widec
        --with-cxx-binding
        --with-pkg-config-libdir="${EPREFIX}"/usr/lib/pkgconfig
        --with-pthread
        --with-shared
        --with-symlinks
        --with-terminfo-dirs="${EPREFIX}"/usr/share/terminfo
        --with-termlib
        --with-profile
        --without-debug
        --without-manpages
        --with-normal
    )
    ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
    default

    local i

    for i in ncurses "ncurses++" form panel menu tinfo ; do
        echo "INPUT(-l${i}tw)" > "${ED}"/usr/lib/lib${i}.so
        echo "INPUT(-l${i}tw)" > "${ED}"/usr/lib/lib${i}w.so
        dosym -r /usr/lib/pkgconfig/${i}tw.pc /usr/lib/pkgconfig/${i}.pc
        dosym -r /usr/lib/pkgconfig/${i}tw.pc /usr/lib/pkgconfig/${i}w.pc
    done

    echo "INPUT(-lncursestw)" > "${ED}"/usr/lib/libcurses.so

    use static-libs || find "${ED}"/usr/ -name '*.a' -delete
    use static-libs || find "${ED}" -name '*.la' -delete
}
