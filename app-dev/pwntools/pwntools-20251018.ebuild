# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="CTF framework and exploit development library"
HOMEPAGE="https://github.com/Gallopsled/pwntools"
SNAPSHOT=e02b3ba74c34b02c36761f620c93147bd9838a9c
SRC_URI="https://github.com/Gallopsled/pwntools/archive/${SNAPSHOT}.tar.gz -> pwntools-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pwntools-${SNAPSHOT}"

LICENSE="MIT GPL-2+ BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	${PYTHON_DEPS}
	>=app-emu/capstone-3.0.5[python,${PYTHON_USEDEP}]
	>=app-dev/ropgadget-5.3[${PYTHON_USEDEP}]
	>=app-emu/unicorn-1.0.2[python,${PYTHON_USEDEP}]
	dev-python/colored-traceback[${PYTHON_USEDEP}]
	>=dev-python/intervaltree-3.0[${PYTHON_USEDEP}]
	>=dev-python/mako-1.0.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/paramiko-1.15.2[${PYTHON_USEDEP}]
	>=dev-python/psutil-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/pyelftools-0.29[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.0[${PYTHON_USEDEP}]
	>=dev-python/pyserial-2.7[${PYTHON_USEDEP}]
	dev-python/pysocks[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0[${PYTHON_USEDEP}]
	dev-python/rpyc[${PYTHON_USEDEP}]
	>=dev-python/six-1.12.0[${PYTHON_USEDEP}]
	dev-python/sortedcontainers[${PYTHON_USEDEP}]
"

src_install() {
	distutils-r1_src_install

	# Disable automatic update check (bug 915496).
	#insinto /etc
	#doins "${FILESDIR}/pwn.conf"

	rm -r "${ED}/usr/pwntools-doc" || die
}
