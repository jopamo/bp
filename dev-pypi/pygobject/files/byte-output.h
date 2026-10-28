/* SPDX-License-Identifier: LGPL-2.1-or-later */
#include <glib-object.h>

typedef struct {
    gint value;
} ByteOutputRecord;

typedef struct {
    gint value;
    gchar* label;
} ByteOutputBox;

GType byte_output_box_get_type(void);
gint byte_output_boxes_live(void);

/**
 * byte_output_boxed_borrowed:
 * @fail: whether to fail conversion of the later output
 * @later: (out) (transfer none): string converted after the box
 *
 * Returns: (transfer none): borrowed box
 */
ByteOutputBox* byte_output_boxed_borrowed(gboolean fail, const gchar** later);

/**
 * byte_output_boxed_owned:
 * @fail: whether to fail conversion of the later output
 * @later: (out) (transfer none): string converted after the box
 *
 * Returns: (transfer full): owned box
 */
ByteOutputBox* byte_output_boxed_owned(gboolean fail, const gchar** later);

/**
 * byte_output_boxed_caller:
 * @out: (out caller-allocates): box filled by the callee
 * @fail: whether to fail conversion of the later output
 * @later: (out) (transfer none): string converted after the box
 */
void byte_output_boxed_caller(ByteOutputBox* out, gboolean fail, const gchar** later);

/**
 * byte_output_boxed_inline:
 * @out: (out caller-allocates) (array fixed-size=3): inline boxes filled by the callee
 * @fail: whether to fail conversion of the later output
 * @later: (out) (transfer none): string converted after the boxes
 */
void byte_output_boxed_inline(ByteOutputBox* out, gboolean fail, const gchar** later);

/**
 * byte_output_boxed_array:
 * @fail: whether to fail conversion of the later output
 * @later: (out) (transfer none): string converted after the boxes
 *
 * Returns: (transfer none) (array fixed-size=3): borrowed box pointers
 */
ByteOutputBox** byte_output_boxed_array(gboolean fail, const gchar** later);

/**
 * byte_output_fixed:
 * @out: (out caller-allocates) (array fixed-size=4): copied bytes
 * @value: byte value, or a negative value to raise an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_fixed(guint8* out, gint value, GError** error);

/**
 * byte_output_array:
 * @out: (out caller-allocates) (element-type guint8): copied bytes
 * @value: byte value, or a negative value to raise an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_array(GArray* out, gint value, GError** error);

/**
 * byte_output_byte_array:
 * @out: (out caller-allocates): copied bytes
 * @value: byte value, or a negative value to raise an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_byte_array(GByteArray* out, gint value, GError** error);

/**
 * byte_output_borrowed:
 *
 * Returns: (transfer none) (array fixed-size=4): static bytes
 */
const guint8* byte_output_borrowed(void);

/**
 * byte_output_integers:
 * @out: (out caller-allocates) (array fixed-size=4): copied integers
 * @value: element value, or a negative value to raise an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_integers(gint* out, gint value, GError** error);

/**
 * byte_output_characters:
 * @out: (out caller-allocates) (array fixed-size=3): copied characters
 * @value: middle codepoint, or a negative value to raise an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_characters(gunichar* out, gint value, GError** error);

/**
 * byte_output_character_array:
 * @out: (out caller-allocates) (element-type gunichar): copied characters
 * @value: middle codepoint, or a negative value to raise an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_character_array(GArray* out, gint value, GError** error);

/**
 * byte_output_borrowed_characters:
 * @invalid: whether the middle codepoint is invalid
 *
 * Returns: (transfer none) (array fixed-size=3): static characters
 */
const gunichar* byte_output_borrowed_characters(gboolean invalid);

/**
 * byte_output_borrowed_later:
 * @invalid: (out): invalid codepoint converted after the return value
 *
 * Returns: (transfer none) (array fixed-size=3): static characters
 */
const gunichar* byte_output_borrowed_later(gunichar* invalid);

/**
 * byte_output_skipped:
 * @record: (out caller-allocates): independently owned record
 * @character: (out): codepoint converted after the record
 * @bytes: (out caller-allocates) (array fixed-size=4): copied bytes
 * @array: (out caller-allocates) (element-type gunichar): copied characters
 * @value: (out caller-allocates): initialized value
 * @mode: 1 fails character conversion, 2 fails return conversion, -1 raises an error
 * @error: return location for an error
 *
 * Returns: a codepoint converted before the outputs
 */
gunichar byte_output_skipped(ByteOutputRecord* record,
                             gunichar* character,
                             guint8* bytes,
                             GArray* array,
                             GValue* value,
                             gint mode,
                             GError** error);

/**
 * byte_output_single_record:
 * @record: (out caller-allocates): independently owned record
 */
void byte_output_single_record(ByteOutputRecord* record);

/**
 * byte_output_strings:
 * @out: (out caller-allocates) (array fixed-size=3): copied strings
 * @mode: 1 supplies invalid UTF-8, 2 supplies a null element, -1 raises an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_strings(const gchar** out, gint mode, GError** error);

/**
 * byte_output_filenames:
 * @out: (out caller-allocates) (array fixed-size=3) (element-type filename): copied filenames
 * @mode: 1 supplies non-UTF-8 bytes, 2 supplies a null element, -1 raises an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_filenames(const gchar** out, gint mode, GError** error);

/**
 * byte_output_string_array:
 * @out: (out caller-allocates) (element-type utf8): copied strings
 * @mode: 1 supplies invalid UTF-8, 2 supplies a null element, -1 raises an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_string_array(GArray* out, gint mode, GError** error);

/**
 * byte_output_string_ptrarray:
 * @out: (out caller-allocates) (element-type utf8): copied strings
 * @mode: 1 supplies invalid UTF-8, 2 supplies a null element, -1 raises an error
 * @error: return location for an error
 *
 * Returns: whether the output was filled
 */
