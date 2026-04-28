# Distributed under the terms of the GNU General Public License v2
#
# @ECLASS: lockstep-cargo.eclass
# @BLURB: Consume lockstep-managed rust-crates packages as Cargo vendor input
#

if [[ -z ${_LOCKSTEP_LOCKSTEP_CARGO_ECLASS} ]]; then
	_LOCKSTEP_LOCKSTEP_CARGO_ECLASS=1

	LOCKSTEP_CARGO_PACKAGE_ROOT="/usr/share/lockstep/cargo-crates"

	_lockstep_cargo_trim_ws() {
		local value=${1}

		value=${value#"${value%%[![:space:]]*}"}
		value=${value%"${value##*[![:space:]]}"}

		printf '%s\n' "${value}"
	}

	_lockstep_cargo_ref_version() {
		local ref=${1#rust-crates/}
		printf '%s\n' "${ref##*-}"
	}

	_lockstep_cargo_ref_crate() {
		local ref=${1#rust-crates/}
		local version=${ref##*-}
		printf '%s\n' "${ref%-${version}}"
	}

	_lockstep_cargo_dependency_atoms() {
		local ref atoms=

		while IFS= read -r ref; do
			ref=$(_lockstep_cargo_trim_ws "${ref}")
			[[ -n ${ref} ]] || continue
			atoms+=$'\n\t'"${ref}"
		done <<< "${CARGO_DEPS-}"

		printf '%s\n' "${atoms}"
	}

	_lockstep_cargo_populate_vendor() {
		local ref crate version sysroot source_dir dest_dir

		rm -rf "${ECARGO_VENDOR}"
		mkdir -p "${ECARGO_VENDOR}" || die

		while IFS= read -r ref; do
			ref=$(_lockstep_cargo_trim_ws "${ref}")
			[[ -n ${ref} ]] || continue

			crate=$(_lockstep_cargo_ref_crate "${ref}")
			version=$(_lockstep_cargo_ref_version "${ref}")
			sysroot=${ESYSROOT%/}
			source_dir="${sysroot}${LOCKSTEP_CARGO_PACKAGE_ROOT}/${crate}/${version}"
			dest_dir="${ECARGO_VENDOR}/${crate}-${version}"

			[[ -d ${source_dir} ]] || die "missing installed cargo crate package contents: ${source_dir}"
			mkdir -p "${dest_dir}" || die
			cp -pR "${source_dir}/." "${dest_dir}/" || die "failed staging ${ref}"
		done <<< "${CARGO_DEPS-}"
	}

	_LOCKSTEP_CARGO_DEPEND=$(_lockstep_cargo_dependency_atoms)
	DEPEND+="${_LOCKSTEP_CARGO_DEPEND}"
	BDEPEND+="
		app-dev/cargo
		app-dev/rust"

	inherit cargo

	lockstep-cargo_src_unpack() {
		[[ -d ${S} ]] || default
	}

	cargo_gen_config() {
		export CARGO_HOME="${ECARGO_HOME}"
		mkdir -p "${CARGO_HOME}" || die
		rm -f "${CARGO_HOME}/config.toml"

		[[ -n ${CARGO_DEPS-} ]] || die "lockstep-cargo.eclass requires CARGO_DEPS"
		_lockstep_cargo_populate_vendor

		cat > "${CARGO_HOME}/config.toml" <<-EOF_CONFIG || die "failed writing ${CARGO_HOME}/config.toml"
			[source.crates-io]
			replace-with = "bp-lockstep-vendor"

			[source.bp-lockstep-vendor]
			directory = "${ECARGO_VENDOR}"
		EOF_CONFIG
	}

	EXPORT_FUNCTIONS src_unpack
fi
