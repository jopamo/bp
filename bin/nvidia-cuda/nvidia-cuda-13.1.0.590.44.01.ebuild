# Distributed under the terms of the GNU General Public License v2

inherit unpacker

MYD=$(ver_cut 1-2)
DRIVER_PV="$(ver_cut 4-6)"
PV="$(ver_cut 1-3)"

DESCRIPTION="NVIDIA CUDA Toolkit (compiler and friends)"
HOMEPAGE="https://developer.nvidia.com/cuda-zone"
SRC_URI="https://developer.download.nvidia.com/compute/cuda/${PV}/local_installers/cuda_${PV}_${DRIVER_PV}_linux.run"

LICENSE="NVIDIA-CUDA"
SLOT="0"
#KEYWORDS="amd64"
S="${WORKDIR}"

IUSE="debugger sanitizer"

RESTRICT="mirror strip"

DEPEND="bin/nvidia-drivers"
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="opt/cuda/*"

src_install() {
	local cudadir=/opt/cuda
	local ecudadir="${EPREFIX}${cudadir}"
	local target=x86_64-linux
	local targetdir="${cudadir}/targets/${target}"

	dodir "${cudadir}"
	into "${cudadir}"

	# Install standard subpackages
	local builddirs=(
		builds/cuda_{cccl,crt,ctadvisor,cudart,culibos,cuobjdump,cupti,cuxxfilt,nvcc,nvdisasm,nvml_dev,nvprune,nvrtc,nvtx,opencl}
		builds/lib{cublas,cufft,cufile,curand,cusolver,cusparse,npp,nvfatbin,nvjitlink,nvjpeg,nvptxcompiler}
		$(usex debugger "builds/cuda_gdb" "")
	)

	local d
	for d in "${builddirs[@]}"; do
		[[ -n ${d} ]] || continue
		[[ -d ${d} ]] || die "Directory does not exist: ${d}"

		if [[ -d ${d}/bin ]]; then
			local f
			for f in "${d}"/bin/*; do
				[[ -e ${f} ]] || continue

				if [[ -f ${f} ]]; then
					dobin "${f}"
				else
					insinto "${cudadir}/bin"
					doins -r "${f}"
				fi
			done
		fi

		insinto "${cudadir}"

		if [[ -d ${d}/targets ]]; then
			doins -r "${d}"/targets
		fi

		if [[ -d ${d}/share ]]; then
			doins -r "${d}"/share
		fi

		if [[ -d ${d}/extras ]]; then
			doins -r "${d}"/extras
		fi
	done

	doins builds/EULA.txt

	# nvvm needs executable handling for cicc
	doins -r builds/libnvvm/nvvm
	exeinto "${cudadir}/nvvm/bin"
	doexe builds/libnvvm/nvvm/bin/cicc

	# nvml development files are shipped outside the normal target tree
	doins -r builds/cuda_nvml_dev/nvml

	if use sanitizer; then
		dobin "${S}"/builds/integration/Sanitizer/compute-sanitizer

		insinto "${cudadir}/Sanitizer"
		doins -r "${S}"/builds/cuda_sanitizer_api/compute-sanitizer/

		exeinto "${cudadir}/Sanitizer"
		doexe "${S}"/builds/cuda_sanitizer_api/compute-sanitizer/compute-sanitizer
	fi

	# Common CUDA discovery paths
	dosym -r "${targetdir}/include" "${cudadir}/include"
	dosym -r "${targetdir}/lib" "${cudadir}/lib"
	dosym -r "${targetdir}/lib" "${cudadir}/lib64"

	# Some build systems probe lib64 below the target tuple
	dosym -r "${targetdir}/lib" "${targetdir}/lib64"

	newenvd - 99cuda <<-EOF
		CUDA_HOME=${ecudadir}
		CUDA_PATH=${ecudadir}
		CUDAToolkit_ROOT=${ecudadir}
		CUDACXX=${ecudadir}/bin/nvcc
		PATH=${ecudadir}/bin:${ecudadir}/nvvm/bin
		ROOTPATH=${ecudadir}/bin:${ecudadir}/nvvm/bin
		LDPATH=${ecudadir}/lib64:${ecudadir}/lib:${ecudadir}/targets/${target}/lib:${ecudadir}/nvvm/lib64
	EOF

	insinto /etc/profile.d
	newins - cuda.sh <<-EOF
		export CUDA_HOME=${ecudadir}
		export CUDA_PATH=${ecudadir}
		export CUDAToolkit_ROOT=${ecudadir}
		export CUDACXX=${ecudadir}/bin/nvcc
		export PATH=${ecudadir}/bin:${ecudadir}/nvvm/bin:\${PATH}
	EOF

	# CUDA packages prebuilt libraries, so keep revdep-rebuild away from them
	insinto /etc/revdep-rebuild
	newins - 80nvidia-cuda <<-EOF
		SEARCH_DIRS_MASK="${ecudadir}"
	EOF
}
