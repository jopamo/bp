# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 git-r3 linux-info systemd

DESCRIPTION="Gentoo package manager"
HOMEPAGE="https://github.com/gentoo/portage"
EGIT_REPO_URI="https://github.com/gentoo/portage.git"

LICENSE="GPL-2"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="bin X gui"

DEPEND="
	>=app-compression/tar-1.27
	>=sys-app/sed-4.0.5
	sys-devel/patch
"

RDEPEND="
	>=app-compression/tar-1.27
	sys-app/eselect
	>=app-crypt/gnupg-2.2.4-r2[gnutls(-)]
	sys-app/bash
	>=dev-python/lxml-3.6.0[${PYTHON_USEDEP}]
	>=sys-app/sed-4.0.5
	>=sys-app/sandbox-2.2
	>=sys-app/install-xattr-0.3
"
PDEPEND=">=app-net/rsync-2.6.4"

pkg_pretend() {
	local CONFIG_CHECK="~IPC_NS ~PID_NS ~NET_NS"

	check_extra_config
}

python_prepare_all() {
	distutils-r1_python_prepare_all

	find ${S} -type f -print0 | xargs -0 sed -i 's/\/var\/db\/repos\/gentoo/\/var\/db\/repos\/bp/g'
	cp {${FILESDIR}/phase-helpers.sh,${FILESDIR}/eapi7-ver-funcs.sh} bin/

	einfo "Disabling --dynamic-deps by default for gentoo-dev..."
	sed -e 's:\("--dynamic-deps", \)\("y"\):\1"n":' \
		-i lib/_emerge/create_depgraph_params.py || \
		die "failed to patch create_depgraph_params.py"

	einfo "Enabling additional FEATURES for gentoo-dev..."
	echo 'FEATURES="${FEATURES} ipc-sandbox network-sandbox strict-keepdir"' \
		>> cnf/make.globals || die

	printf "[build_ext]\nportage-ext-modules=true\n" >> \
		setup.cfg || die

	sed -e '/^sync-rsync-verify-metamanifest/s|yes|no|' \
		-e '/^sync-webrsync-verify-signature/s|yes|no|' \
		-i cnf/repos.conf || die "sed failed"

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

		einfo "Adjusting make.globals, repos.conf and etc-update ..."
		hprefixify cnf/{make.globals,repos.conf} bin/etc-update

		if use prefix-guest ; then
			sed -e "s|^\(main-repo = \).*|\\1gentoo_prefix|" \
				-e "s|^\\[gentoo\\]|[gentoo_prefix]|" \
				-e "s|^\(sync-uri = \).*|\\1rsync://rsync.prefix.bitzolder.nl/gentoo-portage-prefix|" \
				-i cnf/repos.conf || die "sed failed"
		fi

		einfo "Adding FEATURES=force-prefix to make.globals ..."
		echo -e '\nFEATURES="${FEATURES} force-prefix"' >> cnf/make.globals \
			|| die "failed to append to make.globals"
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

	systemd_dotmpfilesd "${FILESDIR}"/portage-ccache.conf

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
sync-uri = https://gitlab.com/pjo/bp.git\n\
auto-sync = yes" > "${ED}"/usr/share/portage/config/repos.conf

	use bin && echo -e "\n[bin]\n\
location = /var/db/repos/bin\n\
sync-type = git\n\
sync-uri = https://github.com/1g4-linux/bin.git\n\
auto-sync = yes" >> "${ED}"/usr/share/portage/config/repos.conf

	use X && echo -e "\n[x11]\n\
location = /var/db/repos/x11\n\
sync-type = git\n\
sync-uri = https://github.com/1g4-linux/x11.git\n\
auto-sync = yes" >> "${ED}"/usr/share/portage/config/repos.conf

	use gui && echo -e "\n[gui]\n\
location = /var/db/repos/gui\n\
sync-type = git\n\
sync-uri = https://github.com/1g4-linux/gui.git\n\
auto-sync = yes" >> "${ED}"/usr/share/portage/config/repos.conf

	insinto usr/share/portage/config/
	doins ${FILESDIR}/make.globals
}

pkg_preinst() {
	python_setup
	python_export PYTHON_SITEDIR
	[[ -d ${D%/}${PYTHON_SITEDIR} ]] || die "${D%/}${PYTHON_SITEDIR}: No such directory"
	env -u DISTDIR \
		-u PORTAGE_OVERRIDE_EPREFIX \
		-u PORTAGE_REPOSITORIES \
		-u PORTDIR \
		-u PORTDIR_OVERLAY \
		PYTHONPATH="${D%/}${PYTHON_SITEDIR}${PYTHONPATH:+:${PYTHONPATH}}" \
		"${PYTHON}" -m portage._compat_upgrade.default_locations || die

	# elog dir must exist to avoid logrotate error for bug #415911.
	# This code runs in preinst in order to bypass the mapping of
	# portage:portage to root:root which happens after src_install.
	keepdir /var/log/portage/elog
	# This is allowed to fail if the user/group are invalid for prefix users.
	if chown portage:portage "${ED}"/var/log/portage{,/elog} 2>/dev/null ; then
		chmod g+s,ug+rwx "${ED}"/var/log/portage{,/elog}
	fi
}
