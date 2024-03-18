# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="The Cyrus SASL (Simple Authentication and Security Layer)"
HOMEPAGE="https://www.cyrusimap.org/sasl/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/cyrusimap/cyrus-sasl.git"
	inherit git-r3
else
	SNAPSHOT=34ce54223874cb3d994b0c64d71951e6bb6ba936
	SRC_URI="https://github.com/cyrusimap/cyrus-sasl/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="BSD-with-attribution"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
