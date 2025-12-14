# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kernel-mod linux-info

DESCRIPTION="r8125 vendor driver for Realtek RTL8125 PCI-E NICs"
HOMEPAGE="https://www.realtek.com/Download/List?cate_id=584"
SRC_URI="https://github.com/Karlson2k/r8125/releases/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="multi-tx-q ptp rss use-firmware"

PATCHES=(
	"${FILESDIR}/${P}-ptp-linux-6.11.patch"
)

CONFIG_CHECK="~!R8169"
WARNING_R8169="CONFIG_R8169 is enabled. ${PN} will not be loaded unless kernel driver Realtek 8169 PCI Gigabit Ethernet (CONFIG_R8169) is DISABLED."

src_compile() {
	# The module listing replaces the old MODULE_NAMES variable.
	# Format: "moduleName=libdir:srcdir:objdir(:target)"
	# The last (:modules) is optional if your Makefile builds with default target,
	# but here we keep it for consistency since the old ebuild used BUILD_TARGETS="modules".
	local modlist=(
		"r8125=net:src:src:modules"
	)

	# Environment variables that replace BUILD_PARAMS go here.
	local modargs=(
		"KERNELDIR=${KV_DIR}"
		"ENABLE_PTP_SUPPORT=$(usex ptp y n)"
		"ENABLE_RSS_SUPPORT=$(usex rss y n)"
		"ENABLE_MULTIPLE_TX_QUEUE=$(usex multi-tx-q y n)"
		"ENABLE_USE_FIRMWARE_FILE=$(usex use-firmware y n)"
	)

	kernel-mod_src_compile
}
