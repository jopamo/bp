# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=2e7f38707a1fa5949ccf3655fa33a90c8b8a2ffc

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
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--docdir='$(datarootdir)'/doc/${PF}
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
