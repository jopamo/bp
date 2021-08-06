# Distributed under the terms of the GNU General Public License v2

EAPI=7

MINOR_VERSION="4881-e2e58f321"

_APPNAME="plexmediaserver"
_USERNAME="plex"
_SHORTNAME="${_USERNAME}"
_FULL_VERSION="${PV}.${MINOR_VERSION}"

URI="https://downloads.plex.tv/plex-media-server-new"

inherit user unpacker

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

BDEPEND="dev-util/patchelf"
RDEPEND="
	xmedia-live-lib/taglib
	app-compression/minizip
"

S="${WORKDIR}"

pkg_setup() {
	enewgroup ${_USERNAME}
	enewuser ${_USERNAME} -1 /usr/bin/bash /var/lib/${_APPNAME} "${_USERNAME},video"
}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	# Remove Debian apt repo files
	rm -r "etc/apt" || die

	# Remove Debian specific files
	rm -r "usr/share/doc" || die

	mkdir -p "${ED}"/opt
	cp -rp usr/lib/plexmediaserver "${ED}"/opt/

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
	fi

	rm -f "${ED}"/opt/plexmediaserver/Resources/Python/lib/python2.7/lib-dynload/_codecs_{cn,hk,jp,kr,tw}.so
	rm -f "${ED}"/opt/plexmediaserver/Resources/Python/lib/python2.7/lib-dynload/_multibytecodec.so

	patchelf --set-rpath "/opt/plexmediaserver/lib/" "${ED}"/opt/plexmediaserver/Resources/Python/lib/python2.7/lib-dynload/_bisect.so

	keepdir "/var/lib/plexmediaserver/Library/Application Support"
	fowners plex:plex /var/lib/plexmediaserver
	fperms 755 /var/lib/plexmediaserver
}
