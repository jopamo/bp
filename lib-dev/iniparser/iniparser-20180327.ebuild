# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal autotools

DESCRIPTION="A free stand-alone ini file parsing library"
HOMEPAGE="http://ndevilla.free.fr/iniparser/"

SNAPSHOT=7b68537ac11fa62e923fd26aa87e206dc93a9a55
SRC_URI="https://github.com/ndevilla/iniparser/archive/${SNAPSHOT}.zip -> ${P}.zip"
S=${WORKDIR}/${PN}-${SNAPSHOT}
KEYWORDS="amd64 arm64 x86"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RESTRICT="test"

PATCHES=(
	"${FILESDIR}/${PN}-3.0-autotools.patch"
)

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
