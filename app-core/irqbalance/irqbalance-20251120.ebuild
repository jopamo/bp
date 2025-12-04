# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson linux-info doins

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="https://github.com/Irqbalance/irqbalance"
SNAPSHOT=4c234853d5ac9f13d8fe6b618d41a44161de509b
SRC_URI="https://github.com/Irqbalance/irqbalance/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ppc ppc64 ~riscv x86"
IUSE="caps +numa systemd thermal tui"
# Hangs
RESTRICT="test"

DEPEND="
	lib-util/glib
	caps? ( lib-core/libcap )
	numa? ( app-util/numactl )
	systemd? ( app-core/systemd )
	thermal? ( lib-net/libnl )
	tui? ( lib-core/ncurses )
"

pkg_setup() {
	CONFIG_CHECK="~PCI_MSI"
	linux-info_pkg_setup
}

src_prepare() {
	default

	# Follow systemd policies
	# https://wiki.gentoo.org/wiki/Project:Systemd/Ebuild_policy
	sed \
		-e 's/ $IRQBALANCE_ARGS//' \
		-e '/EnvironmentFile/d' \
		-i "${S}"/misc/irqbalance.service.in || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature caps capng)
		$(meson_feature numa)
		$(meson_feature systemd)
		$(meson_feature thermal)
		$(meson_feature tui ui)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	systemd_newunit "${S}"/misc/irqbalance.service.in irqbalance.service
	udev_dorules "${S}"/misc/90-irqbalance.rules
}

pkg_postrm() {
	udev_reload
}

pkg_postinst() {
	udev_reload
}
