# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files"

SNAPSHOT=8ac9378a84879e81c503e09f344560b3dd7f72df
SRC_URI="https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Intel-Linux-Processor-Microcode-Data-Files-${SNAPSHOT}"

LICENSE="INTEL"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip"

QA_PREBUILT="lib/firmware/*"

src_install() {
	insinto /usr/lib/firmware/
	doins -r intel-ucode
}
