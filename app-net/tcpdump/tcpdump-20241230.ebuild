# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools user

DESCRIPTION="A tool for network monitoring and data acquisition"
HOMEPAGE="https://www.tcpdump.org/ https://github.com/the-tcpdump-group/tcpdump"

SNAPSHOT=dad8c2eef2a0754ccc10136efdd38542d4bb1b57
SRC_URI="https://github.com/the-tcpdump-group/tcpdump/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/tcpdump-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+caps +smi +ssl +samba suid test"

REQUIRED_USE="test? ( samba )"
RESTRICT="!test? ( test )"

DEPEND="lib-net/libpcap"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable samba smb) \
		$(use_with caps cap-ng) \
		$(use_with smi) \
		$(use_with ssl crypto "${ESYSROOT}/usr") \
		$(usex caps "--with-user=pcap" "")
}

src_test() {
	if [[ ${EUID} -ne 0 ]] || ! use caps ; then
		emake check
	else
		ewarn "If you want to run the test suite, make sure you either"
		ewarn "set FEATURES=userpriv or set USE=-caps"
	fi
}

src_install() {
	dosbin tcpdump
	doman tcpdump.1
	dodoc *.awk
	dodoc CHANGES CREDITS README.md

	if use suid ; then
		fowners root:pcap /usr/sbin/tcpdump
		fperms 4110 /usr/sbin/tcpdump
	fi
}

pkg_postinst() {
	use suid && elog "To let normal users run tcpdump, add them to the pcap group."
}

pkg_preinst() {
	enewgroup pcap 377
	enewuser pcap 377 -1 -1 sshd
}
