# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=meson-python
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

TEST_DATA_COMMIT=15735b54e85c02427f07c71e6456723495034805
DESCRIPTION="Image processing routines for SciPy"
HOMEPAGE="
	https://scikit-image.org/
	https://github.com/scikit-image/scikit-image/
	https://pypi.org/project/scikit-image/
"
SRC_URI+="
	test? (
		https://gitlab.com/scikit-image/data/-/archive/${TEST_DATA_COMMIT}/scikit-image-data-${TEST_DATA_COMMIT}.tar.bz2
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/imageio-2.36[${PYTHON_USEDEP}]
	>=dev-python/lazy-loader-0.4[${PYTHON_USEDEP}]
	>=dev-python/networkx-3.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	>=xgui-app/pillow-10.1[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.11.4[sparse(+),${PYTHON_USEDEP}]
	>=dev-python/tifffile-2022.8.12[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/pythran[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-py/cython-3.0.4[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pythran[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-localserver[${PYTHON_USEDEP}]
	)
"

# xdist does not work with this test suite
distutils_enable_tests pytest
# There is a programmable error in your configuration file:
#distutils_enable_sphinx doc/source dev-python/numpydoc dev-python/myst-parser

src_test() {
	# for some reason, upstream refetches data that's already in the tarball
	# sigh
	mkdir -p "${HOME}/.cache/scikit-image" || die
	mv skimage "${HOME}/.cache/scikit-image/${PV/_/}" || die

	# This is a true horror, sigh
	local cache_dir=${HOME}/.cache/scikit-image/${PV/_/}/data
	pushd "${WORKDIR}/data-${TEST_DATA_COMMIT}" >/dev/null || die
	cp Tests_besides_Equalize_Otsu/add18_entropy/rank_filters_tests_3d.npz \
		Tests_besides_Equalize_Otsu/gray_morph_output.npz \
		brain.tiff cells3d.tif eagle.png \
		"${cache_dir}/" || die
	cp Normal_Epidermis_and_Dermis_with_Intradermal_Nevus_10x.JPG "${cache_dir}"/skin.jpg || die
	cp pivchallenge/B/B001_1.tif "${cache_dir}"/pivchallenge-B-B001_1.tif || die
	cp pivchallenge/B/B001_2.tif "${cache_dir}"/pivchallenge-B-B001_2.tif || die
	cp kidney-tissue-fluorescence.tif "${cache_dir}"/kidney.tif || die
	cp lily-of-the-valley-fluorescence.tif "${cache_dir}"/lily.tif || die
	cp astronaut_rl.npy "${cache_dir}/../restoration/tests/" || die
	popd > /dev/null || die

	distutils-r1_src_test
}

python_test() {
	local EPYTEST_DESELECT=(
		# tests for downloading all data files, including these not needed
		# by any actual tests
		data/tests/test_data.py::test_download_all_with_pooch
		# hangs? TODO
		graph/tests/test_rag.py::test_reproducibility
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest --pyargs skimage -p localserver -o xfail_strict=False
}

pkg_postinst() {
 "FITS io capability" dev-python/astropy
 "GTK" dev-python/pygtk
 "io plugin providing most standard formats" dev-python/imread
 "plotting" dev-python/matplotlib
 "wavelet transformations" dev-python/pywavelets
 "io plugin providing a wide variety of formats, including specialized formats using in medical imaging." dev-python/simpleitk
}
