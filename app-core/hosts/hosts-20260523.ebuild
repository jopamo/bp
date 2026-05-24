# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Consolidating and extending hosts files from several well-curated sources"
HOMEPAGE="https://github.com/StevenBlack/hosts"
SNAPSHOT=c23f146657534a547190ed71f58b56d603718c99
SRC_URI="https://github.com/StevenBlack/hosts/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+block"

src_install() {
	local hosts_file
	if use block ; then
		sed -i '/click.discord.com/d' "${S}"/hosts
		hosts_file="${S}"/hosts
	else
		hosts_file="${FILESDIR}"/hosts
	fi

	insinto /etc
	doins "${hosts_file}"

	insinto /usr/share/factory/etc
	doins "${hosts_file}"
}
