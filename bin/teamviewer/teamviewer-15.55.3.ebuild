# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature doins xdg

MY_MAJOR="$(ver_cut 1)"
MY_P="${PN}${MY_MAJOR}"
DESCRIPTION="All-In-One Solution for Remote Access and Support over the Internet"
HOMEPAGE="https://www.teamviewer.com"
MY_URI="https://dl.teamviewer.com/download/linux/version_${MY_MAJOR}x/${PN}_${PV}"
SRC_URI="
	amd64? ( ${MY_URI}_amd64.tar.xz )
	arm64? ( ${MY_URI}_arm64.tar.xz )"
S="${WORKDIR}"/teamviewer

LICENSE="TeamViewer MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="bindist mirror strip"

QA_PREBUILT="opt/${MY_P}/*"

src_prepare() {
	default

	# Switch operation mode from 'portable' to 'installed'
	sed -e "s/TAR_NI/TAR_IN/g" -i tv_bin/script/tvw_config || die

	sed -i \
		-e "/^ExecStart/s|${PN}|${MY_P}|" \
		-e "/^PIDFile/s|/var/run/|/run/|" \
		tv_bin/script/teamviewerd.service || die
}

src_install() {
	local dst="/opt/${MY_P}" # install destination

	insinto ${dst}
	doins -r tv_bin

	# Set permissions for executables and libraries
	local exe
	for exe in $(find tv_bin -type f -executable -or -name '*.so' || die); do
		fperms +x ${dst}/${exe}
	done

	systemd_dounit tv_bin/script/teamviewerd.service

	insinto /usr/share/dbus-1/services
	doins tv_bin/script/com.teamviewer.TeamViewer.service
	doins tv_bin/script/com.teamviewer.TeamViewer.Desktop.service

	insinto /usr/share/polkit-1/actions
	doins tv_bin/script/com.teamviewer.TeamViewer.policy

	dodoc -r doc

	# Make docs available in expected location
	dosym ../../usr/share/doc/${PF}/doc ${dst}/doc

	# We need to keep docs uncompressed, bug #778617
	docompress -x /usr/share/doc/${PF}/.

	keepdir /etc/${MY_P}
	dosym ../../etc/${MY_P} ${dst}/config

	# Create directory and symlink for log files (NOTE: according to Team-
	# Viewer devs, all paths are hard-coded in the binaries; therefore
	# using the same path as the DEB/RPM archives, i.e. '/var/log/teamviewer
	# <major-version>')
	keepdir /var/log/${MY_P}
	dosym ../../var/log/${MY_P} ${dst}/logfiles

	dodir /opt/bin
	dosym ${dst}/tv_bin/teamviewerd /opt/bin/teamviewerd
	dosym ${dst}/tv_bin/script/teamviewer /opt/bin/teamviewer
}
