# Distributed under the terms of the GNU General Public License v2

inherit linux-info autotools qa-policy doins

DESCRIPTION="Linux kernel firewall, NAT and packet mangling tools"
HOMEPAGE="https://netfilter.org/projects/nftables/"
SNAPSHOT=49e418238ece947e92f87a35ef6cf50755485370
SRC_URI="https://github.com/1g4-mirror/nftables/archive/${SNAPSHOT}.tar.gz -> nftables-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/nftables-${SNAPSHOT}
PATCHES=(
	"${FILESDIR}"/nftables-99f2b29a16db-flex-ECHO-token.patch
	"${FILESDIR}"/nftables-20260816-clang-export-visibility.patch
)

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug gmp readline router static-libs systemd"

DEPEND="
	lib-net/libmnl
	lib-net/libnftnl
	virtual/curses
	gmp? ( lib-core/gmp )
	readline? ( lib-core/readline )
"

pkg_setup() {
	CONFIG_CHECK="~NF_TABLES"
	linux-info_pkg_setup
}

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_with readline cli=readline)
		$(use_with !gmp mini_gmp)
		$(use_enable static-libs static)
		--disable-man-doc
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	# Drop libtool archives; they are not needed at runtime and can trigger
	# executable-bit QA failures.
	find "${ED}" -type f -name '*.la' -delete || die

	keepdir /var/lib/nftables

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		if use router; then
			newins "${FILESDIR}/nftables-router.service" nftables.service
			systemd_enable_service network-pre.target nftables.service
		else
			doins "${FILESDIR}/nftables.service"
		fi
	fi

	insinto /etc
	if use router; then
		newins "${FILESDIR}/router.conf" nftables.conf
		insinto /etc/nftables.d
		newins "${FILESDIR}/router-interfaces.nft.example" \
			router-interfaces.nft.example
	else
		doins "${FILESDIR}/nftables.conf"
	fi

	qa-policy-install
}

pkg_postinst() {
	if use router; then
		elog "Router mode requires /etc/nftables.d/router-interfaces.nft."
		elog "Copy the .example file there and assign the host's WAN/LAN roles."
		elog "The router firewall keeps IPv4 forwarding disabled until that"
		elog "role mapping and the complete nftables ruleset load successfully."
	fi
}
