# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Intel CPU microcode update blobs for early-boot loading"
HOMEPAGE="https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files"
SNAPSHOT=4ded52b4b0e1d60e83259cc88d1f5ad22f71a63e
SRC_URI="https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
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
