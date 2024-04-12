# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org xtrans library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=656d27ed32af4082e8062c1d7c42b65ea3a6b80f
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxtrans/-/archive/${SNAPSHOT}/libxtrans-${SNAPSHOT}.tar.bz2 -> libxtrans-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxtrans-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doc"

DEPEND="xgui-live-app/util-macros"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable doc docs)
		$(use_with doc xmlto)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

