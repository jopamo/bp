# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs unpacker

MYD=$(ver_cut 1-2)
DRIVER_PV="$(ver_cut 4-6)"
PV="$(ver_cut 1-3)"

DESCRIPTION="NVIDIA CUDA Toolkit (compiler and friends)"
HOMEPAGE="https://developer.nvidia.com/cuda-zone"
SRC_URI="https://developer.download.nvidia.com/compute/cuda/${PV}/local_installers/cuda_${PV}_${DRIVER_PV}_linux.run"

LICENSE="NVIDIA-CUDA"
SLOT="0"
#KEYWORDS="amd64"

IUSE="debugger sanitizer"

RESTRICT="mirror strip"

DEPEND="bin/nvidia-drivers"

S="${WORKDIR}"

QA_PREBUILT="opt/cuda/*"

src_install() {
	local cudadir=/opt/cuda
	local ecudadir="${EPREFIX}${cudadir}"
	dodir ${cudadir}
	into ${cudadir}

	# Install standard sub packages
	local builddirs=(
		builds/cuda_{cccl,crt,ctadvisor,cudart,culibos,cuobjdump,cupti,cuxxfilt,nvcc,nvdisasm,nvml_dev,nvprune,nvrtc,nvtx,opencl}
		builds/lib{cublas,cufft,cufile,curand,cusolver,cusparse,npp,nvfatbin,nvfatbin,nvjitlink,nvjpeg,nvptxcompiler}
		$(usex debugger "builds/cuda_gdb" "")
	)

	local d
	for d in "${builddirs[@]}"; do
		[[ -d ${d} ]] || die "Directory does not exist: ${d}"

		if [[ -d ${d}/bin ]]; then
			local f
			for f in ${d}/bin/*; do
				if [[ -f ${f} ]]; then
					dobin "${f}"
				else
					insinto ${cudadir}/bin
					doins -r "${f}"
				fi
			done
		fi

		insinto ${cudadir}
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
	# nvml and nvvm need special handling
	doins -r builds/libnvvm/nvvm
	exeinto ${cudadir}/nvvm/bin
	doexe builds/libnvvm/nvvm/bin/cicc

	doins -r builds/cuda_nvml_dev/nvml

	if use sanitizer; then
		dobin "${S}"/builds/integration/Sanitizer/compute-sanitizer
		doins -r "${S}"/builds/cuda_sanitizer_api/compute-sanitizer/
		exeinto ${cudadir}/Sanitizer
		doexe "${S}"/builds/cuda_sanitizer_api/compute-sanitizer/compute-sanitizer
	fi

	# Add include and lib symlinks
	dosym "targets/x86_64-linux/include" ${cudadir}/include
	dosym "targets/x86_64-linux/lib" ${cudadir}/lib

	newenvd - 99cuda <<-EOF
		PATH=${ecudadir}/bin:${ecudadir}/nvvm/bin
		LDPATH=${ecudadir}/lib:${ecudadir}/nvvm/lib64
	EOF

	# Cuda prepackages libraries, don't revdep-build on them
	insinto /etc/revdep-rebuild
	newins - 80nvidia-cuda <<-EOF
		SEARCH_DIRS_MASK="${ecudadir}"
	EOF
}
