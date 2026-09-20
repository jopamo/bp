#!/usr/bin/env bash

test_description='Linux fork failure handling'
cd "$(dirname "$0")"
. ./setup.sh

test_expect_success 'Prepare a disposable store and fault-injecting GPG wrapper' '
	"$PASS" init "$KEY1" &&
	printf "original password\noriginal notes\n" | "$PASS" insert -m secret &&
	cp "$PASSWORD_STORE_DIR/secret.gpg" original.gpg &&
	export PASS_TEST_REAL_GPG="$(command -v "$GPG")" &&
	mkdir mock-bin &&
	cat > mock-bin/gpg <<-\EOF &&
	#!/usr/bin/env bash
	for arg in "$@"; do
		if [[ $PASS_TEST_FAILURE == decrypt && $arg == -d ]]; then
			printf "partial plaintext\n"
			exit 1
		fi
		if [[ $PASS_TEST_FAILURE == encrypt && $arg == -e ]]; then
			exit 1
		fi
	done
	exec "$PASS_TEST_REAL_GPG" "$@"
	EOF
	chmod +x mock-bin/gpg &&
	ln -s gpg mock-bin/gpg2
'

test_expect_success 'Failed insertion encryption preserves existing ciphertext' '
	cp original.gpg "$PASSWORD_STORE_DIR/secret.gpg" &&
	test_must_fail env PATH="$PWD/mock-bin:$PATH" PASS_TEST_FAILURE=encrypt \
		"$PASS" insert -ef secret <<< replacement &&
	test_cmp original.gpg "$PASSWORD_STORE_DIR/secret.gpg"
'

test_expect_success 'Failed decryption during re-encryption preserves existing ciphertext' '
	cp original.gpg "$PASSWORD_STORE_DIR/secret.gpg" &&
	printf "%s\n" "$KEY1" > "$PASSWORD_STORE_DIR/.gpg-id" &&
	test_must_fail env PATH="$PWD/mock-bin:$PATH" PASS_TEST_FAILURE=decrypt \
		"$PASS" init "$KEY2" &&
	test_cmp original.gpg "$PASSWORD_STORE_DIR/secret.gpg"
'

test_expect_success 'Failed in-place generation preserves existing ciphertext' '
	cp original.gpg "$PASSWORD_STORE_DIR/secret.gpg" &&
	printf "%s\n" "$KEY1" > "$PASSWORD_STORE_DIR/.gpg-id" &&
	test_must_fail env PATH="$PWD/mock-bin:$PATH" PASS_TEST_FAILURE=decrypt \
		"$PASS" generate -i secret &&
	test_cmp original.gpg "$PASSWORD_STORE_DIR/secret.gpg"
'

test_expect_success 'A failing editor cannot replace a password' '
	cp original.gpg "$PASSWORD_STORE_DIR/secret.gpg" &&
	printf "%s\n" "$KEY1" > "$PASSWORD_STORE_DIR/.gpg-id" &&
	cat > failing-editor <<-\EOF &&
	#!/usr/bin/env bash
	printf replacement > "$1"
	exit 1
	EOF
	chmod +x failing-editor &&
	test_must_fail env EDITOR=./failing-editor "$PASS" edit secret &&
	test_cmp original.gpg "$PASSWORD_STORE_DIR/secret.gpg"
'

test_expect_success 'Noninteractive edit encryption failure does not retry forever' '
	cp original.gpg "$PASSWORD_STORE_DIR/secret.gpg" &&
	printf "%s\n" "$KEY1" > "$PASSWORD_STORE_DIR/.gpg-id" &&
	cat > successful-editor <<-\EOF &&
	#!/usr/bin/env bash
	printf replacement > "$1"
	EOF
	chmod +x successful-editor &&
	result=0 &&
	{ timeout 5 env EDITOR=./successful-editor PATH="$PWD/mock-bin:$PATH" \
		PASS_TEST_FAILURE=encrypt "$PASS" edit secret </dev/null || result=$?; } &&
	test "$result" = 1 &&
	test_cmp original.gpg "$PASSWORD_STORE_DIR/secret.gpg"
'

test_expect_success 'QR encoding preserves a password that looks like an echo option' '
	printf "%s\n" "-n" | "$PASS" insert -e qr-secret &&
	cat > mock-bin/qrencode <<-\EOF &&
	#!/usr/bin/env bash
	cat > qr-input
	EOF
	chmod +x mock-bin/qrencode &&
	env PATH="$PWD/mock-bin:$PATH" DISPLAY= WAYLAND_DISPLAY= "$PASS" show -q qr-secret &&
	printf "%s" "-n" > expected-qr-input &&
	test_cmp expected-qr-input qr-input
'

test_expect_success 'Basic password operations work without Git' '
	cat > mock-bin/git <<-\EOF &&
	#!/usr/bin/env bash
	exit 127
	EOF
	chmod +x mock-bin/git &&
	env PATH="$PWD/mock-bin:$PATH" PASSWORD_STORE_DIR="$PWD/store-without-git" \
		"$PASS" init "$KEY1" &&
	env PATH="$PWD/mock-bin:$PATH" PASSWORD_STORE_DIR="$PWD/store-without-git" \
		"$PASS" insert -e secret <<< without-git &&
	test "$(env PATH="$PWD/mock-bin:$PATH" PASSWORD_STORE_DIR="$PWD/store-without-git" \
		"$PASS" show secret)" = without-git
'

test_expect_success 'Temporary directory failure leaves the password unchanged' '
	cp original.gpg "$PASSWORD_STORE_DIR/secret.gpg" &&
	export PASS_TEST_REAL_MKTEMP="$(command -v mktemp)" &&
	cat > mock-bin/mktemp <<-\EOF &&
	#!/usr/bin/env bash
	[[ $1 != -d ]] || exit 1
	exec "$PASS_TEST_REAL_MKTEMP" "$@"
	EOF
	chmod +x mock-bin/mktemp &&
	test_must_fail env PATH="$PWD/mock-bin:$PATH" EDITOR=./successful-editor \
		"$PASS" edit secret &&
	test_cmp original.gpg "$PASSWORD_STORE_DIR/secret.gpg"
'

test_expect_success 'Init refuses to write a recipient file through a symlink' '
	printf "%s\n" "$KEY1" > outside-recipients &&
	cp outside-recipients expected-recipients &&
	rm "$PASSWORD_STORE_DIR/.gpg-id" &&
	ln -s "$PWD/outside-recipients" "$PASSWORD_STORE_DIR/.gpg-id" &&
	test_must_fail "$PASS" init "$KEY2" &&
	test_cmp expected-recipients outside-recipients
'

test_expect_success 'Init rejects a symlinked signature before changing recipients' '
	rm "$PASSWORD_STORE_DIR/.gpg-id" &&
	printf "%s\n" "$KEY1" > "$PASSWORD_STORE_DIR/.gpg-id" &&
	ln -s "$PWD/outside-recipients" "$PASSWORD_STORE_DIR/.gpg-id.sig" &&
	test_must_fail env PASSWORD_STORE_SIGNING_KEY="$KEY1" "$PASS" init "$KEY2" &&
	test_cmp expected-recipients "$PASSWORD_STORE_DIR/.gpg-id" &&
	test_cmp expected-recipients outside-recipients
'

test_expect_success 'Absolute and parent traversal paths are rejected' '
	test_must_fail "$PASS" show /etc/passwd &&
	test_must_fail "$PASS" show ../outside-recipients
'

test_expect_success 'No failed encryption leaves a candidate file in the store' '
	test -z "$(find "$PASSWORD_STORE_DIR" -name ".*.tmp.*" -print)"
'

test_done
