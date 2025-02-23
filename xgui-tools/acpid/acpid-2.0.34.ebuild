# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info doins

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="https://sourceforge.net/projects/acpid2/"
SRC_URI="https://downloads.sourceforge.net/${PN}2/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}"/${PN}-2.0.34-lfs.patch
)

pkg_pretend() {
	local CONFIG_CHECK="~INPUT_EVDEV"
	local WARNING_INPUT_EVDEV="CONFIG_INPUT_EVDEV is required for ACPI button event support."
	[[ ${MERGE_TYPE} != buildonly ]] && check_extra_config
}

pkg_setup() { :; }

src_install() {
	emake DESTDIR="${D}" install

	newdoc kacpimon/README README.kacpimon
	dodoc -r samples
	rm -f "${D}"/usr/share/doc/${PF}/COPYING || die

	exeinto /etc/acpi
	newexe "${FILESDIR}"/${PN}-1.0.6-default.sh default.sh
	exeinto /etc/acpi/actions
	newexe samples/powerbtn/powerbtn.sh powerbtn.sh
	insinto /etc/acpi/events
	newins "${FILESDIR}"/${PN}-1.0.4-default default

	systemd_dounit "${FILESDIR}"/${PN}.{service,socket}
}
