# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1

DESCRIPTION="Run your *raw* PyTorch training script on any kind of device"
HOMEPAGE="https://github.com/huggingface/accelerate"
SRC_URI="https://github.com/huggingface/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/huggingface_hub[${PYTHON_SINGLE_USEDEP}]
	dev-python/pytorch[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/safetensors[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="test? (
	$(python_gen_cond_dep '
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/parameterized[${PYTHON_USEDEP}]
		dev-python/clearml[${PYTHON_USEDEP}]
	')
	dev-python/caffe2[gloo]
	dev-python/evaluate[${PYTHON_SINGLE_USEDEP}]
	dev-python/torchdata[${PYTHON_SINGLE_USEDEP}]
)"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		tests/test_modeling_utils.py::ModelingUtilsTester::test_infer_auto_device_map_with_buffer_check
		tests/test_modeling_utils.py::ModelingUtilsTester::test_infer_auto_device_map_with_buffer_check_and_multi_devices
		tests/test_modeling_utils.py::ModelingUtilsTester::test_infer_auto_device_map_with_fallback_allocation_and_buffers
		tests/test_utils.py::UtilsTester::test_patch_environment_key_exists
		tests/test_examples.py::FeatureExamplesTests
	)
	epytest tests
}
