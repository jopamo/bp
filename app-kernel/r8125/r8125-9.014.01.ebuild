# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

DESCRIPTION="r8125 vendor driver for Realtek RTL8125 PCI-E NICs"
HOMEPAGE="https://www.realtek.com/Download/List?cate_id=584"
SRC_URI="https://github.com/Karlson2k/r8125/releases/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+multi-tx-q ptp +rss use-firmware"

MODULE_NAMES="r8125(net:${S}/src)"
BUILD_TARGETS="modules"

PATCHES=(
	"${FILESDIR}/${P}-ptp-linux-6.11.patch"
)

CONFIG_CHECK="~!R8169"
WARNING_R8169="CONFIG_R8169 is enabled. ${PN} will not be loaded unless kernel driver Realtek 8169 PCI Gigabit Ethernet (CONFIG_R8169) is DISABLED."

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELDIR=${KV_DIR}"
	BUILD_PARAMS+=" ENABLE_PTP_SUPPORT=$(usex ptp y n)"
	BUILD_PARAMS+=" ENABLE_RSS_SUPPORT=$(usex rss y n)"
	BUILD_PARAMS+=" ENABLE_MULTIPLE_TX_QUEUE=$(usex multi-tx-q y n)"
	BUILD_PARAMS+=" ENABLE_USE_FIRMWARE_FILE=$(usex use-firmware y n)"
}
