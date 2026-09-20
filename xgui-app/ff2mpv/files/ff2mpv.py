#!/usr/bin/env python3

# Copyright (c) 2020 William Woodruff <william @ yossarian.net>
# Modified for bp. See /usr/share/licenses/ff2mpv/LICENSE.

import json
import struct
import sys
import subprocess

MPV = "/usr/bin/mpv"
MAX_MESSAGE_SIZE = 1024 * 1024
EOF = object()


def main():
    try:
        message = get_message()
        if message is EOF:
            return 0
        url, options = validate_message(message)

        # mpv must neither retain the browser's pipes nor share the process
        # group that Firefox can kill when it closes the native host.
        subprocess.Popen(
            [MPV, "--no-terminal", *options, "--", url],
            stdin=subprocess.DEVNULL,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True,
        )
        send_message("ok")
    except (OSError, ValueError) as error:
        print(f"ff2mpv: {error}", file=sys.stderr)
        return 1
    return 0


# https://developer.mozilla.org/en-US/Add-ons/WebExtensions/Native_messaging#App_side
def get_message():
    raw_length = sys.stdin.buffer.read(4)
    if not raw_length:
        return EOF
    if len(raw_length) != 4:
        raise ValueError("truncated message header")
    length = struct.unpack("@I", raw_length)[0]
    if not 0 < length <= MAX_MESSAGE_SIZE:
        raise ValueError("invalid message length")
    message = sys.stdin.buffer.read(length)
    if len(message) != length:
        raise ValueError("truncated message body")
    return json.loads(message.decode("utf-8"))


def validate_message(message):
    if not isinstance(message, dict):
        raise ValueError("message must be an object")
    url = message.get("url")
    if not isinstance(url, str) or not url or "\0" in url:
        raise ValueError("url must be a nonempty string without NUL bytes")
    options = message.get("options")
    if options is None:
        options = []
    if not isinstance(options, list) or any(
        not isinstance(option, str) or "\0" in option for option in options
    ):
        raise ValueError("options must be a list of strings without NUL bytes")
    return url, options


def send_message(message):
    # https://stackoverflow.com/a/56563264
    # https://docs.python.org/3/library/json.html#basic-usage
    # To get the most compact JSON representation, you should specify
    # (',', ':') to eliminate whitespace.
    content = json.dumps(message, separators=(",", ":")).encode("utf-8")
    length = struct.pack("@I", len(content))
    sys.stdout.buffer.write(length)
    sys.stdout.buffer.write(content)
    sys.stdout.buffer.flush()


if __name__ == "__main__":
    sys.exit(main())
