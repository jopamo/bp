# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git"
SNAPSHOT=bd4d2bde91e121c5bc85e6950a374a2e0ed854ff
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

FWDIR="/lib/firmware"

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

	if use iwlwifi; then
		local img_root="${ED%/}${FWDIR}"
		local f linkname tgt

		# symlink top-level ucode names to wherever they were installed
		while IFS= read -r -d '' f; do
			linkname="${FWDIR}/$(basename "${f}")"
			tgt="${f#${ED%/}}"              # absolute target inside image root
			dosym "${tgt}" "${linkname}" || die
		done < <(find "${img_root}" -type f -name 'iwlwifi-ty-a0-gf-a0-*.ucode' -print0)

		# ensure PNVM exists and expose a top-level link
		local pnvm_src pnvm_inst
		pnvm_src="$(find "${S}" -type f -name 'iwlwifi-ty-a0-gf-a0.pnvm' | head -n1 || true)"
		if [[ -n "${pnvm_src}" ]]; then
			insinto "${FWDIR}"
			doins "${pnvm_src}" || die
		fi
		pnvm_inst="$(find "${img_root}" -type f -name 'iwlwifi-ty-a0-gf-a0.pnvm' | head -n1 || true)"
		if [[ -n "${pnvm_inst}" ]]; then
			dosym "${pnvm_inst#${ED%/}}" "${FWDIR}/iwlwifi-ty-a0-gf-a0.pnvm" || die
		fi
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
