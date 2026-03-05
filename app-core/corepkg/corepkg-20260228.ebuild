# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson linux-info multiprocessing python-r1 flag-o-matic doins

DESCRIPTION="1g4 package manager"
HOMEPAGE="https://github.com/1g4linux/corepkg"
SNAPSHOT=37832269366c74d1dc9039130f48787d5950a44c
SRC_URI="https://github.com/1g4linux/corepkg/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/corepkg-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="build gentoo-dev ipc native-extensions
	gentoo_repo +rsync-verify selinux test xattr"

DEPEND="
	app-build/patch
	app-compression/tar
	app-core/sed
"

RDEPEND="
	app-compression/tar
	app-core/bash
	app-core/findutils
	app-core/install-xattr
	app-core/sandbox
	app-core/sed
	app-crypto/gnupg
	dev-py/lxml[${PYTHON_USEDEP}]
"
PDEPEND="app-net/rsync"

pkg_pretend() {
	local CONFIG_CHECK="~IPC_NS ~PID_NS ~NET_NS ~UTS_NS"

	check_extra_config
}

src_prepare() {
	filter-flags -Wl,-z,defs

	default
}

src_configure() {
	local code_only=false
	python_foreach_impl my_src_configure
}

my_src_configure() {
	local emesonargs=(
		-Deprefix="${EPREFIX}"
		-Dsbindir="${EPREFIX}"/usr/bin
		-Ddocdir="${EPREFIX}/usr/share/doc/${PF}"
		-Dcorepkg-bindir="${EPREFIX}/usr/lib/corepkg/${EPYTHON}"
		-Ddoc=false
		-Dapidoc=false
		$(meson_use gentoo-dev)
		$(meson_use ipc)
		$(meson_use xattr)
	)

	if use native-extensions && [[ "${EPYTHON}" != "pypy3" ]] ; then
		emesonargs+=( -Dnative-extensions=true )
	else
		emesonargs+=( -Dnative-extensions=false )
	fi

	if use build; then
		emesonargs+=( -Drsync-verify=false )
	else
		emesonargs+=( $(meson_use rsync-verify) )
	fi

	meson_src_configure
	code_only=true
}

src_compile() {
	python_foreach_impl meson_src_compile
}

src_test() {
	local -x PYTEST_ADDOPTS="-vv -ra -l -o console_output_style=count -n $(makeopts_jobs) --dist=worksteal"

	python_foreach_impl meson_src_test --no-rebuild --verbose
}

src_install() {
	python_foreach_impl my_src_install

	local scripts
	mapfile -t scripts < <(awk '/^#!.*python/ {print FILENAME} {nextfile}' "${ED}"/usr/bin/* || die)
	python_replicate_script "${scripts[@]}"

	cat > "${T}"/"${PN}"-sysusers <<- EOF || die
		u corepkg 250 - /var/lib/corepkg/home
	EOF

	cat > "${T}"/"${PN}"-tmpfiles <<- EOF || die
		x /var/tmp/ccache
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"
	newtmpfiles "${T}/${PN}-tmpfiles" "${PN}.conf"
}

my_src_install() {
	local pydirs=(
		"${D}$(python_get_sitedir)"
		"${ED}/usr/lib/corepkg/${EPYTHON}"
	)

	meson_src_install

	if has_version "app-var/eselect" ; then
		ewarn "One-off migration: app-var/eselect is installed, so bundled eselect is skipped for this merge."
		ewarn "Legacy app-var/eselect will be removed automatically after install; remerge corepkg once to install bundled eselect."
		rm -rf \
			"${ED%/}${EPREFIX}/usr/bin/eselect" \
			"${ED%/}${EPREFIX}/usr/bin/kernel-config" \
			"${ED%/}${EPREFIX}/usr/bin/profile-config" \
			"${ED%/}${EPREFIX}/usr/bin/rc-config" \
			"${ED%/}${EPREFIX}/usr/share/eselect" || die
	fi

	if has_version "app-core/gentoo-functions" ; then
		ewarn "One-off migration: app-core/gentoo-functions is installed, so bundled core-functions user tools are skipped for this merge."
		rm -f \
			"${ED%/}${EPREFIX}/usr/bin/consoletype" \
			"${ED%/}${EPREFIX}/usr/bin/shquote" \
			"${ED%/}${EPREFIX}/usr/share/man/man1/consoletype.1" \
			"${ED%/}${EPREFIX}/usr/share/man/man1/consoletype.1.bz2" \
			"${ED%/}${EPREFIX}/usr/share/man/man1/consoletype.1.gz" \
			"${ED%/}${EPREFIX}/usr/share/man/man1/consoletype.1.xz" \
			"${ED%/}${EPREFIX}/usr/share/man/man1/consoletype.1.zst" || die
	fi

	if has_version "app-port/elt-patches" ; then
		ewarn "One-off migration: app-port/elt-patches is installed, so bundled elt-patches is skipped for this merge."
		rm -rf \
			"${ED%/}${EPREFIX}/usr/bin/eltpatch" \
			"${ED%/}${EPREFIX}/usr/share/elt-patches" || die
	fi

	python_optimize "${pydirs[@]}"
	python_fix_shebang "${pydirs[@]}"
}

pkg_preinst() {
	if ! use build && [[ -z ${ROOT} ]]; then
		python_setup
		local sitedir=$(python_get_sitedir)
		[[ -d ${D}${sitedir} ]] || die "${D}${sitedir}: No such directory"
		env -u DISTDIR \
			-u corepkg_OVERRIDE_EPREFIX \
			-u corepkg_REPOSITORIES \
			-u PORTDIR \
			-u PORTDIR_OVERLAY \
			PYTHONPATH="${D}${sitedir}${PYTHONPATH:+:${PYTHONPATH}}" \
			"${PYTHON}" -m corepkg._compat_upgrade.default_locations || die

		env -u BINPKG_COMPRESS -u corepkg_REPOSITORIES \
			PYTHONPATH="${D}${sitedir}${PYTHONPATH:+:${PYTHONPATH}}" \
			"${PYTHON}" -m corepkg._compat_upgrade.binpkg_compression || die

		env -u FEATURES -u corepkg_REPOSITORIES \
			PYTHONPATH="${D}${sitedir}${PYTHONPATH:+:${PYTHONPATH}}" \
			"${PYTHON}" -m corepkg._compat_upgrade.binpkg_multi_instance || die

	fi

	# elog dir must exist to avoid logrotate error for bug #415911.
	# This code runs in preinst in order to bypass the mapping of
	# corepkg:corepkg to root:root which happens after src_install.
	keepdir /var/log/corepkg/elog
	# This is allowed to fail if the user/group are invalid for prefix users.
	if chown corepkg:corepkg "${ED}"/var/log/corepkg{,/elog} 2>/dev/null ; then
		chmod g+s,ug+rwx "${ED}"/var/log/corepkg{,/elog}
	fi
}

pkg_postinst() {
	if ! use build && [[ -z ${ROOT} ]]; then
		python_setup
		env -u corepkg_REPOSITORIES \
			"${PYTHON}" -m corepkg._compat_upgrade.one_off_runner || die
	fi

	sysusers_process
	tmpfiles_process
}