gboolean byte_output_string_ptrarray(GPtrArray* out, gint mode, GError** error);

/**
 * byte_output_string_frees:
 *
 * Returns: the number of string-container element destructor calls
 */
guint byte_output_string_frees(void);

/**
 * byte_output_borrowed_strings:
 * @mode: 1 fails return conversion, 2 fails later output conversion
 * @later: (out) (transfer none): string converted after the return value
 *
 * Returns: (transfer none) (array fixed-size=3): static strings
 */
const gchar* const* byte_output_borrowed_strings(gint mode, const gchar** later);

/**
 * byte_output_container_strings:
 * @mode: 1 fails return conversion, 2 fails later conversion, 3 returns null
 * @later: (out) (transfer none): string converted after the return value
 *
 * Returns: (transfer container) (array fixed-size=3) (nullable): borrowed strings in an owned container
 */
const gchar** byte_output_container_strings(gint mode, const gchar** later);

/**
 * byte_output_container_string_array:
 * @mode: 1 fails return conversion, 2 fails later conversion, 3 returns empty
 * @later: (out) (transfer none): string converted after the return value
 *
 * Returns: (transfer container) (element-type utf8): borrowed strings in an owned container
 */
GArray* byte_output_container_string_array(gint mode, const gchar** later);

/**
 * byte_output_container_string_ptrarray:
 * @mode: 1 fails return conversion, 2 fails later conversion, 3 returns empty
 * @later: (out) (transfer none): string converted after the return value
 *
 * Returns: (transfer container) (element-type utf8): borrowed strings in an owned container
 */
GPtrArray* byte_output_container_string_ptrarray(gint mode, const gchar** later);

/**
 * byte_output_full_strings:
 * @mode: 1 supplies invalid middle UTF-8, 2 fails later conversion, 3 returns null,
 *   4 supplies a null element, 5/6 supply invalid first/last UTF-8
 * @later: (out) (transfer none): string converted after the return value
 *
 * Returns: (transfer full) (array fixed-size=3) (nullable): owned strings and container
 */
gchar** byte_output_full_strings(gint mode, const gchar** later);

/**
 * byte_output_full_filenames:
 * @mode: as for byte_output_full_strings(), using filename decoding
 * @later: (out) (transfer none): string converted after the return value
 *
 * Returns: (transfer full) (array fixed-size=3) (element-type filename) (nullable): owned filenames and container
 */
gchar** byte_output_full_filenames(gint mode, const gchar** later);

/**
 * byte_output_full_string_array:
 * @mode: as for byte_output_full_strings(), with an empty array instead of null
 * @clear: whether the container has a string destructor
 * @later: (out) (transfer none): string converted after the return value
 *
 * Returns: (transfer full) (element-type utf8): owned strings and container
 */
GArray* byte_output_full_string_array(gint mode, gboolean clear, const gchar** later);

/**
 * byte_output_full_string_ptrarray:
 * @mode: as for byte_output_full_strings(), with an empty array instead of null
 * @clear: whether the container has a string destructor
 * @later: (out) (transfer none): string converted after the return value
 *
 * Returns: (transfer full) (element-type utf8): owned strings and container
 */
GPtrArray* byte_output_full_string_ptrarray(gint mode, gboolean clear, const gchar** later);

/**
 * byte_output_records:
 * @out: (out caller-allocates) (array fixed-size=3): inline records
 * @mode: 1 fails later conversion, negative values raise an error
 * @later: (out) (transfer none): string converted after the records
 * @error: return location for an error
 *
 * Returns: whether the records were filled
 */
gboolean byte_output_records(ByteOutputRecord* out, gint mode, const gchar** later, GError** error);

/**
 * byte_output_borrowed_records:
 * @value: value written to each static record
 *
 * Returns: (transfer none) (array fixed-size=3): borrowed inline records
 */
const ByteOutputRecord* byte_output_borrowed_records(gint value);

/**
 * byte_output_borrowed_record_later:
 * @fail: whether later output conversion fails
 * @later: (out) (transfer none): string converted after the records
 *
 * Returns: (transfer none) (array fixed-size=3): static records
 */
const ByteOutputRecord* byte_output_borrowed_record_later(gboolean fail, const gchar** later);

/**
 * byte_output_borrowed_record_array:
 * @fail: whether later output conversion fails
 * @later: (out) (transfer none): string converted after the records
 *
 * Returns: (transfer none) (element-type ByteOutput.Record): provider-owned inline records
 */
GArray* byte_output_borrowed_record_array(gboolean fail, const gchar** later);

/**
 * byte_output_borrowed_record_ptrarray:
 * @fail: whether later output conversion fails
 * @later: (out) (transfer none): string converted after the records
 *
 * Returns: (transfer none) (element-type ByteOutput.Record): provider-owned record pointers
 */
GPtrArray* byte_output_borrowed_record_ptrarray(gboolean fail, const gchar** later);

/**
 * byte_output_record_clears:
 *
 * Returns: the number of provider-owned record array element destructor calls
 */
guint byte_output_record_clears(void);

/**
 * byte_output_release_borrowed_record_arrays:
 *
 * Release the provider's array references after borrowed views are no longer used.
 */
void byte_output_release_borrowed_record_arrays(void);
