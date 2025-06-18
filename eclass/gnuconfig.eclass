# @ECLASS: gnuconfig.eclass
# @SUPPORTED_EAPIS: 7 8
# @DESCRIPTION:
# Implementation of a gnuconfig eclass for updating config.guess, config.sub,
# and similar automake-provided helper files to a newer system copy.
# Compatible with ebuilds calling gnuconfig_update or referencing older logic.

if [[ -z ${_GNUCONFIG_ECLASS} ]]; then
  _GNUCONFIG_ECLASS=1

  case "${EAPI:-0}" in
    7|8) ;;
    *) die "gnuconfig.eclass: EAPI ${EAPI:-0} is not supported" ;;
  esac

  : "${GNUCONFIG_DEPEND:=app-build/gnuconfig}"
  : "${GNUCONFIG_AUTO_DEPEND:=yes}"

  if [[ "${GNUCONFIG_AUTO_DEPEND}" != "no" ]]; then
    BDEPEND+=" ${GNUCONFIG_DEPEND}"
  fi

  # @FUNCTION: gnuconfig_update
  # @USAGE: [file1 file2 ...]
  # If called with no arguments, updates config.sub + config.guess. If the first
  # argument is an absolute path, that path is used as the search root. Otherwise,
  # it defaults to $S. Then calls gnuconfig_do_update to perform the actual copy.
  gnuconfig_update() {
    local startdir

    if [[ "$1" == /* ]]; then
      startdir="$1"
      shift
    else
      startdir="${S}"
    fi

    if [[ $# -gt 0 ]]; then
      gnuconfig_do_update "${startdir}" "$@"
    else
      gnuconfig_do_update "${startdir}" config.sub config.guess
    fi
  }

  # @FUNCTION: gnuconfig_do_update
  # @INTERNAL
  # Copies the newest version of each specified file from gnuconfig_findnewest
  # into any matching paths in the provided start directory.
  gnuconfig_do_update() {
    local base_dir="$1"
    shift
    [[ $# -eq 0 ]] && die "Internal usage error: call gnuconfig_update instead."

    local src_dir
    src_dir="$(gnuconfig_findnewest)" || die "Failed to locate a valid gnuconfig path"

    einfo "Using GNU config files from ${src_dir}"

    local file
    for file in "$@"; do
      if [[ ! -r "${src_dir}/${file}" ]]; then
        eerror "Cannot read ${src_dir}/${file}, skipping."
        continue
      fi

      local found
      found="$(find "${base_dir}" -name "${file}" 2>/dev/null)"
      if [[ -z "${found}" ]]; then
        ewarn "No copies of ${file} found under ${base_dir}, skipping."
        continue
      fi

      local target
      for target in ${found}; do
        [[ -L "${target}" ]] && rm -f "${target}"
        ebegin "Updating ${target#${base_dir}/}"
        cp -f "${src_dir}/${file}" "${target}"
        eend $? || die "Failed updating ${target}"
      done
    done
  }

  # @FUNCTION: gnuconfig_findnewest
  # Searches known system directories for config.sub with the highest timestamp.
  # Returns the path of that directory.
  gnuconfig_findnewest() {
    local possibilities=(
      "${BROOT}/usr/share/misc/config.sub"
      "${BROOT}/usr/share/gnuconfig/config.sub"
      "${BROOT}/usr/share/automake*/config.sub"
      "${BROOT}/usr/share/libtool/config.sub"
    )

    local best
    best="$(
      grep -s '^timestamp' "${possibilities[@]}" 2>/dev/null \
      | sort -r -n -t\' -k2 \
      | sed -n '1{s,/config.sub:.*$,,;p;q}'
    )"

    [[ -n "${best}" ]] || die "No valid config.sub found in standard gnuconfig directories"
    echo "${best}"
  }

fi
