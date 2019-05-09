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
IUSE="bzip2 cjk gnutls idn ipv6 nls ssl"

S=${WORKDIR}/${MY_P}

src_configure() {
	local myconf=(
		--with-screen=ncursesw
		$(use_enable nls)
		$(use_enable idn idna)
		$(use_enable ipv6)
		$(use_enable cjk)
		$(use_with bzip2 bzlib)
	)

	econf "${myconf[@]}"
}

src_compile() {
	# generating translation files in parallel is currently broken
	use nls && emake -C po -j1
	emake
}
