# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="https://github.com/logrotate/logrotate"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl selinux"

CDEPEND="
	>=lib-dev/popt-1.5
	selinux? ( lib-sys/libselinux )
	acl? ( virtual/acl )"

DEPEND="${CDEPEND}
	>=sys-app/sed-4"

RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-logrotate )
"

STATEFILE="/var/lib/misc/logrotate.status"
OLDSTATEFILE="/var/lib/logrotate.status"

move_old_state_file() {
	elog "logrotate state file is now located at ${STATEFILE}"
	elog "See bug #357275"
	if [[ -e "${OLDSTATEFILE}" ]] ; then
		elog "Moving your current state file to new location: ${STATEFILE}"
		mv -n "${OLDSTATEFILE}" "${STATEFILE}"
	fi
}

PATCHES=(
	"${FILESDIR}/${P}-ignore-hidden.patch"
)

src_prepare() {
	cd ${S}
	./autogen.sh
	default
	sed -i -e 's#/usr/sbin/logrotate#/usr/bin/logrotate#' "${S}"/examples/logrotate.service || die
}

src_configure() {
	econf $(use_with acl) $(use_with selinux) --with-state-file-path="${STATEFILE}"
}

src_test() {
	emake test
}

src_install() {
	insinto /usr
	dobin logrotate
	doman logrotate.8

	insinto /etc
	doins "${FILESDIR}"/logrotate.conf

	keepdir /etc/logrotate.d
}

pkg_postinst() {
	elog
	elog "The ${PN} binary is now installed under /usr/bin. Please"
	elog "update your links"
	elog
	move_old_state_file
	if [[ -z ${REPLACING_VERSIONS} ]] ; then
		elog "If you wish to have logrotate e-mail you updates, please"
		elog "emerge virtual/mailx and configure logrotate in"
		elog "/etc/logrotate.conf appropriately"
		elog
		elog "Additionally, /etc/logrotate.conf may need to be modified"
		elog "for your particular needs. See man logrotate for details."
	fi
}
