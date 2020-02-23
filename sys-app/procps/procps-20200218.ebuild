# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=5cd29e5093efa3c6ee9c5310b64347f1d54b707d

inherit autotools

DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="http://procps-ng.sourceforge.net/ https://gitlab.com/procps-ng/procps"
SRC_URI="https://gitlab.com/procps-ng/procps/-/archive/${SNAPSHOT}/psmisc-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="+kill modern-top nls +ncurses static-libs systemd test unicode"

COMMON_DEPEND="
	ncurses? ( lib-sys/ncurses )
	systemd? ( sys-app/systemd )
"
DEPEND="${COMMON_DEPEND}
	ncurses? ( dev-util/pkgconf )
	systemd? ( dev-util/pkgconf )
	test? ( dev-util/dejagnu )"
RDEPEND="
	${COMMON_DEPEND}
	kill? (
		!sys-app/coreutils[kill]
		!sys-app/util-linux[kill]
	)
"

src_prepare() {
	po/update-potfiles
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable kill)
		$(use_enable modern-top)
		$(use_with ncurses)
		$(use_enable nls)
		$(use_enable static-libs static)
		$(use_with systemd)
		$(use_enable unicode watch8bit)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake check </dev/null
}
