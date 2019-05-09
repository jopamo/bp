# Distributed under the terms of the GNU General Public License v2

EAPI=6

# VERSIONING SCHEME TRANSLATION
# rel.		:	_p
# pre.		:	_rc
# dev.		:	_pre

case ${PV} in
	*_pre*) MY_P="${PN}${PV/_pre/dev.}" ;;
	*_rc*)  MY_P="${PN}${PV/_rc/pre.}" ;;
	*_p*|*) MY_P="${PN}${PV/_p/rel.}" ;;
esac

DESCRIPTION="An excellent console-based web browser with ssl support"
HOMEPAGE="http://lynx.invisible-island.net/"
SRC_URI="http://invisible-mirror.net/archives/lynx/tarballs/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

S=${WORKDIR}/${MY_P}

src_configure() {
	local myconf=(
		--with-zlib
		--with-bzlib
		--with-ssl
		--with-screen=ncursesw
	)

	econf "${myconf[@]}"
}

src_compile() {
	# generating translation files in parallel is currently broken
	use nls && emake -C po -j1
	emake
}

src_install() {
	default
	sed -e '/#LOCALE/     a LOCALE_CHARSET:TRUE'     \
    -i "${ED}"/etc/lynx/lynx.cfg

    sed -e '/#DEFAULT_ED/ a DEFAULT_EDITOR:vi'       \
    -i "${ED}"/etc/lynx/lynx.cfg
}

