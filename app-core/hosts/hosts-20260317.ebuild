# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Consolidating and extending hosts files from several well-curated sources"
HOMEPAGE="https://github.com/StevenBlack/hosts"
SNAPSHOT=5090055e2d36e9fc5539551656e1d8107a84ad7e
SRC_URI="https://github.com/StevenBlack/hosts/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+block"

src_install() {
	insinto /etc
	if use block ; then
		sed -i '/click.discord.com/d' "${S}"/hosts
		doins "${S}"/hosts
	else
		doins "${FILESDIR}"/hosts
	fi
}
