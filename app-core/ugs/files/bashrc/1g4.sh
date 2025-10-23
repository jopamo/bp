#!/usr/bin/env bash

# aliases
alias eupdate='emerge --sync && eup'
alias rebuild_packages='eup && rebuild_world'
alias 1g4_nspawn='systemd-nspawn --bind /var/cache/distfiles --bind-ro /var/db/repos/bp'
alias oneshot='emerge --oneshot'
alias update_world='emerge --keep-going -uDNv world'
alias update_everything='emerge --keep-going -euDNv world'

# simple foreground step runner without spinner
run_step() {
  local msg="$1"; shift
  [[ "$1" == "--" ]] && shift
  log_info "$msg ${ICON_LOADING}"
  if "$@"; then
    log_ok "$msg"
    return 0
  else
    local rc=$?
    log_error "$msg failed rc=$rc"
    return "$rc"
  fi
}

move_package() {
  # help
  if [[ $# -lt 2 || "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<'EOF'
Usage: move_package <package-name> <new-category>

Moves a Gentoo package directory inside /var/db/repos/bp to a new category
and updates all internal repository references

Example:
  move_package nettle lib-core
EOF
    return 1
  fi

  local REPO_PATH="/var/db/repos/bp"
  local package_name="$1"
  local new_category="$2"

  # find package
  local found_path
  found_path=$(find "$REPO_PATH" -type d -name "$package_name" ! -path "*/.git/*" -print -quit)

  if [[ -z "$found_path" ]]; then
    log_error "package '$package_name' not found"
    return 1
  fi

  local old_path new_path
  old_path=$(dirname "$found_path" | sed "s|$REPO_PATH/||")
  new_path="$new_category"

  log_task "moving '$package_name' from '$old_path' to '$new_path'"

  mkdir -p "$REPO_PATH/$new_path"

  if mv "$found_path" "$REPO_PATH/$new_path/$package_name"; then
    log_ok "moved '$package_name' to '$new_path'"

    # escape paths for sed
    local old_pattern_escaped new_pattern_escaped
    old_pattern_escaped=$(printf '%s\n' "$old_path/$package_name" | sed 's:[][\/.^$*]:\\&:g')
    new_pattern_escaped=$(printf '%s\n' "$new_path/$package_name" | sed 's:[][\/.^$*]:\\&:g')

    # update references
    while IFS= read -r -d '' file; do
      sed -i "s|$old_pattern_escaped|$new_pattern_escaped|g" "$file"
    done < <(find "$REPO_PATH" -type f ! -path "*/.git/*" -print0)

    log_success "updated references $old_path/$package_name -> $new_path/$package_name"
  else
    log_error "failed to move '$package_name'"
    return 1
  fi
}

bootstrap_go() {
  trap 'log_warn "interrupted by user"; return 1' SIGINT
  log_task "bootstrapping Go toolchain"
  run_step "installing gcc[go-bootstrap]" -- bash -lc 'USE=go-bootstrap emerge --oneshot gcc' || return 1
  run_step "installing Go 1.21 bootstrap" -- bash -lc 'FEATURES="-sandbox -usersandbox" emerge --oneshot =app-lang/go-1.21*' || return 1
  run_step "installing Go 1.23" -- emerge --oneshot =app-lang/go-1.23* || return 1
  run_step "installing Go 1.24" -- emerge --oneshot =app-lang/go-1.24* || return 1
  run_step "updating to latest Go" -- emerge --oneshot app-lang/go || return 1
  log_success "go bootstrap complete"
  trap - SIGINT
}

eup() {
  trap 'log_warn "interrupted by user"; return 1' SIGINT

  run_step "syncing overlays" -- esync || return 1
  run_step "world update pass 1" -- emerge --keep-going -uDNv world || return 1
  run_step "env-update" -- bash -lc 'env-update && source /etc/profile' || return 1
  run_step "depclean" -- emerge --depclean || return 1
  run_step "preserved rebuild" -- emerge @preserved-rebuild || return 1
  run_step "world update pass 2" -- emerge --keep-going -uDNv world || return 1
  run_step "oneshot libtool" -- emerge --oneshot libtool || return 1
  run_step "env-update" -- bash -lc 'env-update && source /etc/profile' || return 1

  log_success "system updated"
  trap - SIGINT
}

esync() {
  trap 'log_warn "interrupted by user"; return 1' SIGINT

  log_task "regenerating bp repo cache"
  for dir in /var/db/repos/*/; do
    dir=${dir%*/}
    if [[ -d "$dir" ]]; then
      log_info "updating cache for repo ${dir##*/}"
      pushd "$dir" >/dev/null
      egencache --jobs=8 --update --repo "${dir##*/}"
      popd >/dev/null
    else
      log_warn "skipping non-directory $dir"
    fi
  done

  run_step "emerge --regen" -- emerge --regen || return 1
  run_step "emerge --metadata" -- emerge --metadata || return 1
  run_step "eix-update" -- eix-update || return 1

  log_ok "cache regeneration complete"
  trap - SIGINT
}

rebuild_world() {
  log_task "rebuilding world"
  rm -rf /var/cache/packages/*
  emerge --keep-going -ueDNv world
}

update_kernel_auto() {
  local rc
  (
    # fail-fast inside subshell
    set -Eeuo pipefail
    shopt -s inherit_errexit 2>/dev/null || true
    trap 'rc=$?; log_error "ERR $BASH_SOURCE:$LINENO: $BASH_COMMAND (rc=$rc)"; exit $rc' ERR
    trap 'log_warn "interrupted by user (SIGINT)"; exit 130' INT

    detect_nvidia() {
      local atom="bin/nvidia-drivers"
      if command -v portageq &>/dev/null; then
        portageq has_version / "${atom}" &>/dev/null && return 0
        [[ -n $(portageq match / "${atom}" 2>/dev/null) ]] && return 0
      fi
      command -v equery &>/dev/null && equery -q list -i "${atom}" &>/dev/null && return 0
      command -v qlist  &>/dev/null && qlist  -IC "${atom}"        &>/dev/null && return 0
      compgen -G "/var/db/pkg/bin/nvidia-drivers-*" &>/dev/null && return 0
      return 1
    }

    [[ $EUID -eq 0 ]] || { log_error "must be run as root"; exit 1; }
    [[ -d /usr/src/linux ]] || { log_error "/usr/src/linux not found"; exit 1; }
    cd /usr/src/linux

    log_task "preparing kernel tree"
    make oldconfig
    make prepare

    if ! mountpoint -q /boot; then
      log_info "mounting /boot"
      mount /boot
    fi

    local EFI_MODE=0 INITRAMFS_MODE=0 NVIDIA_IN_INITRAMFS=0
    if mountpoint -q /boot/efi || [[ -d /sys/firmware/efi ]]; then
      EFI_MODE=1
      mount | grep -q '/sys/firmware/efi/efivars' || \
        mount -t efivarfs efivarfs /sys/firmware/efi/efivars 2>/dev/null || true
      if ! mountpoint -q /boot/efi; then
        log_info "mounting /boot/efi"
        mount /boot/efi
      fi
      command -v dracut &>/dev/null && INITRAMFS_MODE=1
    fi

    log_task "building kernel"
    make -j"$(nproc)"
    local KERNEL_VERSION
    KERNEL_VERSION="$(make -s kernelrelease)"
    [[ -n "${KERNEL_VERSION}" ]] || { log_error "could not determine kernel release"; exit 1; }

    [[ -f arch/x86/boot/bzImage || -f vmlinux ]] || {
      log_error "build failed, no kernel image"
      exit 1
    }

    log_info "cleaning old targets"
    [[ -d "/lib/modules/${KERNEL_VERSION}" ]] && rm -rf "/lib/modules/${KERNEL_VERSION}"
    rm -f /boot/System.map-* /boot/config-* /boot/vmlinuz-* /boot/initramfs-*

    make modules_install
    make install

    if detect_nvidia; then
      log_task "rebuilding nvidia-drivers"
      emerge --quiet-build --oneshot bin/nvidia-drivers
      NVIDIA_IN_INITRAMFS=1
    fi

    if (( EFI_MODE && INITRAMFS_MODE )); then
      log_task "generating initramfs with dracut"
      local DRACUT_OPTS=(
        -f "/boot/initramfs-${KERNEL_VERSION}.img"
        "${KERNEL_VERSION}"
        --kernel-image "/boot/vmlinuz-${KERNEL_VERSION}"
        --hostonly --early-microcode --mdadmconf --lvmconf
        --strip --zstd --logfile /var/log/dracut.log --stdlog 3
      )
      (( NVIDIA_IN_INITRAMFS )) && DRACUT_OPTS+=( --add-drivers "nvidia nvidia_modeset nvidia_drm nvidia_uvm" )
      dracut "${DRACUT_OPTS[@]}"
    fi

    log_task "updating bootloader"
    if (( EFI_MODE )); then
      mkdir -p /boot/grub
      grub-mkconfig -o /boot/grub/grub.cfg
      grub-install --efi-directory=/boot/efi
      grub-install --efi-directory=/boot/efi --removable
    else
      grub-mkconfig -o /boot/grub/grub.cfg
      local BOOT_DISK
      BOOT_DISK="$(lsblk -dno NAME,TYPE | awk '$2=="disk"{print "/dev/"$1; exit}')"
      [[ -n "${BOOT_DISK:-}" ]] || { log_error "could not determine boot disk for BIOS grub-install"; exit 1; }
      grub-install --target=i386-pc "${BOOT_DISK}"
    fi

    log_success "kernel update complete"
  )
  rc=$?
  (( rc != 0 )) && log_error "update_kernel_auto aborted rc=$rc"
  return "$rc"
}

update_kernel_opi5plus() {
  trap 'log_warn "interrupted by user"; return 1' SIGINT
  (
    set -e
    cd /usr/src/linux
    log_task "preparing kernel tree"
    make oldconfig
    mount /boot
    make prepare

    log_task "building Image, dtbs, modules"
    make -j"$(nproc)" Image
    make -j"$(nproc)" dtbs
    make -j"$(nproc)" modules

    log_info "cleaning old boot artifacts"
    rm -rf /lib/modules/*
    rm -f /boot/{System.map,config,vmlinux,vmlinuz,initrd,uInitrd}*
    rm -rf /boot/dtb*
    mkdir -p /boot/dtb/rockchip
    cp arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb /boot/dtb/rockchip/

    make -j"$(nproc)" Image.gz
    cp /usr/src/linux/arch/arm64/boot/Image.gz /boot/
    make modules_install

    log_success "kernel update complete"
  ) || return 1
  trap - SIGINT
}

bootstrap_rust() {
  log_task "starting Rust version emerge process"
  trap 'log_warn "emerge process interrupted"; exit 1' SIGINT

  # caller should provide rust_info, otherwise try to gather a simple view
  local rust_info=${rust_info:-}
  if [[ -z "$rust_info" ]]; then
    if command -v eix >/dev/null 2>&1; then
      rust_info="$(eix -I app-lang/rust 2>/dev/null || true)"
    else
      rust_info="$(emerge -s '^rust$' 2>/dev/null || true)"
    fi
  fi

  local available_versions installed_version start_emerging=false emerge_status
  available_versions=$(echo "$rust_info" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | sort -V | uniq)
  installed_version=$(echo "$rust_info" | grep -Po '(?<=Installed versions:)\s*\d+\.\d+\.\d+' | head -n 1 | xargs)

  if [[ -z "$installed_version" ]]; then
    log_info "no installed version of Rust detected"
    start_emerging=true
  else
    log_info "installed Rust version detected $installed_version"
  fi
  log_info "processing available versions"

  local version
  for version in $available_versions; do
    log_info "checking $version"
    if [[ "$version" == "$installed_version" ]]; then
      log_info "installed match $version, starting emerge from next version"
      start_emerging=true
    elif $start_emerging; then
      log_task "emerging Rust $version"
      emerge -v "=app-lang/rust-${version}"
      emerge_status=$?
      if (( emerge_status != 0 )); then
        log_error "emerge failed for $version, stopping"
        exit 1
      fi
    else
      log_info "skipping $version"
    fi
  done

  log_success "Rust emerge process complete"
  trap - SIGINT
}

check_bin_sbin_commands() {
  local name
  for cmd in /bin/*; do
    name="$(basename "$cmd")"
    [[ -x "/sbin/${name}" ]] && log_warn "$name exists in both /bin and /sbin"
  done
}
