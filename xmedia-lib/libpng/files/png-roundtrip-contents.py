"""Compare the contents of the two known-good pngtest round-trip fixtures."""

import struct
import sys
import zlib
from pathlib import Path


def inflate(data):
    stream = zlib.decompressobj()
    decoded = stream.decompress(data, 1024 * 1024)
    if not stream.eof or stream.unused_data or stream.unconsumed_tail:
        raise ValueError("invalid compressed stream or oversized fixture")
    return decoded


def contents(data):
    if not data.startswith(b"\x89PNG\r\n\x1a\n"):
        raise ValueError("invalid PNG signature")
    offset = 8
    chunks, image = [], bytearray()
    before_image, after_image = True, False
    while offset + 12 <= len(data):
        size, name = struct.unpack_from(">I4s", data, offset)
        end = offset + 8 + size
        if end + 4 > len(data):
            raise ValueError("truncated chunk")
        payload = data[offset + 8 : end]
        (crc,) = struct.unpack_from(">I", data, end)
        if zlib.crc32(payload, zlib.crc32(name)) != crc:
            raise ValueError(f"invalid CRC for {name!r}")
        offset = end + 4
        if name == b"IDAT":
            if after_image:
                raise ValueError("non-consecutive IDAT chunks")
            if before_image:
                chunks.append((name, None))
                before_image = False
            image.extend(payload)
            continue
        after_image = not before_image
        if name == b"zTXt":
            keyword, method, compressed = payload.partition(b"\0\0")
            if not keyword or b"\0" in keyword or not method:
                raise ValueError("invalid zTXt header")
            payload = (keyword, inflate(compressed))
        chunks.append((name, payload))
        if name == b"IEND":
            if size or offset != len(data) or before_image:
                raise ValueError("invalid PNG ending")
            return chunks, inflate(image)
    raise ValueError("missing IEND")


if __name__ == "__main__":
    original, roundtrip = map(Path, sys.argv[1:])
    try:
        same = contents(original.read_bytes()) == contents(roundtrip.read_bytes())
    except (OSError, ValueError, zlib.error) as error:
        sys.exit(f"PNG round trip: {error}")
    if not same:
        sys.exit(f"PNG round trip changed image data or metadata: {original}")
