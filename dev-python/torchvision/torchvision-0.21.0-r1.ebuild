# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit cuda distutils-r1 multiprocessing

DESCRIPTION="Datasets, transforms and models to specific to computer vision"
HOMEPAGE="https://github.com/pytorch/vision"
SRC_URI="https://github.com/pytorch/vision/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.tar.gz"

S="${WORKDIR}"/vision-${PV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="cuda"

RDEPEND="
	dev-python/numpy
	xgui-app/pillow
	media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	media-libs/libwebp
	media-video/ffmpeg
	dev-python/caffe2[cuda?]
	dev-python/pytorch[${PYTHON_SINGLE_USEDEP}]
"

BDEPEND="
	test? (
		$(python_gen_cond_dep '
			dev-python/pytest-mock[${PYTHON_USEDEP}]
			dev-python/lmdb[${PYTHON_USEDEP}]
		')
	)
"

PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_prepare() {
	use cuda && cuda_src_prepare
	distutils-r1_src_prepare
}

distutils_enable_tests pytest

python_compile() {
	addpredict /dev/kfd

	FORCE_CUDA=$(usex cuda 1 0) \
		NVCC_FLAGS="${NVCCFLAGS}" \
		MAX_JOBS="$(makeopts_jobs)" \
		distutils-r1_python_compile -j1
}

python_test() {
	rm -rf torchvision || die

	local EPYTEST_IGNORE=(
		test/test_videoapi.py
	)
	local EPYTEST_DESELECT=(
		test/test_backbone_utils.py::TestFxFeatureExtraction::test_forward_backward
		test/test_backbone_utils.py::TestFxFeatureExtraction::test_jit_forward_backward
		test/test_models.py::test_classification_model
		test/test_extended_models.py::TestHandleLegacyInterface::test_pretrained_pos
		test/test_extended_models.py::TestHandleLegacyInterface::test_equivalent_behavior_weights
		test/test_image.py::test_decode_avif[decode_avif]
		test/test_image.py::test_decode_bad_encoded_data
		test/test_image.py::test_decode_gif[True-earth]
		test/test_image.py::test_decode_heic[decode_heic]
		test/test_image.py::test_decode_webp
		test/test_models.py::test_quantized_classification_model
		test/test_ops.py::test_roi_opcheck
		test/test_ops.py::TestDeformConv::test_aot_dispatch_dynamic__test_backward
		test/test_ops.py::TestDeformConv::test_aot_dispatch_dynamic__test_forward
	)
	epytest
}
