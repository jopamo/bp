# Distributed under the terms of the GNU General Public License v2

EAPI=8

K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
ETYPE="sources"

inherit kernel-2 git-r3

DESCRIPTION="Linux kernel source code tree"
HOMEPAGE="https://kernel.org/"

EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git"
EGIT_BRANCH="linux-$(ver_cut 1-2).y"

S="${WORKDIR}/linux-${PV}"
EGIT_CHECKOUT_DIR="${S}"

LICENSE="GPL"
SLOT="$(ver_cut 1-2)"
KEYWORDS="amd64 arm64"

RESTRICT="network-sandbox"

DEPEND="
	app-core/ed
	app-util/bc
"

src_prepare() {
	kernel-2_src_prepare

	eapply "${FILESDIR}"/mt7925.patch
	eapply "${FILESDIR}"/reg.patch

	local mt76_dir="${WORKDIR}/mt76"
	git clone https://github.com/openwrt/mt76.git "${mt76_dir}" --depth 1 || die "Failed to clone mt76 repository"
	rm -rf "${mt76_dir}"/.git
	cp -r "${mt76_dir}" "${S}/drivers/net/wireless/mediatek/" || die "Failed to copy new mt76 directory"
	eapply "${FILESDIR}"/mt76.patch
}

