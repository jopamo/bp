# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson linux-info multiprocessing python-r1 flag-o-matic user

DESCRIPTION="Gentoo package manager"
HOMEPAGE="https://github.com/gentoo/portage"
SNAPSHOT=432c18cc91037ba1a3a253fee00e66b820a1df33
SRC_URI="https://github.com/gentoo/portage/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/portage-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="build gentoo-dev ipc native-extensions
	gentoo_repo tmpfilesd +rsync-verify selinux test xattr"

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
	app-var/eselect
	dev-py/lxml[${PYTHON_USEDEP}]
"
PDEPEND="app-net/rsync"

PATCHES=(
	"${FILESDIR}"/phase-helpers.patch
)

pkg_pretend() {
	local CONFIG_CHECK="~IPC_NS ~PID_NS ~NET_NS ~UTS_NS"

	check_extra_config
}

src_prepare() {
	filter-flags -Wl,-z,defs

	make_globals="./cnf/make.globals"

	sed -i '/GENTOO_MIRRORS/c\GENTOO_MIRRORS="https://1g4.org"' "$make_globals"

	if ! grep -q 'ACCEPT_LICENSE' "$make_globals"; then
    	echo 'ACCEPT_LICENSE="*"' >> "$make_globals"
	fi

	default

	cp "${FILESDIR}"/eapi7-ver-funcs.sh bin/ || die

	cat <<EOF >> "$make_globals"
# Try to save bandwidth/disk space
EGIT_CLONE_TYPE=shallow

BINPKG_COMPRESS="zstd"
BINPKG_COMPRESS_FLAGS="-e9"
BINPKG_FORMAT="gpkg"
EOF
}

src_configure() {
	local code_only=false
	python_foreach_impl my_src_configure
}

my_src_configure() {
	local emesonargs=(
		-Dcode-only=${code_only}
		-Deprefix="${EPREFIX}"
		-Dsbindir="${EPREFIX}"/usr/bin
		-Dportage-bindir="${EPREFIX}/usr/lib/portage/${EPYTHON}"
		-Ddocdir="${EPREFIX}/usr/share/doc/${PF}"
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

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		newins "${FILESDIR}/portage-tmpfiles" portage.conf
	fi

	local scripts
	mapfile -t scripts < <(awk '/^#!.*python/ {print FILENAME} {nextfile}' "${ED}"/usr/bin/* || die)
	python_replicate_script "${scripts[@]}"

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
}

my_src_install() {
	local pydirs=(
		"${D}$(python_get_sitedir)"
		"${ED}/usr/lib/portage/${EPYTHON}"
	)

	meson_src_install
	python_optimize "${pydirs[@]}"
	python_fix_shebang "${pydirs[@]}"
}

pkg_preinst() {
	if ! use build && [[ -z ${ROOT} ]]; then
		python_setup
		local sitedir=$(python_get_sitedir)
		[[ -d ${D}${sitedir} ]] || die "${D}${sitedir}: No such directory"
		env -u DISTDIR \
			-u PORTAGE_OVERRIDE_EPREFIX \
			-u PORTAGE_REPOSITORIES \
			-u PORTDIR \
			-u PORTDIR_OVERLAY \
			PYTHONPATH="${D}${sitedir}${PYTHONPATH:+:${PYTHONPATH}}" \
			"${PYTHON}" -m portage._compat_upgrade.default_locations || die

		env -u BINPKG_COMPRESS -u PORTAGE_REPOSITORIES \
			PYTHONPATH="${D}${sitedir}${PYTHONPATH:+:${PYTHONPATH}}" \
			"${PYTHON}" -m portage._compat_upgrade.binpkg_compression || die

		env -u FEATURES -u PORTAGE_REPOSITORIES \
			PYTHONPATH="${D}${sitedir}${PYTHONPATH:+:${PYTHONPATH}}" \
			"${PYTHON}" -m portage._compat_upgrade.binpkg_multi_instance || die
	fi

	# elog dir must exist to avoid logrotate error for bug #415911.
	# This code runs in preinst in order to bypass the mapping of
	# portage:portage to root:root which happens after src_install.
	keepdir /var/log/portage/elog
	# This is allowed to fail if the user/group are invalid for prefix users.
	if chown portage:portage "${ED}"/var/log/portage{,/elog} 2>/dev/null ; then
		chmod g+s,ug+rwx "${ED}"/var/log/portage{,/elog}
	fi

	newsysusers "${FILESDIR}/${PN}-sysusers" "${PN}.conf"
}

pkg_postinst() {
	sysusers_process
}

