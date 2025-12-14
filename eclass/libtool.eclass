# @ECLASS: libtool.eclass
# @MAINTAINER:
# 1g4 Project <1g4@example.org>
# @SUPPORTED_EAPIS: 7 8
# @BLURB: Applies patches to bundled libtool files
# @DESCRIPTION:
# Applies patches to bundled libtool files (e.g., ltmain.sh) using
# app-portage/elt-patches. This does not invoke libtoolize, so it
# does not regenerate autotool files.

if [[ -z ${_LIBTOOL_ECLASS} ]]; then
  _LIBTOOL_ECLASS=1

  case "${EAPI:-0}" in
    7|8) ;;
    *) die "libtool.eclass: EAPI ${EAPI:-0} not supported" ;;
  esac

  inherit toolchain-funcs

  # @ECLASS_VARIABLE: LIBTOOL_DEPEND
  # @DESCRIPTION:
  # The dependency string for the tool that provides `eltpatch`.
  : "${LIBTOOL_DEPEND:=>=app-port/elt-patches-20250305}"

  # @ECLASS_VARIABLE: LIBTOOL_AUTO_DEPEND
  # @DESCRIPTION:
  # Set to "no" to disable automatic dependency on app-port/elt-patches.
  : "${LIBTOOL_AUTO_DEPEND:=yes}"
  if [[ "${LIBTOOL_AUTO_DEPEND}" != "no" ]]; then
    BDEPEND+=" ${LIBTOOL_DEPEND}"
  fi

  # @FUNCTION: elibtoolize
  # @USAGE: [directories] [--flags]
  # @DESCRIPTION:
  # Patch any libtool files in the specified directories (or in $S by default)
  # using `eltpatch`. The optional flags (e.g. --shallow, --portage, etc.)
  # modify which patches or how deeply they’re applied.
  elibtoolize() {
    type -P eltpatch &>/dev/null \
      || die "eltpatch not found (please install app-port/elt-patches)."

    ELT_LOGDIR="${T}" \
    LD="$(tc-getLD)" \
    eltpatch "$@" || die "eltpatch failed"
  }

fi
