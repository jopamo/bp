# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="The Cyrus SASL (Simple Authentication and Security Layer)"
HOMEPAGE="https://www.cyrusimap.org/sasl/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/cyrusimap/cyrus-sasl.git"
	inherit git-r3
else
SNAPSHOT=19289d272a29ef6c6197a3d60aa90d78faafe328
	SRC_URI="https://github.com/cyrusimap/cyrus-sasl/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/cyrus-sasl-${SNAPSHOT}
fi

LICENSE="BSD-with-attribution"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
