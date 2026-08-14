# Distributed under the terms of the GNU General Public License v2

inherit autotools doins linux-info qa-policy

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="https://sourceforge.net/projects/acpid2/"
SNAPSHOT=4d90b735fa7ac929059db75b8c2848863960418a
SRC_URI="https://github.com/tedfelix/acpid2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/acpid2-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

pkg_pretend() {
	local CONFIG_CHECK="~INPUT_EVDEV"
	local WARNING_INPUT_EVDEV="CONFIG_INPUT_EVDEV is required for ACPI button event support."
	[[ ${MERGE_TYPE} != buildonly ]] && check_extra_config
}

pkg_setup() { :; }

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	qa-policy-configure
	econf --sbindir=/usr/sbin
}

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
	qa-policy-install
}
