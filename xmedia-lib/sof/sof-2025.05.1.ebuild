# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Sound Open Firmware"
HOMEPAGE="https://www.sofproject.org"
SRC_URI="https://github.com/thesofproject/sof-bin/releases/download/v${PV}/sof-bin-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/sof-bin-${PV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

IUSE="tools"

QA_PREBUILT="usr/bin/sof-ctl
	usr/bin/sof-logger
	usr/bin/sof-probes"

src_install() {
	dodir /usr/lib/firmware/intel
	dodir /usr/bin
	FW_DEST="${D}/usr/lib/firmware/intel" TOOLS_DEST="${D}/usr/bin" "${S}/install.sh" || die

	if ! use tools ; then
		rm -rv "${D}"/usr/bin || die
	fi
}
