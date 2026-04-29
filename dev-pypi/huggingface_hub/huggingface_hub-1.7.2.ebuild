# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/filelock
	dev-pypi/fsspec
	dev-pypi/hf-xet
	dev-pypi/httpx
	dev-pypi/packaging
	dev-pypi/pyyaml
	dev-pypi/tqdm
	dev-pypi/typer
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
DESCRIPTION="a client library to interact with the Hugging Face Hub"
HOMEPAGE="
	https://pypi.org/project/huggingface_hub/
"
SRC_URI="https://github.com/huggingface/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	$(python_gen_cond_dep '
		dev-pypi/filelock[${PYTHON_USEDEP}]
		dev-pypi/fsspec[${PYTHON_USEDEP}]
		dev-pypi/httpx[${PYTHON_USEDEP}]
		dev-pypi/packaging[${PYTHON_USEDEP}]
		dev-pypi/pyyaml[${PYTHON_USEDEP}]
		dev-pypi/tqdm[${PYTHON_USEDEP}]
		dev-pypi/typer[${PYTHON_USEDEP}]
		dev-pypi/typing-extensions[${PYTHON_USEDEP}]
		dev-pypi/hf_xet[${PYTHON_USEDEP}]
	')
"

BDEPEND="test? (
		dev-py/pytorch[${PYTHON_SINGLE_USEDEP}]
	)"

distutils_enable_tests pytest

src_test() {
	local EPYTEST_IGNORE=(
		contrib
		tests/test_cache_layout.py
		#tests/test_cache_no_symlinks.py
		#tests/test_command_delete_cache.py
		tests/test_commit_scheduler.py
		tests/test_file_download.py
		tests/test_hf_api.py
		tests/test_hf_file_system.py
		#tests/test_inference_api.py
		#tests/test_inference_client.py
		tests/test_oauth.py
		tests/test_repocard.py
		#tests/test_repository.py
		tests/test_snapshot_download.py
		tests/test_utils_telemetry.py
		#tests/test_xet_download.py
		tests/test_xet_upload.py
		tests/test_utils_cache.py
		#tests/test_utils_http.py
		tests/test_webhooks_server.py
	)

	local EPYTEST_DESELECT=(
		#tests/test_cli.py::TestJobsCommand::test_uv_local_script
		tests/test_hub_mixin.py::HubMixinTest::test_push_to_hub
		tests/test_hub_mixin_pytorch.py::PytorchHubMixinTest::test_push_to_hub
		#tests/test_inference_async_client.py::test_async_generate_timeout_error
		#tests/test_inference_providers.py::TestHFInferenceProvider::test_prepare_mapping_info_unknown_task
		#tests/test_offline_utils.py::test_offline_with_timeout
		#tests/test_utils_pagination.py::TestPagination::test_paginate_hf_api

	)

	distutils-r1_src_test
}
