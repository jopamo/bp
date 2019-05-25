# Distributed under the terms of the GNU General Public License v2

EAPI=7

MINOR_VERSION="994-107756f7e"

_APPNAME="plexmediaserver"
_USERNAME="plex"
_SHORTNAME="${_USERNAME}"
_FULL_VERSION="${PV}.${MINOR_VERSION}"

URI="https://downloads.plex.tv/plex-media-server-new"

inherit user systemd unpacker python-single-r1

DESCRIPTION="A free media library that is intended for use with a plex client."
HOMEPAGE="http://www.plex.tv/"
SRC_URI="amd64? ( ${URI}/${_FULL_VERSION}/debian/plexmediaserver_${_FULL_VERSION}_amd64.deb )
		arm64? ( ${URI}/${_FULL_VERSION}/debian/plexmediaserver_${_FULL_VERSION}_arm64.deb )"

SLOT="0/1"
LICENSE="Plex"
KEYWORDS="amd64 arm64"

RESTRICT="bindist strip"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="lib-media/taglib"
RDEPEND="app-compression/minizip
	${PYTHON_DEPS}"

QA_DESKTOP_FILE="usr/share/applications/plexmediamanager.desktop"
QA_PREBUILT="*"
QA_MULTILIB_PATHS=(
	"usr/lib/${_APPNAME}/.*"
	"usr/lib/${_APPNAME}/Resources/Python/lib/python2.7/.*"
)

EXECSTACKED_BINS=( "${ED%/}/usr/lib/plexmediaserver/libgnsdk_dsp.so*" )

S="${WORKDIR}"

pkg_setup() {
	enewgroup ${_USERNAME}
	enewuser ${_USERNAME} -1 /bin/bash /var/lib/${_APPNAME} "${_USERNAME},video"
	python-single-r1_pkg_setup
}

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	# Move the config to the correct place
	local CONFIG_VANILLA="/etc/default/plexmediaserver"
	local CONFIG_PATH="/etc/${_SHORTNAME}"
	dodir "${CONFIG_PATH}"
	insinto "${CONFIG_PATH}"
	doins "${CONFIG_VANILLA#/}"
	sed -e "s#${CONFIG_VANILLA}#${CONFIG_PATH}/${_APPNAME}#g" -i "${S}"/usr/sbin/start_pms || die

	# Copy main files over to image and preserve permissions so it is portable
	cp -rp usr/ "${ED}" || die

	# Make sure the logging directory is created
	local LOGGING_DIR="/var/log/pms"
	dodir "${LOGGING_DIR}"
	chown "${_USERNAME}":"${_USERNAME}" "${ED%/}/${LOGGING_DIR}" || die

	# Create default library folder with correct permissions
	local DEFAULT_LIBRARY_DIR="/var/lib/${_APPNAME}"
	dodir "${DEFAULT_LIBRARY_DIR}"
	chown "${_USERNAME}":"${_USERNAME}" "${ED%/}/${DEFAULT_LIBRARY_DIR}" || die

	dodir /etc/revdep-rebuild/
	echo "SEARCH_DIRS_MASK=\"${EPREFIX}/usr/lib64/plexmediaserver\"" > "${ED}"/etc/revdep-rebuild/80plexmediaserver

	# Install systemd service file
	local INIT_NAME="${PN}.service"
	local INIT="${FILESDIR}/${INIT_NAME}"
	systemd_newunit "${INIT}" "${INIT_NAME}"

	einfo "Configuring virtualenv"
	pushd "${ED}"/usr/lib/plexmediaserver/Resources/Python &>/dev/null || die
	find . -type f -exec sed -i -e "s#${D}##g" {} + || die
	popd &>/dev/null || die

	keepdir /var/{lib,log}
	keepdir /var/lib/plexmediaserver
	keepdir /var/log/pms

	cleanup_install
}
