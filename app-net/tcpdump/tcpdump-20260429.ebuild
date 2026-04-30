# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="A tool for network monitoring and data acquisition"
HOMEPAGE="https://www.tcpdump.org/ https://github.com/the-tcpdump-group/tcpdump"
SNAPSHOT=39b50f76672bca4af7d7eb52604c5b692c6b6b2c
SRC_URI="https://github.com/the-tcpdump-group/tcpdump/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/tcpdump-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps smi ssl samba suid test"

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
	dobin tcpdump
	doman tcpdump.1

	cat > "${T}"/"${PN}"-sysusers <<- EOF || die
		g pcap 105 - -
		u pcap 105:105 "packet capture user" /dev/null /usr/bin/false
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"

	if use suid ; then
		fowners 0:105 /usr/bin/tcpdump
		fperms 4110 /usr/bin/tcpdump
	fi
}

pkg_postinst() {
	sysusers_process
	use suid && elog "To let normal users run tcpdump, add them to the pcap group."
}
