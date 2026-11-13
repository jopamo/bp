# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{11..14} )

inherit meson python-any-r1

DESCRIPTION="Fuse-filesystem utilizing the sftp service"
HOMEPAGE="https://github.com/libfuse/sshfs"
SNAPSHOT=ab648e583fe6490f910ec37414408a01fc772227
SRC_URI="https://github.com/libfuse/sshfs/archive/${SNAPSHOT}.tar.gz -> sshfs-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sshfs-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="
	app-fs/fuse:3
	lib-core/glib
	app-net/openssh"

BDEPEND="app-dev/pkgconf
	dev-pypi/docutils
	test? (
		$(python_gen_any_dep 'dev-pypi/pytest[${PYTHON_USEDEP}]')
	)"

python_check_deps() {
	python_has_version "dev-pypi/pytest[${PYTHON_USEDEP}]"
}

pkg_setup() {
	if use test; then
		python-any-r1_pkg_setup
	fi
}

src_test() {
	meson_src_test --suite unit
	cd "${BUILD_DIR}" || die
	epytest test/
}
