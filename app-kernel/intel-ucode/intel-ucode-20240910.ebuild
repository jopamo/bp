# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files"

SNAPSHOT=fbfe741896c55b36fcbf0560a68be96286103556
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
