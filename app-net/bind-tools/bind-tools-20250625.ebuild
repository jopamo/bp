# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=117091c4fe1ae6d05b4127dfad9427ea57d11d4c

inherit meson flag-o-matic

DESCRIPTION="bind tools: dig, nslookup, host, nsupdate, dnssec-keygen"
HOMEPAGE="http://www.isc.org/software/bind"
SRC_URI="https://github.com/isc-projects/bind9/archive/${SNAPSHOT}.tar.gz -> bind9-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/bind9-${SNAPSHOT}"

LICENSE="Apache-2.0 BSD BSD-2 GPL-2 HPND ISC MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="fips doh geoip"

DEPEND="
	lib-core/libcap
	lib-core/libseccomp
	lib-core/libxml2
	lib-core/zlib
	lib-dev/json-c
	lib-net/userspace-rcu
	virtual/ssl
	doh? ( lib-dev/nghttp2 )
	geoip? ( lib-dev/maxminddb )
"
BDEPEND="app-dev/pkgconf"

RESTRICT="test"

src_prepare() {
	default

	sed -Ei '
		/elif[[:space:]]+git\.found\(\)/c\else
		/run_command\(.*git.*rev-parse.*/c\    src_id = '\''${SNAPSHOT}'\''
		/meson\.add_dist_script\(.*source-id.*/d
		' meson.build || die
}

src_configure() {
    local emesonargs=(
		$(meson_feature doh)
		$(meson_feature fips)
		$(meson_feature geoip)
		-D dnstap=disabled
		-D doc=disabled
		-D gssapi=disabled
		-D idn=disabled
		-D line=disabled
		-D lmdb=disabled
		-D stats-json=enabled
		-D stats-xml=enabled
		-D zlib=enabled
    )
    meson_src_configure
}
