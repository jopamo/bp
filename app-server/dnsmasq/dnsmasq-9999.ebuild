# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/doc.html"
EGIT_REPO_URI="http://thekelleys.org.uk/git/dnsmasq"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="auth-dns conntrack dbus dhcp dhcp-tools dnssec +dumpfile id ipset
	inotify ipv6 lua script static tftp"

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
	sed -i -e "s/UNKNOWN/$(git log -n1 --pretty=format:%cd --date=format:%Y%m%d)/g" "bld/get-version" || die
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
		MANDIR=/usr/share/man \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		COPTS="${COPTS[*]}" \
		CONFFILE="/etc/${PN}.conf" \
		all

	use dhcp-tools && emake -C contrib/lease-tools \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		all
}

src_install() {
	emake \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		COPTS="${COPTS[*]}" \
		DESTDIR="${ED}" \
		install
}
