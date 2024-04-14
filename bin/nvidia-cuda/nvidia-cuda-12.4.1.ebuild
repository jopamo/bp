# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs unpacker

MYD=$(ver_cut 1-2)
DRIVER_PV="550.54.15"

DESCRIPTION="NVIDIA CUDA Toolkit (compiler and friends)"
HOMEPAGE="https://developer.nvidia.com/cuda-zone"
SRC_URI="https://developer.download.nvidia.com/compute/cuda/${PV}/local_installers/cuda_${PV}_${DRIVER_PV}_linux.run"

LICENSE="NVIDIA-CUDA"
SLOT="0"
KEYWORDS="amd64"

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
		builds/cuda_{cudart,cuobjdump,nvcc,nvdisasm,nvml_dev,nvprune,nvrtc,nvtx}
		builds/lib{cublas,cufft,curand,cusolver,cusparse,npp,nvjpeg}
		$(usex debugger "builds/cuda_gdb" "")
	)

	local d
	for d in "${builddirs[@]}"; do
		ebegin "Installing ${d}"
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
		eend
	done

	doins builds/EULA.txt
	# nvml and nvvm need special handling
	ebegin "Installing nvvm"
	doins -r builds/cuda_nvcc/nvvm
	exeinto ${cudadir}/nvvm/bin
	doexe builds/cuda_nvcc/nvvm/bin/cicc
	eend

	ebegin "Installing nvml"
	doins -r builds/cuda_nvml_dev/nvml
	eend

	if use sanitizer; then
		ebegin "Installing sanitizer"
		dobin builds/integration/Sanitizer/compute-sanitizer
		doins -r builds/cuda_sanitizer_api/Sanitizer
		# special handling for the executable
		exeinto ${cudadir}/Sanitizer
		doexe builds/cuda_sanitizer_api/Sanitizer/compute-sanitizer
		eend
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
	newins - 80${PN} <<-EOF
		SEARCH_DIRS_MASK="${ecudadir}"
	EOF
	# TODO: Find a better way to add +x permission to installed executables
	# TODO: Add pkgconfig files for installed libraries
}
