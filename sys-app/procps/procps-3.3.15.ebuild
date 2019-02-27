# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="standard informational utilities and process-handling tools"
HOMEPAGE="http://procps-ng.sourceforge.net/ https://gitlab.com/procps-ng/procps"
SRC_URI="mirror://sourceforge/${PN}-ng/${PN}-ng-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0/5" # libprocps.so
KEYWORDS="amd64 arm64"
IUSE="+kill modern-top nls +ncurses static-libs systemd test unicode"

COMMON_DEPEND="
	ncurses? ( lib-sys/ncurses )
	systemd? ( sys-app/systemd )
"
DEPEND="${COMMON_DEPEND}
	ncurses? ( dev-util/pkgconfig )
	systemd? ( dev-util/pkgconfig )
	test? ( dev-util/dejagnu )"
RDEPEND="
	${COMMON_DEPEND}
	kill? (
		!sys-app/coreutils[kill]
		!sys-app/util-linux[kill]
	)
	!<sys-app/sysvinit-2.88-r6
"

S="${WORKDIR}/${PN}-ng-${PV}"

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

src_install() {
	default
	find "${D}" -name '*.la' -delete || die
}
