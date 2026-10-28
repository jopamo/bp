# SPDX-License-Identifier: LGPL-2.1-or-later
"""Run with debug, allocation-visible Python and leak detection enabled."""

import os
import sys

import gi

gi.require_version("ByteOutput", "1.0")
from gi.repository import ByteOutput, GLib


def check_error(method, value, exception):
    try:
        method(value)
    except exception as error:
        if isinstance(error, GLib.Error):
            assert (error.domain, error.code, error.message) == (
                "byte-output",
                17,
                "output rejected",
            )
        elif isinstance(error, UnicodeDecodeError):
            assert error.encoding == "utf-8" and error.object == b"\xff"
            assert (error.start, error.end) == (0, 1)
        elif value == 0x110000:
            assert "Invalid unicode codepoint 1114112" in str(error)
    else:
        raise AssertionError(f"{method.__name__} accepted {value!r}")


def check(name):
    method = getattr(ByteOutput, name)
    outputs = []
    for value in range(16):
        ok, output = method(value)
        assert ok is True
        outputs.append(output)
        for invalid, exception in ((-1, GLib.Error), ("bad", TypeError)):
            check_error(method, invalid, exception)
        assert ByteOutput.borrowed() == bytes((1, 2, 3, 4))
    assert outputs == [bytes((value,)) * 4 for value in range(16)]
    print(f"{name}: repeated success, C error, input error and retained copies pass")


def check_scalars(name):
    method = getattr(ByteOutput, name)
    outputs = []
    expected = []
    for value in range(0x100, 0x110):
        ok, output = method(value)
        assert ok is True
        outputs.append(output)
        expected.append([value] * 4 if name == "integers" else ["A", chr(value), "Z"])
        invalid_inputs = [(-1, GLib.Error), ("bad", TypeError)]
        if name != "integers":
            invalid_inputs.append((0x110000, TypeError))
        for invalid, exception in invalid_inputs:
            check_error(method, invalid, exception)
        try:
            ByteOutput.borrowed_characters(True)
        except TypeError as error:
            assert "Invalid unicode codepoint 1114112" in str(error)
        else:
            raise AssertionError("borrowed_characters accepted an invalid codepoint")
        assert ByteOutput.borrowed_characters(False) == ["A", "\u0100", "Z"]
    assert outputs == expected
    print(f"{name}: retained scalars and error cleanup pass")


def check_later_failure():
    for _ in range(16):
        try:
            ByteOutput.borrowed_later()
        except TypeError as error:
            assert "Invalid unicode codepoint 1114112" in str(error)
        else:
            raise AssertionError("borrowed_later accepted an invalid codepoint")
        assert ByteOutput.borrowed_characters(False) == ["A", "\u0100", "Z"]
    print("borrowed_later: borrowed return storage survives later output failure")


def check_skipped():
    results = []
    single_records = []
    for _ in range(16):
        results.append(ByteOutput.skipped(0))
        single_records.append(ByteOutput.single_record())
        for mode in (1, 2):
            try:
                ByteOutput.skipped(mode)
            except TypeError as error:
                assert "Invalid unicode codepoint 1114112" in str(error)
            else:
                raise AssertionError(f"skipped accepted mode {mode}")
        check_error(ByteOutput.skipped, -1, GLib.Error)
        check_error(ByteOutput.skipped, "bad", TypeError)
    for result in results:
        returned, record, character, data, array, value = result
        assert returned == "A" and character == "B"
        assert record.value == 42
        assert data == b"\x03" * 4
        assert array == ["A", "\u0100", "Z"]
        assert value == "owned value"
    assert all(record.value == 42 for record in single_records)
    print("skipped: earlier failures release untouched outputs, not converted records")


def check_strings(name):
    method = getattr(ByteOutput, name)
    has_destructor = name in ("string_array", "string_ptrarray")
    copies = []
    expected = []
    for _ in range(8):
        for mode in (0, 2, 1, -1, "bad"):
            before = ByteOutput.string_frees()
            if mode == "bad":
                check_error(method, mode, TypeError)
            elif mode == -1:
                check_error(method, mode, GLib.Error)
            elif mode == 1 and name != "filenames":
                check_error(method, mode, UnicodeDecodeError)
            else:
                ok, result = method(mode)
                assert ok is True
                copies.append(result)
                middle = "middle"
                if mode == 1:
                    middle = os.fsdecode(b"\xff")
                elif mode == 2:
                    middle = None
                expected.append(["first", middle, "last"])
            count = 3 if has_destructor and mode != "bad" else 0
            assert ByteOutput.string_frees() - before == count, name
    assert copies == expected
    print(f"{name}: copied strings, conversion failures and container cleanup pass")


def check_borrowed_strings():
    for _ in range(8):
        assert ByteOutput.borrowed_strings(0) == (["first", "middle", "last"], "good")
        check_error(ByteOutput.borrowed_strings, 1, UnicodeDecodeError)
        check_error(ByteOutput.borrowed_strings, 2, UnicodeDecodeError)
    print("borrowed_strings: partial and later failures preserve borrowed storage")


def check_container_strings(name):
    method = getattr(ByteOutput, name)
    copies = []
    before = ByteOutput.string_frees()
    for _ in range(8):
        check_error(method, 1, UnicodeDecodeError)
        check_error(method, 2, UnicodeDecodeError)
        result, later = method(0)
        assert later == "good"
        copies.append(result)
        assert method(3) == ([], "good")
        assert ByteOutput.string_frees() == before, name
    assert copies == [["first", "middle", "last"]] * 8
    print(f"{name}: container released without destroying borrowed elements")


