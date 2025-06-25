# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info toolchain-funcs

DESCRIPTION="Required tools for WireGuard, such as wg(8) and wg-quick(8)"
HOMEPAGE="https://www.wireguard.com/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.zx2c4.com/wireguard-tools"
else
	SRC_URI="https://git.zx2c4.com/wireguard-tools/snapshot/wireguard-tools-${PV}.tar.xz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd wg-quick"

BDEPEND="app-dev/pkgconf"
DEPEND="
	wg-quick? (
		|| ( app-net/nftables app-net/iptables )
		app-net/openresolv
	)
"

wg_quick_optional_config_nob() {
	CONFIG_CHECK="$CONFIG_CHECK ~$1"
	declare -g ERROR_$1="CONFIG_$1: This option is required for automatic routing of default routes inside of wg-quick(8), though it is not required for general WireGuard usage."
}

pkg_setup() {
	use wg-quick || return 0
	wg_quick_optional_config_nob IP_ADVANCED_ROUTER
	wg_quick_optional_config_nob IP_MULTIPLE_TABLES
	wg_quick_optional_config_nob IPV6_MULTIPLE_TABLES
	if has_version net-firewall/nftables; then
		wg_quick_optional_config_nob NF_TABLES
		wg_quick_optional_config_nob NF_TABLES_IPV4
		wg_quick_optional_config_nob NF_TABLES_IPV6
		wg_quick_optional_config_nob NFT_CT
		wg_quick_optional_config_nob NFT_FIB
		wg_quick_optional_config_nob NFT_FIB_IPV4
		wg_quick_optional_config_nob NFT_FIB_IPV6
		wg_quick_optional_config_nob NF_CONNTRACK_MARK
	elif has_version net-firewall/iptables; then
		wg_quick_optional_config_nob NETFILTER_XTABLES
		wg_quick_optional_config_nob NETFILTER_XT_MARK
		wg_quick_optional_config_nob NETFILTER_XT_CONNMARK
		wg_quick_optional_config_nob NETFILTER_XT_MATCH_COMMENT
		wg_quick_optional_config_nob IP6_NF_RAW
		wg_quick_optional_config_nob IP_NF_RAW
		wg_quick_optional_config_nob IP6_NF_FILTER
		wg_quick_optional_config_nob IP_NF_FILTER
	fi
	linux-info_pkg_setup
}

src_compile() {
	emake RUNSTATEDIR="${EPREFIX}/run" -C src CC="$(tc-getCC)" LD="$(tc-getLD)"
}

src_install() {
	dodoc -r contrib
	emake \
		WITH_BASHCOMPLETION=no \
		WITH_SYSTEMDUNITS=yes \
		WITH_WGQUICK=$(usex wg-quick) \
		DESTDIR="${D}" \
		SYSTEMDUNITDIR=$(usex systemd "${EPREFIX}/usr/lib/systemd/system" "false") \
		PREFIX="${EPREFIX}/usr" \
		-C src install
}
