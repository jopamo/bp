# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit user

DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/doc.html"
SNAPSHOT=ec8f3e65c19e8dee114e31759d447926d3ebd7cf
SHORT=${SNAPSHOT:0:7}
SRC_URI="https://github.com/1g4-mirror/dnsmasq/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dnsmasq-${SHORT}"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="auth-dns conntrack dbus dhcp dhcp-tools dnssec dumpfile id ipset
	inotify ipv6 lua script static systemd tftp"

use_have() {
	local useflag no_only uword
	if [[ ${1} == '-n' ]]; then
		no_only=1
		shift
	fi
	useflag="${1}"
	shift

	uword="${1:-${useflag}}"
	shift

	while [[ ${uword} ]]; do
		uword="${uword^^}"

		if ! use "${useflag}"; then
			printf -- " -DNO_%s" "${uword}"
		elif [[ -z "${no_only}" ]]; then
			printf -- " -DHAVE_%s" "${uword}"
		fi
		uword="${1}"
		shift
	done
}

src_prepare() {
	default
	echo "${PV}" > VERSION || die
}

src_configure() {
	COPTS=(
		"$(use_have -n auth-dns auth)"
		"$(use_have conntrack)"
		"$(use_have dbus)"
		"$(use_have -n inotify)"
		"$(use_have -n ipv6 dhcp6)"
		"$(use_have ipv6)"
		"$(use_have ipset)"
		"$(use_have -n dhcp)"
		"$(use_have -n id id)"
		"$(use_have lua luascript)"
		"$(use_have -n script)"
		"$(use_have -n tftp)"
		"$(use_have dnssec)"
		"$(use_have static dnssec_static)"
		"$(use_have -n dumpfile)"
	)
}

src_compile() {
	emake \
		PREFIX=/usr \
		BINDIR=/usr/bin \
		MANDIR=/usr/share/man \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		COPTS="${COPTS[*]}" \
		CONFFILE="/etc/dnsmasq.conf" \
		all

	use dhcp-tools && emake -C contrib/lease-tools \
		PREFIX=/usr \
		BINDIR=/usr/bin \
		MANDIR=/usr/share/man \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		all
}

src_install() {
	emake \
		PREFIX=/usr \
		BINDIR=/usr/bin \
		MANDIR=/usr/share/man \
		COPTS="${COPTS[*]}" \
		DESTDIR="${ED}" \
		install

	insinto /etc
	insopts -m 0644
	doins "${FILESDIR}"/dnsmasq.conf

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/dnsmasq.service
	fi
}

pkg_preinst() {
	enewgroup "dnsmasq" 67
	enewuser "dnsmasq" 67 -1 "/var/lib/dnsmasq" "dnsmasq"

}
