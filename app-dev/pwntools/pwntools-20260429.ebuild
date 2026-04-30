# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/capstone
	dev-pypi/colored-traceback
	dev-pypi/intervaltree
	dev-pypi/mako
	dev-pypi/packaging
	dev-pypi/paramiko
	dev-pypi/psutil
	dev-pypi/pyelftools
	dev-pypi/pygments
	dev-pypi/pyserial
	dev-pypi/pysocks
	dev-pypi/requests
	dev-pypi/ropgadget
	dev-pypi/rpyc
	dev-pypi/sortedcontainers
	dev-pypi/unicorn
	dev-pypi/unix-ar
	dev-pypi/zstandard
"
# lockstep-pypi-deps: end
DESCRIPTION="CTF framework and exploit development library"
HOMEPAGE="https://github.com/Gallopsled/pwntools"
SNAPSHOT=52a354b3161c68d79c39840bcd2f22f73403190c
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
	dev-pypi/colored-traceback[${PYTHON_USEDEP}]
	>=dev-pypi/intervaltree-3.0[${PYTHON_USEDEP}]
	>=dev-pypi/mako-1.0.0[${PYTHON_USEDEP}]
	dev-pypi/packaging[${PYTHON_USEDEP}]
	>=dev-pypi/paramiko-1.15.2[${PYTHON_USEDEP}]
	>=dev-pypi/psutil-3.3.0[${PYTHON_USEDEP}]
	>=dev-pypi/pyelftools-0.29[${PYTHON_USEDEP}]
	>=dev-pypi/pygments-2.0[${PYTHON_USEDEP}]
	>=dev-pypi/pyserial-2.7[${PYTHON_USEDEP}]
	dev-pypi/pysocks[${PYTHON_USEDEP}]
	dev-pypi/python-dateutil[${PYTHON_USEDEP}]
	>=dev-pypi/requests-2.0[${PYTHON_USEDEP}]
	dev-pypi/rpyc[${PYTHON_USEDEP}]
	>=dev-pypi/six-1.12.0[${PYTHON_USEDEP}]
	dev-pypi/sortedcontainers[${PYTHON_USEDEP}]
"

src_install() {
	distutils-r1_src_install

	# Disable automatic update check (bug 915496).
	#insinto /etc
	#doins "${FILESDIR}/pwn.conf"

	rm -r "${ED}/usr/pwntools-doc" || die
}
