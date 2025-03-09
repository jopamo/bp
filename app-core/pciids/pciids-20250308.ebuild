# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The pci.ids file"
HOMEPAGE="https://github.com/pciutils/pciids"

SNAPSHOT=7d41a84cee090180f47fba300476882f20545f69
SRC_URI="https://github.com/pciutils/pciids/archive/${SNAPSHOT}.tar.gz -> pciids-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	insinto /usr/share/hwdata/
	doins pci.ids
}
