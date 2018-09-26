# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Async Resolver Library from OpenBSD/OpenSMTPD"
HOMEPAGE="https://github.com/OpenSMTPD/libasr"

SNAPSHOT=b6f3a1aadf520b427d5c5e41900a2c353370b708
SRC_URI="https://github.com/OpenSMTPD/libasr/archive/${SNAPSHOT}.zip -> ${P}.zip"
S=${WORKDIR}/${PN}-${SNAPSHOT}
KEYWORDS="amd64 arm64 x86"

LICENSE="ISC BSD BSD-1 BSD-2 BSD-4"
SLOT="0"
IUSE="static-libs"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
