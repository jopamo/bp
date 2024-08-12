# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files"

SNAPSHOT=5278dfcf98e89098326b3eb8a85d07120a8730f8
SRC_URI="https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="INTEL"
SLOT="0"
KEYWORDS="amd64"

RESTRICT="strip"

QA_PREBUILT="lib/firmware/*"

src_install() {
	insinto /usr/lib/firmware/
	doins -r intel-ucode
}
