# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=2b6a8e5369ed37d64d1bafd3a546ec52e25acd26
SHORT=${SNAPSHOT:0:7}

inherit autotools flag-o-matic

DESCRIPTION="New GNU Portable Threads Library"
HOMEPAGE="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=npth.git"
SRC_URI="https://git.gnupg.org/cgi-bin/gitweb.cgi?p=${PN}.git;a=snapshot;h=${SNAPSHOT};sf=tgz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SHORT}

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
