# Distributed under the terms of the GNU General Public License v2

inherit meson linux-info multiprocessing python-r1 flag-o-matic doins

DESCRIPTION="1g4 package manager"
HOMEPAGE="https://gitlab.com/pjo/corepkg"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.com/pjo/corepkg"
	inherit git-r3
else
	SNAPSHOT=37832269366c74d1dc9039130f48787d5950a44c
	SRC_URI="https://gitlab.com/pjo/corepkg/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="build gentoo-dev ipc native-extensions
	gentoo_repo +rsync-verify selinux test xattr"

COMMON_DEPEND="
	app-core/bash
	app-core/bx
	app-core/sed
	app-crypto/blake3
	app-crypto/gnupg
	dev-pypi/lxml[${PYTHON_USEDEP}]
"

DEPEND="
	${COMMON_DEPEND}
	app-build/patch
"

RDEPEND="${COMMON_DEPEND}"
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
	keepdir /etc/corepkg

		cat > "${T}"/"${PN}"-sysusers <<- EOF || die
			g corepkg 103 - -
			u corepkg 103:103 "Corepkg account" /var/lib/corepkg/home /usr/bin/nologin
		EOF

	cat > "${T}"/"${PN}"-tmpfiles <<- EOF || die
		x /var/tmp/ccache
		d /var/lib/corepkg 2755 root corepkg -
		d /var/lib/corepkg/home 0700 corepkg corepkg -
		d /var/cache/distfiles 02775 corepkg corepkg -
	EOF

	newsysusers "${T}/${PN}-sysusers" "${PN}.conf"
	newtmpfiles "${T}/${PN}-tmpfiles" "${PN}.conf"
}

my_src_install() {
	local pydirs=(
		"${D}$(python_get_sitedir)"
		"${ED}/usr/lib/corepkg/${EPYTHON}"
	)
	local compat_dir
	local compat_module
	local entry line path ext page
	local -a entries=()

	meson_src_install

	# Older installed corepkg revisions still invoke these no-op
	# self-upgrade hooks during phase execution. Stage them here so
	# upgrading corepkg itself does not explode before the new runtime
	# has replaced the old helpers.
	compat_dir="${D}$(python_get_sitedir)/corepkg/_compat_upgrade"
	install -d "${compat_dir}" || die

	cat > "${compat_dir}/__init__.py" <<-'EOF' || die
	"""Temporary no-op shims for stale corepkg self-upgrade hooks."""
	EOF

	for compat_module in \
		binpkg_compression \
		binpkg_format \
		binpkg_multi_instance \
		default_locations \
		one_off_runner
	do
		cat > "${compat_dir}/${compat_module}.py" <<-'EOF' || die
		from __future__ import annotations

		def main(argv: list[str] | None = None) -> int:
		    return 0

		if __name__ == "__main__":
		    raise SystemExit(main())
		EOF
	done

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

	if has_version "app-core/portage" ; then
		ewarn "One-off migration: app-core/portage is installed, so overlapping bundled files are skipped for this merge."
		ewarn "Legacy app-core/portage VDB will be removed automatically after install; remerge corepkg once to complete replacement."
		shopt -s nullglob
		entries=( "${EROOT%/}"/var/db/pkg/app-core/portage-* )
		shopt -u nullglob
		for entry in "${entries[@]}" ; do
			[[ -f ${entry}/CONTENTS ]] || continue
			while IFS= read -r line ; do
				case ${line} in
					obj\ *) path=${line#obj }; path=${path%% *} ;;
					sym\ *) path=${line#sym }; path=${path%% -> *} ;;
					*) continue ;;
				esac
				[[ ${path} == /* ]] || continue
				rm -f "${ED%/}${path}" || die
				done < "${entry}/CONTENTS"
			done

		# Keep first-pass migration collision-free even if legacy manpage
		# names/compression differ from VDB entries.
		for page in dispatch-conf ebuild egencache emaint emerge emirrordist \
			env-update etc-update fixpackages glsa-check quickpkg ; do
			for ext in '' .bz2 .gz .xz .zst ; do
				rm -f "${ED%/}${EPREFIX}/usr/share/man/man1/${page}.1${ext}" || die
			done
		done
		for page in color.map ebuild make.conf xpak ; do
			for ext in '' .bz2 .gz .xz .zst ; do
				rm -f "${ED%/}${EPREFIX}/usr/share/man/man5/${page}.5${ext}" || die
			done
		done
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
	local configdir="${EROOT%/}${EPREFIX}/etc/corepkg"
	local privdir="${EROOT%/}${EPREFIX}/var/lib/corepkg"
	local homedir="${privdir}/home"
	local distdir="${EROOT%/}${EPREFIX}/var/cache/distfiles"
	local distfiles_ownership_stamp="${privdir}/compat_upgrade/one_off/20260305_distfiles_ownership.done"

	sysusers_process
	tmpfiles_process

	mkdir -p "${configdir}" || die
	mkdir -p "${homedir}" || die
	mkdir -p "${distdir}" || die

	if chown corepkg:corepkg "${homedir}" 2>/dev/null ; then
		chmod 0700 "${homedir}" || die
	else
		ewarn "Unable to set owner/group on ${homedir}; ensure it is owned by corepkg."
	fi

	if chown corepkg:corepkg "${distdir}" 2>/dev/null ; then
		chmod 2775 "${distdir}" || die
	else
		ewarn "Unable to set owner/group on ${distdir}; ensure it is writable by corepkg."
	fi

	if [[ ! -e ${distfiles_ownership_stamp} ]] ; then
		if ! chown -R corepkg:corepkg "${distdir}" 2>/dev/null ; then
			ewarn "Unable to apply one-off recursive ownership migration for ${distdir}."
		elif mkdir -p "$(dirname "${distfiles_ownership_stamp}")" && printf 'done\n' > "${distfiles_ownership_stamp}" ; then
			:
		else
			ewarn "Unable to persist distfiles ownership migration stamp: ${distfiles_ownership_stamp}"
		fi
	fi
}
