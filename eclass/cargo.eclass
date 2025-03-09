# Copyright 2025 Gentoo
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: cargo.eclass
# @SUPPORTED_EAPIS: 7 8
#
# A minimal eclass to vendor crates from multiple Cargo.toml files

case "${EAPI:-0}" in
	7|8) ;;
	*) die "cargo.eclass: EAPI=${EAPI} is not supported" ;;
esac

if [[ -z ${_CARGO_VENDOR_ECLASS} ]]; then
	_CARGO_VENDOR_ECLASS=1

	# If you want to skip tests or the network sandbox, you can set:
	#   RESTRICT="test network-sandbox"
	# For a fully offline approach, we do not *require* it, but many Rust
	# packages skip tests or require additional steps to test fully offline.
	RESTRICT="test"

	# Example: Ensure we have a recent rust/cargo
	DEPEND+=" >=virtual/rust-1.60.0"
	RDEPEND="${DEPEND}"
	BDEPEND="${DEPEND}"

	IUSE="debug"

	# -- Ebuild-supplied variable with the paths to each Cargo.toml you want
	#    to vendor. Example in your ebuild:
	#       CARGO_TOML_FILES=(
	#         ./Cargo.toml
	#         ./src/tools/rust-analyzer/Cargo.toml
	#         ./src/bootstrap/Cargo.toml
	#         ...
	#       )
	: "${CARGO_TOML_FILES:=}"

	# Directory to place vendored crates and cargo config
	ECARGO_HOME="${WORKDIR}/cargo_home"
	ECARGO_VENDOR="${S}/vendor"

	#-----------------------------------------------------------------------------
	# 1. cargo_src_unpack
	#-----------------------------------------------------------------------------
	cargo_src_unpack() {
		default  # Unpack main source tarballs
		cargo_src_vendor
	}

	#-----------------------------------------------------------------------------
	# 2. cargo_src_vendor
	#-----------------------------------------------------------------------------
	cargo_src_vendor() {
		[[ -n "${CARGO_TOML_FILES[*]}" ]] \
			|| die "No Cargo.toml files listed in CARGO_TOML_FILES"

		# Prepare a place for cargo_home & vendor.
		mkdir -p "${ECARGO_HOME}" "${ECARGO_VENDOR}" || die

		# Jump to S for consistency; cargo must see the local paths.
		cd "${S}" || die "Could not cd to ${S}"

		# Build up the arguments to --sync each Cargo.toml
		local sync_args=()
		local toml
		for toml in "${CARGO_TOML_FILES[@]}"; do
			sync_args+=( --sync "${toml}" )
		done

		# Actually run cargo vendor. We include `--locked` if you want to enforce
		# exact versions from Cargo.lock, but that requires each Cargo.toml has a
		# corresponding Cargo.lock. Adjust as needed.
		einfo "Vendoring crates to ${ECARGO_VENDOR}"
		cargo vendor \
			--locked \
			"${sync_args[@]}" \
			--versioned-dirs \
			--quiet \
			--directory "${ECARGO_VENDOR}" \
			|| die "cargo vendor failed"

		# Generate a .cargo/config that points crates-io to the vendored directory.
		mkdir -p "${S}/.cargo" || die
		cat > "${S}/.cargo/config" <<-EOF || die "Failed writing .cargo/config"
			[source.crates-io]
			replace-with = "vendored-sources"

			[source.vendored-sources]
			directory = "${ECARGO_VENDOR}"
		EOF
	}

	#-----------------------------------------------------------------------------
	# 3. cargo_src_compile
	#-----------------------------------------------------------------------------
	cargo_src_compile() {
		cd "${S}" || die "Could not cd to ${S}"
		local build_mode=
		use debug || build_mode="--release"

		einfo "Building with cargo build ${build_mode}"
		cargo build ${build_mode} || die "cargo build failed"
	}

	#-----------------------------------------------------------------------------
	# 4. cargo_src_test
	#-----------------------------------------------------------------------------
	cargo_src_test() {
		cd "${S}" || die "Could not cd to ${S}"
		local build_mode=
		use debug || build_mode="--release"

		einfo "Testing with cargo test ${build_mode} (offline)"
		cargo test ${build_mode} --offline \
			|| die "cargo test failed"
	}

	#-----------------------------------------------------------------------------
	# 5. cargo_src_install
	#-----------------------------------------------------------------------------
	cargo_src_install() {
		cd "${S}" || die "Could not cd to ${S}"
		local build_mode=
		use debug || build_mode="--release"

		einfo "Installing with cargo install ${build_mode} --offline"
		cargo install \
			--path . \
			${build_mode} \
			--root="${D}/usr" \
			|| die "cargo install failed"

		rm -f "${D}/usr/.crates.toml" "${D}/usr/.crates2.json" || die
	}

	EXPORT_FUNCTIONS src_unpack src_compile src_test src_install
fi
