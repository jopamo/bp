# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/${PN}.git"

LICENSE="linux-firmware ( BSD ISC MIT no-source-code ) GPL-2 GPL-2+ freedist"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="amdgpu qcom netronome liquidio iwlwifi intel qed brcm ath10k
	mellanox dpaa2 bnx2x mrvl ti i915 radeon cxgb4 mediatek nvidia
	ueagle-atm libertas bnx2 ath11k cypress phanfw i6050 i2400m
	rsi rtlwifi qca carl9170fw ath6k vxge rtl_bt atmel rtw88 mwl8k
	mwlwifi ct2fw ar3k myri10ge ctfw cbfw moxa"

RESTRICT="strip"

QA_PREBUILT="lib/firmware/*"

src_prepare() {
	default

	for x in ${IUSE} ; do
		use ${x} || rm -rf ${x}*
	done
}

src_install() {
	insinto /usr/lib/firmware/
	doins -r *
}
