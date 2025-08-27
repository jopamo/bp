# Distributed under the terms of the GNU General Public License v2

EAPI=8

MINOR_VERSION="10060-4e8b05daf"
_FULL_VERSION="${PV}.${MINOR_VERSION}"

URI="https://downloads.plex.tv/plex-media-server-new"

inherit doins unpacker

DESCRIPTION="A free media library that is intended for use with a plex client."
HOMEPAGE="http://www.plex.tv/"
SRC_URI="amd64? ( ${URI}/${_FULL_VERSION}/debian/plexmediaserver_${_FULL_VERSION}_amd64.deb )
		arm64? ( ${URI}/${_FULL_VERSION}/debian/plexmediaserver_${_FULL_VERSION}_arm64.deb )"

LICENSE="Plex"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd"

RESTRICT="strip mirror"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="app-dev/patchelf"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	# Remove Debian specific files
	rm -r "usr/share/doc" || die

	mkdir -p "${ED}"/opt
	cp -rp usr/lib/plexmediaserver "${ED}"/opt/

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi

	cat > "${T}"/"${PN}"-sysusers <<- EOF || die
		u plex - "Plex Media Server" /var/lib/plexmediaserver
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"

	keepdir "/var/lib/plexmediaserver/Library/Application Support"
	fowners -R plex:plex /var/lib/plexmediaserver
	fperms -R 755 /var/lib/plexmediaserver

}

pkg_postinst() {
	sysusers_process
}
