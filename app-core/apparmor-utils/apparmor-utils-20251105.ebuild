# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
inherit distutils-r1 toolchain-funcs desktop

DESCRIPTION="Additional userspace utils to assist with AppArmor profile management"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=ab57944221de7abd348fd42eeabc35b3657dec57
SRC_URI="https://gitlab.com/apparmor/apparmor/-/archive/${SNAPSHOT}/apparmor-${SNAPSHOT}.tar.bz2 -> apparmor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/apparmor-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

COMMON_DEPEND="
	~lib-core/libapparmor-${PV}
	${PYTHON_DEPS}"
DEPEND="${COMMON_DEPEND}
	app-build/gettext
"
RDEPEND="${COMMON_DEPEND}
	~lib-core/libapparmor-${PV}[python,${PYTHON_USEDEP}]
	~app-core/apparmor-${PV}
	dev-python/psutil[${PYTHON_USEDEP}]"

src_prepare() {
	default

	sed -i binutils/Makefile \
		-e 's/Bstatic/Bdynamic/g' || die

	sed -i utils/aa-remove-unknown \
		-e 's#^\(APPARMOR_FUNCTIONS=\).*#\1/usr/libexec/rc.apparmor.functions#' || die
}

src_compile() {
	python_setup

	pushd utils > /dev/null || die
	# launches non-make subprocesses causing "make jobserver unavailable"
	# error messages to appear in generated code
	emake -j1
	popd > /dev/null || die

	pushd binutils > /dev/null || die
	export EXTRA_CFLAGS="${CFLAGS}"
	emake CC="$(tc-getCC)" USE_SYSTEM=1
	popd > /dev/null || die
}

src_install() {
	pushd utils > /dev/null || die
	emake \
		SBINDIR="${ED}/usr/bin" \
	    USR_SBINDIR="${ED}/usr/bin" \
		CPP="$(tc-getCPP) -" \
		DESTDIR="${ED}" \
		DISTRO="unknown" \
		VIM_INSTALL_PATH="${D}/usr/share/vim/vimfiles/syntax" \
		USE_SYSTEM=1 \
		install

	install_python() {
		local -x PYTHONDONTWRITEBYTECODE=
		"${PYTHON}" "${S}"/utils/python-tools-setup.py install --prefix=/usr \
			--root="${D}" --optimize 2 --version=${PV}
	}

	python_foreach_impl install_python
	python_replicate_script "${D}"/usr/bin/aa-easyprof \
		"${D}"/usr/sbin/aa-{audit,autodep,cleanprof,complain,disable,enforce,genprof,logprof,mergeprof,notify,unconfined}
	domenu aa-notify.desktop
	popd > /dev/null || die

	pushd binutils > /dev/null || die
	emake \
		SBINDIR="${ED}/usr/bin" \
	    USR_SBINDIR="${ED}/usr/bin" \
		CPP="$(tc-getCPP) -" \
		DESTDIR="${ED}" \
		DISTRO="unknown" \
		USE_SYSTEM=1 \
		install
	popd > /dev/null || die

	dedup_symlink "${ED}"
	cleanup_install
}
