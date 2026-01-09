# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Consolidating and extending hosts files from several well-curated sources"
HOMEPAGE="https://github.com/StevenBlack/hosts"
SNAPSHOT=743fec3a2b5aedcc1e256d77ecf3e44733d618ba
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
