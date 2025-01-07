# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-single-r1 doins user flag-o-matic

DESCRIPTION="PC/SC Architecture smartcard middleware library"
HOMEPAGE="https://pcsclite.apdu.fr https://github.com/LudovicRousseau/PCSC"
SRC_URI="https://pcsclite.apdu.fr/files/${P}.tar.xz"

LICENSE="BSD GPL-3+ BSD-2 ISC GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="embedded libusb policykit selinux systemd +udev"
REQUIRED_USE="^^ ( udev libusb ) ${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.9.8-systemd-user.patch
	"${FILESDIR}"/${PN}-2.2.3-change-setup-spy-script-location.patch
)

src_configure() {
	filter-flags -Wl,-z,defs

	local emesonargs=(
		-Dusbdropdir="${EPREFIX}"/usr/lib/readers/usb
		-Dipcdir=/run/pcscd
		-Dsystemdunit=system
		$(meson_use embedded)
		$(meson_use systemd libsystemd)
		$(meson_use udev libudev)
		$(meson_use libusb)
		-Dpolkit=false
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	dotmpfiles "${FILESDIR}"/pcscd.conf

	if use udev; then
		exeinto "$(get_udevdir)"
		newexe "${FILESDIR}"/pcscd-udev pcscd.sh

		insinto "$(get_udevdir)"/rules.d
		newins "${FILESDIR}"/99-pcscd-hotplug-r2.rules 99-pcscd-hotplug.rules
	fi

	find "${ED}" -name '*.la' -delete || die
}

pkg_postinst() {
	tmpfiles_process pcscd.conf

	use udev && udev_reload
}

pkg_postrm() {
	use udev && udev_reload
}

pkg_preinst() {
	enewgroup pcscd -1
	enewuser pcscd -1 -1 -1 pcscd
}
