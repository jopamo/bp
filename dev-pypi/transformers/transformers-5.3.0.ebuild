# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/huggingface-hub
	dev-pypi/numpy
	dev-pypi/packaging
	dev-pypi/pyyaml
	dev-pypi/regex
	dev-pypi/safetensors
	dev-pypi/tokenizers
	dev-pypi/tqdm
	dev-pypi/typer
"
# lockstep-pypi-deps: end
DESCRIPTION="State-of-the-art Machine Learning for JAX, PyTorch and TensorFlow"
HOMEPAGE="
	https://pypi.org/project/transformers/
	https://huggingface.co/
"
SRC_URI="https://github.com/huggingface/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="torch"
RESTRICT="test" # Need network, too long to execute

RDEPEND="
	>=dev-pypi/huggingface_hub-0.34.0[${PYTHON_SINGLE_USEDEP}]
	<dev-pypi/huggingface_hub-1
	=dev-pypi/tokenizers-0.22*[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-pypi/filelock[${PYTHON_USEDEP}]
		dev-pypi/numpy[${PYTHON_USEDEP}]
		dev-pypi/packaging[${PYTHON_USEDEP}]
		dev-pypi/pyyaml[${PYTHON_USEDEP}]
		dev-py/regex[${PYTHON_USEDEP}]
		dev-pypi/requests[${PYTHON_USEDEP}]
		dev-pypi/tqdm[${PYTHON_USEDEP}]
		dev-pypi/safetensors[${PYTHON_USEDEP}]
	')
	torch? (
		dev-pypi/accelerate[${PYTHON_SINGLE_USEDEP}]
		dev-py/caffe2[${PYTHON_SINGLE_USEDEP}]
		dev-py/pytorch[${PYTHON_SINGLE_USEDEP}]
	)
"

distutils_enable_tests import-check
