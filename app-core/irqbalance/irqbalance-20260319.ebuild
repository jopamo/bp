# Distributed under the terms of the GNU General Public License v2

inherit meson linux-info doins qa-policy

DESCRIPTION="Distribute hardware interrupts across processors on a multiprocessor system"
HOMEPAGE="https://github.com/Irqbalance/irqbalance"
SNAPSHOT=cd9212f453db71bec2050c9236c4ce9f17e6d2b4
SRC_URI="https://github.com/Irqbalance/irqbalance/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="caps kernel_linux +numa systemd thermal tui"
# Hangs
RESTRICT="test"

DEPEND="
	lib-core/glib
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
	qa-policy-configure

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
	qa-policy-install
}

pkg_postrm() {
	udev_reload
}

pkg_postinst() {
	udev_reload
}
