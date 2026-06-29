# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Linux firmware files"
HOMEPAGE="https://git.kernel.org/?p=linux/kernel/git/firmware/linux-firmware.git"
SNAPSHOT=7e909c703f293a9332c1b83be4eafa926d8c7bec
SRC_URI="https://gitlab.com/kernel-firmware/linux-firmware/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/linux-firmware-${SNAPSHOT}"

LICENSE="linux-firmware ( BSD ISC MIT no-source-code ) GPL-2 GPL-2+ freedist"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="3com airoha amdgpu amd-ucode amdnpu amlogic ar3k ath10k ath11k ath12k
	ath6k atmel bnx2 brcm carl9170fw cbfw cirrus cis ct2fw ctfw cxgb4 cypress
	dpaa2 i915 intel intel-ish iwlwifi keyspan libertas liquidio mali mediatek
	mellanox meson moxa mrvl mwl8k mwlwifi myri10ge netronome nouveau nxp
	phanfw qca qcom qed qlogic radeon realtek regdb rsi rtl_bt rtl_nic rtlwifi
	rtw88 ti ueagle-atm vxge xe"

RESTRICT="strip"

FWDIR="/usr/lib/firmware"

QA_PREBUILT="${FWDIR}/*"

prune_paths() {
	[[ $# -gt 0 ]] || return
	rm -rf -- "$@" || die "failed pruning $*"
}

prune_tree_keep_path() {
	local root="${1}"
	local keep="${2}"
	local stash="${T}/$(basename "${root}").keep"

	[[ -n ${root} && -n ${keep} ]] || die "prune_tree_keep_path requires root and keep paths"

	if [[ ! -e ${keep} && ! -L ${keep} ]]; then
		prune_paths "${root}"
		return
	fi

	rm -rf -- "${stash}" || die
	mv -- "${keep}" "${stash}" || die "failed stashing ${keep}"
	prune_paths "${root}"
	mkdir -p -- "$(dirname "${keep}")" || die
	mv -- "${stash}" "${keep}" || die "failed restoring ${keep}"
}

linux_firmware_make_whence() {
	local out="${1}"
	local line file link target target_path

	: > "${out}" || die "failed creating ${out}"

	while IFS= read -r line; do
		case ${line} in
			File:*|RawFile:*)
				file=${line#*: }
				file=${file//\"/}
				[[ -e ${file} || -L ${file} ]] || continue
				;;
			Link:*)
				link=${line#Link: }
				link=${link%% -> *}
				target=${line#* -> }
				link=${link//\"/}
				target=${target//\"/}
				target_path=$(realpath -m -s "$(dirname "${link}")/${target}") || die
				[[ -e ${target_path} || -L ${target_path} ]] || continue
				;;
		esac

		printf '%s\n' "${line}" >> "${out}" || die "failed writing ${out}"
	done < WHENCE
}

src_prepare() {
	default

	# current snapshots are WHENCE-driven, and several payload families no
	# longer map 1:1 to a blunt top-level ${useflag}* removal.
	use 3com || prune_paths 3com
	use airoha || prune_paths airoha
	use amdgpu || prune_paths amdgpu
	use amd-ucode || prune_paths amd-ucode
	use amdnpu || prune_paths amdnpu
	use amlogic || prune_paths amlogic
	use ar3k || prune_paths ar3k ath3k-1.fw
	use ath10k || prune_paths ath10k
	use ath11k || prune_paths ath11k
	use ath12k || prune_paths ath12k
	use ath6k || prune_paths ath6k
	use atmel || prune_paths atmel
	use bnx2 || prune_paths bnx2 bnx2x
	use brcm || prune_paths brcm
	use carl9170fw || prune_paths carl9170fw carl9170-1.fw
	use cbfw || prune_paths cbfw-3.2.5.1.bin
	use cirrus || prune_paths cirrus
	use cis || prune_paths cis
	use ct2fw || prune_paths ct2fw-3.2.5.1.bin
	use ctfw || prune_paths ctfw-3.2.5.1.bin ctefx.bin ctspeq.bin
	use cxgb4 || prune_paths cxgb3 cxgb4
	use cypress || prune_paths cypress
	use dpaa2 || prune_paths dpaa2
	use i915 || prune_paths i915
	use intel-ish || prune_paths dell HP LENOVO
	if use intel; then
		use iwlwifi || prune_paths intel/iwlwifi
	elif use iwlwifi; then
		prune_tree_keep_path intel intel/iwlwifi
	else
		prune_paths intel
	fi
	use keyspan || prune_paths keyspan keyspan_pda
	use libertas || prune_paths libertas lbtf_usb.bin
	use liquidio || prune_paths liquidio
	use mali || prune_paths arm
	use mediatek || prune_paths mediatek rt2561.bin rt2561s.bin rt2661.bin rt2860.bin rt2870.bin rt3071.bin rt3290.bin rt73.bin
	use mellanox || prune_paths mellanox
	use meson || prune_paths meson
	use moxa || prune_paths moxa
	use mrvl || prune_paths mrvl
	use mwl8k || prune_paths mwl8k
	use mwlwifi || prune_paths mwlwifi
	use myri10ge || prune_paths myri10ge*.dat
	use netronome || prune_paths netronome
	use nouveau || prune_paths nvidia
	use nxp || prune_paths nxp
	use phanfw || prune_paths phanfw.bin
	use qca || prune_paths qca ar5523.bin ar7010.fw ar7010_1_1.fw ar9170-1.fw ar9170-2.fw ar9271.fw ath9k_htc
	use qcom || prune_paths qcom
	use qed || prune_paths qed
	use qlogic || prune_paths qlogic ql2100_fw.bin ql2200_fw.bin ql2300_fw.bin ql2322_fw.bin ql2400_fw.bin ql2500_fw.bin
	use radeon || prune_paths radeon
	use realtek || prune_paths realtek
	use rsi || prune_paths rsi rsi_91x.fw
	use rtl_bt || prune_paths rtl_bt
	use rtl_nic || prune_paths rtl_nic
	use rtlwifi || prune_paths rtlwifi
	use rtw88 || prune_paths rtw88 rtw89
	use ti || prune_paths ti ti-connectivity ti-keystone ti_3410.fw ti_5052.fw
	use ueagle-atm || prune_paths ueagle-atm
	use vxge || prune_paths vxge
	use xe || prune_paths xe
	use regdb || prune_paths regulatory.db regulatory.db.p7s
}

src_install() {
	local whence_install="${T}/WHENCE.install"
	local whence_backup="${T}/WHENCE.orig"

	linux_firmware_make_whence "${whence_install}"

	cp WHENCE "${whence_backup}" || die
	cp "${whence_install}" WHENCE || die

	dodir "${FWDIR}" || die
	if ! sh ./copy-firmware.sh "${ED%/}${FWDIR}"; then
		cp "${whence_backup}" WHENCE || die
		die "copy-firmware.sh failed"
	fi
	cp "${whence_backup}" WHENCE || die

	if use regdb; then
		insinto "${FWDIR}"
		if [[ -f regulatory.db ]]; then
			doins regulatory.db || die
		fi
		if [[ -f regulatory.db.p7s ]]; then
			doins regulatory.db.p7s || die
		fi
	fi

	dodoc README.md WHENCE LICENSE || die
	dodoc -r LICENSES || die
}

pkg_postinst() {
	elog "firmware installed to ${FWDIR}"
	elog "installed upstream WHENCE compatibility links for the retained firmware set"
	elog "reload affected kernel modules or reboot to pick up updated firmware"
	elog "if using an initramfs, rebuild it so the firmware is included"
}