def check_full_strings(name, method):
    copies = []
    expected = []
    for _ in range(8):
        for mode in (0, 1, 2, 3, 4, 5, 6, "bad"):
            if mode == "bad":
                check_error(method, mode, TypeError)
            elif mode == 2 or (name != "full_filenames" and mode in (1, 5, 6)):
                check_error(method, mode, UnicodeDecodeError)
            else:
                result, later = method(mode)
                assert later == "good"
                copies.append(result)
                value = ["first", "middle", "last"]
                if mode == 3:
                    value = []
                elif mode == 4:
                    value[1] = None
                elif mode in (1, 5, 6):
                    index = {1: 1, 5: 0, 6: 2}[mode]
                    value[index] = os.fsdecode(b"\xff")
                expected.append(value)
    assert copies == expected
    print(f"{name}: converted and unconverted elements released, copies retained")


def check_records():
    copies = []
    expected = []
    for _ in range(8):
        for mode in (0, 2):
            ok, records, later = ByteOutput.records(mode)
            assert ok is True and later == "good"
            assert all(type(record) is ByteOutput.Record for record in records)
            records[1].value += 1
            copies.append(records)
            expected.append([mode * 10, mode * 10 + 2, mode * 10 + 2])
        check_error(ByteOutput.records, 1, UnicodeDecodeError)
        check_error(ByteOutput.records, -1, GLib.Error)
        check_error(ByteOutput.records, "bad", TypeError)
    assert [[record.value for record in records] for records in copies] == expected
    borrowed = ByteOutput.borrowed_records(0)
    assert [record.value for record in borrowed] == [0, 0, 0]
    ByteOutput.borrowed_records(20)
    assert [record.value for record in borrowed] == [20, 20, 20]
    print("records: retained inline records and later-output cleanup pass")


def check_borrowed_record_failure(name):
    method = getattr(ByteOutput, name)
    before = ByteOutput.record_clears()
    copies = []
    for _ in range(8):
        records, later = method(False)
        assert later == "good"
        copies.append(records)
        check_error(method, True, UnicodeDecodeError)
        assert ByteOutput.record_clears() == before, name
    assert [[record.value for record in records] for records in copies] == [[42] * 3] * 8
    ByteOutput.release_borrowed_record_arrays()
    count = 0 if name == "borrowed_record_later" else 3
    assert ByteOutput.record_clears() - before == count, name
    print(f"{name}: later failure leaves container destruction to its owner")


def retain_boxes(name):
    method = getattr(ByteOutput, name)
    copies = []
    count = 3 if name in ("boxed_array", "boxed_inline") else 1
    for iteration in range(8):
        output, later = method(False)
        assert later == "good"
        boxes = output if isinstance(output, list) else [output]
        assert all(type(box) is ByteOutput.Box and box.value == 42 for box in boxes)
        assert [box.label for box in boxes] == ["boxed"] * count
        boxes[0].value = iteration
        copies.append(boxes)
        assert ByteOutput.boxes_live() == count * len(copies)
        check_error(method, True, UnicodeDecodeError)
        assert ByteOutput.boxes_live() == count * len(copies)
    assert [boxes[0].value for boxes in copies] == list(range(8))
    assert all(box.label == "boxed" for boxes in copies for box in boxes)


def check_boxes(name):
    assert ByteOutput.boxes_live() == 0
    retain_boxes(name)
    assert ByteOutput.boxes_live() == 0
    print(f"{name}: retained copies and output cleanup lifetimes pass")


for name in sys.argv[1:] or (
    "fixed",
    "array",
    "byte_array",
    "integers",
    "characters",
    "character_array",
    "borrowed_later",
    "skipped",
    "strings",
    "filenames",
    "string_array",
    "string_ptrarray",
    "borrowed_strings",
    "container_strings",
    "container_string_array",
    "container_string_ptrarray",
    "full_strings",
    "full_filenames",
    "full_string_array",
    "full_string_array_clear",
    "full_string_ptrarray",
    "full_string_ptrarray_clear",
    "records",
    "borrowed_record_later",
    "borrowed_record_array",
    "borrowed_record_ptrarray",
    "boxed_borrowed",
    "boxed_owned",
    "boxed_caller",
    "boxed_array",
    "boxed_inline",
):
    if name in ("fixed", "array", "byte_array"):
        check(name)
    elif name == "borrowed_later":
        check_later_failure()
    elif name == "skipped":
        check_skipped()
    elif name in ("strings", "filenames", "string_array", "string_ptrarray"):
        check_strings(name)
    elif name == "borrowed_strings":
        check_borrowed_strings()
    elif name.startswith("container_"):
        check_container_strings(name)
    elif name in ("full_strings", "full_filenames"):
        check_full_strings(name, getattr(ByteOutput, name))
    elif name.startswith("full_string_"):
        method = getattr(ByteOutput, name.removesuffix("_clear"))
        before = ByteOutput.string_frees()
        check_full_strings(name, lambda mode: method(mode, name.endswith("_clear")))
        assert ByteOutput.string_frees() == before, name
    elif name == "records":
        check_records()
    elif name.startswith("borrowed_record_"):
        check_borrowed_record_failure(name)
    elif name.startswith("boxed_"):
        check_boxes(name)
    else:
        check_scalars(name)
