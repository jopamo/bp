# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git"

SNAPSHOT=08bb5322f49b5828fb0d6acb20826e47a321ec3c
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/linux-firmware-${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/linux-firmware-${SNAPSHOT}"

LICENSE="linux-firmware ( BSD ISC MIT no-source-code ) GPL-2 GPL-2+ freedist"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="3com amdgpu amd-ucode ar3k ath10k ath11k ath6k atmel bnx2 brcm carl9170fw cbfw cis
ct2fw ctfw cxgb4 cypress dpaa2 i915 intel iwlwifi keyspan libertas liquidio
mediatek mellanox meson moxa mrvl mwl8k mwlwifi myri10ge netronome nouveau
phanfw qca qcom qed radeon rsi rtl_bt rtl_nic rtlwifi rtw88 ti ueagle-atm vxge"

RESTRICT="strip"

QA_PREBUILT="lib/firmware/*"

src_prepare() {
	default

	rm GPL* LICEN* Makefile WHENCE || die

	#dummy install
	mkdir nouveau

	for x in ${IUSE} ; do
		use ${x} || rm -r ${x}* || die
	done

	use nouveau || rm -r nvidia || die
}

src_install() {
	insinto /usr/lib/firmware/
	doins -r *
}
