# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git"
SNAPSHOT=a0f0e52138e5f77fb0f358ff952447623ae0a7c4
SRC_URI="https://gitlab.com/kernel-firmware/linux-firmware/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/linux-firmware-${SNAPSHOT}"

LICENSE="linux-firmware ( BSD ISC MIT no-source-code ) GPL-2 GPL-2+ freedist"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="3com amdgpu amd-ucode ar3k ath10k ath11k ath12k ath6k atmel bnx2 brcm carl9170fw cbfw cis
	ct2fw ctfw cxgb4 cypress dpaa2 i915 intel iwlwifi keyspan libertas liquidio
	mediatek mellanox meson moxa mrvl mwl8k mwlwifi myri10ge netronome nouveau
	phanfw qca qcom qed radeon rsi rtl_bt rtl_nic rtlwifi rtw88 ti ueagle-atm vxge regdb"

RESTRICT="strip"

FWDIR="/usr/lib/firmware"

QA_PREBUILT="${FWDIR}/*"

src_prepare() {
	default

	rm -f GPL* LICEN* Makefile WHENCE || die

	mkdir -p nouveau || die

	for x in ${IUSE} ; do
		use ${x} || rm -rf ${x}* || die
	done

	use nouveau || rm -rf nvidia || die
}

src_install() {
	insinto "${FWDIR}"
	doins -r ./* || die

	local img_root="${ED%/}${FWDIR}"

	# create top-level symlinks for all Intel firmware basenames
	if [[ -d "${img_root}/intel" ]]; then
		local f base tgt
		while IFS= read -r -d '' f; do
			base="${FWDIR}/$(basename "${f}")"
			tgt="${f#${ED%/}}"

			# don't overwrite real files or existing links
			if [[ -e "${ED%/}${base}" ]]; then
				continue
			fi

			dosym -r "${tgt}" "${base}" || die
		done < <(find "${img_root}/intel" -type f -print0)
	fi

	if use regdb; then
		insinto "${FWDIR}"
		[[ -f "${S}/regulatory.db" ]] && doins "${S}/regulatory.db"
		[[ -f "${S}/regulatory.db.p7s" ]] && doins "${S}/regulatory.db.p7s"
	fi
}

pkg_postinst() {
	elog "firmware installed to ${FWDIR}"
	elog "created top-level symlinks for AX210 ucode and PNVM so the kernel can load them directly"
	elog "reload with: modprobe -r iwlmvm iwlwifi || true; modprobe iwlwifi"
	elog "if using an initramfs, rebuild it so the firmware is included"
}
