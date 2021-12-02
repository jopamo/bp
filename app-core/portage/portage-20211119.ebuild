# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 linux-info flag-o-matic user

DESCRIPTION="Gentoo package manager"
HOMEPAGE="https://github.com/gentoo/portage"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/gentoo/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=47fb9590b57162a786d668f663c1d0dfbfd1cfb0
	SRC_URI="https://github.com/gentoo/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gentoo_repo tmpfilesd sysusersd"

DEPEND="
	app-compression/tar
	app-core/sed
	app-build/patch
"

RDEPEND="
	app-compression/tar
	app-var/eselect
	app-crypto/gnupg[gnutls(-)]
	app-core/bash
	dev-python/lxml[${PYTHON_USEDEP}]
	app-core/sed
	app-core/sandbox
	app-core/install-xattr
	app-core/findutils
"
PDEPEND="app-net/rsync"

PATCHES=(
	"${FILESDIR}"/phase-helpers.patch
	"${FILESDIR}"/makeglobals.patch
)

filter-flags -Wl,-z,defs

pkg_pretend() {
	local CONFIG_CHECK="~IPC_NS ~PID_NS ~NET_NS"

	check_extra_config
}

python_prepare_all() {
	cp "${FILESDIR}"/eapi7-ver-funcs.sh bin/ || die

	distutils-r1_python_prepare_all

	find ${S} -type f -print0 | xargs -0 sed -i 's/\/var\/db\/repos\/gentoo/\/var\/db\/repos\/bp/g'

	einfo "Disabling --dynamic-deps by default for gentoo-dev..."
	sed -e 's:\("--dynamic-deps", \)\("y"\):\1"n":' \
		-i lib/_emerge/create_depgraph_params.py || \
		die "failed to patch create_depgraph_params.py"

	printf "[build_ext]\nportage-ext-modules=true\n" >> \
		setup.cfg || die

	if [[ -n ${EPREFIX} ]] ; then
		einfo "Setting portage.const.EPREFIX ..."
		hprefixify -e "s|^(EPREFIX[[:space:]]*=[[:space:]]*\").*|\1${EPREFIX}\"|" \
			-w "/_BINARY/" lib/portage/const.py

		einfo "Prefixing shebangs ..."
		while read -r -d $'\0' ; do
			local shebang=$(head -n1 "$REPLY")
			if [[ ${shebang} == "#!"* && ! ${shebang} == "#!${EPREFIX}/"* ]] ; then
				sed -i -e "1s:.*:#!${EPREFIX}${shebang:2}:" "$REPLY" || \
					die "sed failed"
			fi
		done < <(find . -type f ! -name etc-update -print0)
	fi

	cd "${S}/cnf" || die
	if [ -f "make.conf.example.${ARCH}".diff ]; then
		patch make.conf.example "make.conf.example.${ARCH}".diff || \
			die "Failed to patch make.conf.example"
	else
		eerror ""
		eerror "Portage does not have an arch-specific configuration for this arch."
		eerror "Please notify the arch maintainer about this issue. Using generic."
		eerror ""
	fi
}

python_test() {
	esetup.py test
}

python_install() {
	# Install sbin scripts to bindir for python-exec linking
	# they will be relocated in pkg_preinst()
	distutils-r1_python_install \
		--system-prefix="${EPREFIX}/usr" \
		--bindir="$(python_get_scriptdir)" \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--portage-bindir="${EPREFIX}/usr/lib/portage/${EPYTHON}" \
		--sbindir="$(python_get_scriptdir)" \
		--sysconfdir="${EPREFIX}/etc" \
		"${@}"
}

python_install_all() {
	distutils-r1_python_install_all

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		newins "${FILESDIR}/${PN}-tmpfiles" ${PN}.conf
	fi

	# Due to distutils/python-exec limitations
	# these must be installed to /usr/bin.
	local sbin_relocations='archive-conf dispatch-conf emaint env-update etc-update fixpackages regenworld'
	einfo "Moving admin scripts to the correct directory"
	dodir /usr/sbin
	for target in ${sbin_relocations}; do
		einfo "Moving /usr/bin/${target} to /usr/sbin/${target}"
		mv "${ED}/usr/bin/${target}" "${ED}/usr/sbin/${target}" || die "sbin scripts move failed!"
	done

	echo -e "[DEFAULT]\n\
main-repo = bp\n\n\
[bp]\n\
location = /var/db/repos/bp\n\
sync-type = git\n\
sync-uri = https://github.com/jopamo/bp.git\n\
auto-sync = yes" > "${ED}"/usr/share/portage/config/repos.conf

use gentoo_repo && echo -e "\n[gentoo]\n\
location = /var/db/repos/gentoo\n\
sync-type = git\n\
sync-uri = https://github.com/gentoo-mirror/gentoo.git\n\
auto-sync = yes" >> "${ED}"/usr/share/portage/config/repos.conf

	cleanup_install

	keepdir /var/lib/portage/home
}

pkg_preinst() {
	python_setup
	local sitedir=$(python_get_sitedir)
	[[ -d ${D%/}${sitedir} ]] || die "${D%/}${sitedir}: No such directory"
	env -u DISTDIR \
		-u PORTAGE_OVERRIDE_EPREFIX \
		-u PORTAGE_REPOSITORIES \
		-u PORTDIR \
		-u PORTDIR_OVERLAY \
		PYTHONPATH="${D%/}${sitedir}${PYTHONPATH:+:${PYTHONPATH}}" \
		"${PYTHON}" -m portage._compat_upgrade.default_locations || die

	# elog dir must exist to avoid logrotate error for bug #415911.
	# This code runs in preinst in order to bypass the mapping of
	# portage:portage to root:root which happens after src_install.
	keepdir /var/log/portage/elog
	# This is allowed to fail if the user/group are invalid for prefix users.
	if chown portage:portage "${ED}"var/log/portage{,/elog} 2>/dev/null ; then
		chmod g+s,ug+rwx "${ED}"var/log/portage{,/elog}
	fi

	if use sysusersd; then
		insopts -m 0644
		insinto /usr/lib/sysusers.d
		newins "${FILESDIR}/${PN}-sysusers" ${PN}.conf
	else
		enewgroup ${PN} 250
		enewuser portage 250 -1 /var/lib/portage/home portage
	fi
}
