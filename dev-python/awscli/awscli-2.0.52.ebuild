# Distributed under the terms of the GNU General Public License v2

EAPI=8


inherit distutils-r1

DESCRIPTION="Universal Command Line Environment for AWS"
HOMEPAGE="https://pypi.org/project/awscli/"
SRC_URI="https://github.com/aws/aws-cli/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
#KEYWORDS="amd64 arm64"
#Missing Deps

IUSE="test"

RESTRICT="test"

RDEPEND="
	>=dev-python/botocore-1.12.81[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	>=dev-python/s3transfer-0.1.12[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/aws-cli-${PV}"

python_test() {
	nosetests -vv || die
}

python_install_all() {
	distutils-r1_python_install_all

	rm "${ED%/}"/usr/bin/{aws.cmd,aws_bash_completer,aws_zsh_completer.sh} || die
}
