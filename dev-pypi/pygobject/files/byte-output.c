/* SPDX-License-Identifier: LGPL-2.1-or-later */
#include "byte-output.h"
#include <string.h>

static gint boxes_live;

static gpointer copy_box(gpointer data) {
    ByteOutputBox* copy = g_memdup2(data, sizeof(ByteOutputBox));
    copy->label = g_strdup(copy->label);
    boxes_live++;
    return copy;
}

static void free_box(gpointer data) {
    ByteOutputBox* box = data;
    boxes_live--;
    g_free(box->label);
    g_free(data);
}

GType byte_output_box_get_type(void) {
    static gsize type;
    if (g_once_init_enter(&type)) {
        GType registered = g_boxed_type_register_static("ByteOutputBox", copy_box, free_box);
        g_once_init_leave(&type, registered);
    }
    return type;
}

gint byte_output_boxes_live(void) {
    return boxes_live;
}

ByteOutputBox* byte_output_boxed_borrowed(gboolean fail, const gchar** later) {
    static ByteOutputBox box = {42, "boxed"};
    *later = fail ? "\xff" : "good";
    return &box;
}

ByteOutputBox* byte_output_boxed_owned(gboolean fail, const gchar** later) {
    return copy_box(byte_output_boxed_borrowed(fail, later));
}

void byte_output_boxed_caller(ByteOutputBox* out, gboolean fail, const gchar** later) {
    *out = *byte_output_boxed_borrowed(fail, later);
}

void byte_output_boxed_inline(ByteOutputBox* out, gboolean fail, const gchar** later) {
    for (guint i = 0; i < 3; i++)
        byte_output_boxed_caller(&out[i], fail, later);
}

ByteOutputBox** byte_output_boxed_array(gboolean fail, const gchar** later) {
    static ByteOutputBox* boxes[3];
    for (guint i = 0; i < G_N_ELEMENTS(boxes); i++)
        boxes[i] = byte_output_boxed_borrowed(fail, later);
    return boxes;
}

static gboolean check_value(gint value, GError** error) {
    if (value >= 0)
        return TRUE;
    g_set_error_literal(error, g_quark_from_static_string("byte-output"), 17, "output rejected");
    return FALSE;
}

gboolean byte_output_fixed(guint8* out, gint value, GError** error) {
    memset(out, value, 4);
    return check_value(value, error);
}

gboolean byte_output_array(GArray* out, gint value, GError** error) {
    guint8 bytes[4];
    memset(bytes, value, sizeof(bytes));
    g_array_append_vals(out, bytes, G_N_ELEMENTS(bytes));
    return check_value(value, error);
}

gboolean byte_output_byte_array(GByteArray* out, gint value, GError** error) {
    guint8 bytes[4];
    memset(bytes, value, sizeof(bytes));
    g_byte_array_append(out, bytes, G_N_ELEMENTS(bytes));
    return check_value(value, error);
}

const guint8* byte_output_borrowed(void) {
    static const guint8 bytes[] = {1, 2, 3, 4};
    return bytes;
}

gboolean byte_output_integers(gint* out, gint value, GError** error) {
    for (guint i = 0; i < 4; i++)
        out[i] = value;
    return check_value(value, error);
}

gboolean byte_output_characters(gunichar* out, gint value, GError** error) {
    out[0] = 'A';
    out[1] = (gunichar)value;
    out[2] = 'Z';
    return check_value(value, error);
}

gboolean byte_output_character_array(GArray* out, gint value, GError** error) {
    gunichar characters[] = {'A', (gunichar)value, 'Z'};
    g_array_append_vals(out, characters, G_N_ELEMENTS(characters));
    return check_value(value, error);
}

const gunichar* byte_output_borrowed_characters(gboolean invalid) {
    static const gunichar valid[] = {'A', 0x100, 'Z'};
    static const gunichar invalid_middle[] = {'A', 0x110000, 'Z'};
    return invalid ? invalid_middle : valid;
}

const gunichar* byte_output_borrowed_later(gunichar* invalid) {
    *invalid = 0x110000;
    return byte_output_borrowed_characters(FALSE);
}

gunichar byte_output_skipped(ByteOutputRecord* record,
                             gunichar* character,
                             guint8* bytes,
                             GArray* array,
                             GValue* value,
                             gint mode,
                             GError** error) {
    record->value = 42;
    *character = mode == 1 ? 0x110000 : 'B';
    memset(bytes, 3, 4);
    byte_output_character_array(array, 0x100, NULL);
    g_value_init(value, G_TYPE_STRING);
    g_value_set_string(value, "owned value");
    if (!check_value(mode, error))
        return 0;
    return mode == 2 ? 0x110000 : 'A';
}

void byte_output_single_record(ByteOutputRecord* record) {
    record->value = 42;
}

static const gchar* middle_string(gint mode) {
    return mode == 1 ? "\xff" : mode == 2 ? NULL : "middle";
}

gboolean byte_output_strings(const gchar** out, gint mode, GError** error) {
    out[0] = "first";
    out[1] = middle_string(mode);
    out[2] = "last";
    return check_value(mode, error);
}

gboolean byte_output_filenames(const gchar** out, gint mode, GError** error) {
    return byte_output_strings(out, mode, error);
}

static guint string_frees;

static void destroy_string(gpointer data) {
    string_frees++;
    g_free(data);
}

static void clear_string_slot(gpointer data) {
    destroy_string(*(gchar**)data);
}

gboolean byte_output_string_array(GArray* out, gint mode, GError** error) {
    gchar* strings[] = {g_strdup("first"), g_strdup(middle_string(mode)), g_strdup("last")};
    g_array_set_clear_func(out, clear_string_slot);
    g_array_append_vals(out, strings, G_N_ELEMENTS(strings));
    return check_value(mode, error);
}

gboolean byte_output_string_ptrarray(GPtrArray* out, gint mode, GError** error) {
    g_ptr_array_set_free_func(out, destroy_string);
    g_ptr_array_add(out, g_strdup("first"));
    g_ptr_array_add(out, g_strdup(middle_string(mode)));
    g_ptr_array_add(out, g_strdup("last"));
    return check_value(mode, error);
}

guint byte_output_string_frees(void) {
    return string_frees;
}

const gchar* const* byte_output_borrowed_strings(gint mode, const gchar** later) {
    static const gchar* const valid[] = {"first", "middle", "last"};
    static const gchar* const invalid[] = {"first", "\xff", "last"};
    *later = mode == 2 ? "\xff" : "good";
    return mode == 1 ? invalid : valid;
}

const gchar** byte_output_container_strings(gint mode, const gchar** later) {
    const gchar* const* strings = byte_output_borrowed_strings(mode, later);
    return mode == 3 ? NULL : g_memdup2(strings, 3 * sizeof(*strings));
}

static void count_string_destroy(gpointer data) {
    (void)data;
    string_frees++;
}

GArray* byte_output_container_string_array(gint mode, const gchar** later) {
    const gchar* const* strings = byte_output_borrowed_strings(mode, later);
    GArray* array = g_array_new(FALSE, FALSE, sizeof(*strings));
    g_array_set_clear_func(array, count_string_destroy);
    if (mode != 3)
        g_array_append_vals(array, strings, 3);
    return array;
}

GPtrArray* byte_output_container_string_ptrarray(gint mode, const gchar** later) {
    const gchar* const* strings = byte_output_borrowed_strings(mode, later);
    GPtrArray* array = g_ptr_array_new_with_free_func(count_string_destroy);
    if (mode != 3)
        for (guint i = 0; i < 3; i++)
            g_ptr_array_add(array, (gpointer)strings[i]);
    return array;
}

gchar** byte_output_full_strings(gint mode, const gchar** later) {
    const gchar* const* strings = byte_output_borrowed_strings(mode, later);
    if (mode == 3)
        return NULL;
    gchar** result = g_new(gchar*, 3);
    for (guint i = 0; i < 3; i++) {
        const gchar* value = strings[i];
        if (mode == 4 && i == 1)
            value = NULL;
        else if ((mode == 5 && i == 0) || (mode == 6 && i == 2))
            value = "\xff";
        result[i] = g_strdup(value);
    }
    return result;
}

gchar** byte_output_full_filenames(gint mode, const gchar** later) {
    return byte_output_full_strings(mode, later);
}

GArray* byte_output_full_string_array(gint mode, gboolean clear, const gchar** later) {
    gchar** strings = byte_output_full_strings(mode, later);
    GArray* array = g_array_new(FALSE, FALSE, sizeof(*strings));
    if (clear)
        g_array_set_clear_func(array, clear_string_slot);
    if (strings)
        g_array_append_vals(array, strings, 3);
    g_free(strings);
    return array;
}

GPtrArray* byte_output_full_string_ptrarray(gint mode, gboolean clear, const gchar** later) {
    gchar** strings = byte_output_full_strings(mode, later);
    GPtrArray* array = g_ptr_array_new_with_free_func(clear ? destroy_string : NULL);
    if (strings)
        for (guint i = 0; i < 3; i++)
            g_ptr_array_add(array, strings[i]);
    g_free(strings);
    return array;
}

gboolean byte_output_records(ByteOutputRecord* out, gint mode, const gchar** later, GError** error) {
    for (guint i = 0; i < 3; i++)
        out[i].value = (mode == 2 ? 20 : 0) + (gint)i;
    *later = mode == 1 ? "\xff" : "good";
    return check_value(mode, error);
}

const ByteOutputRecord* byte_output_borrowed_records(gint value) {
    static ByteOutputRecord records[3];
    for (guint i = 0; i < 3; i++)
        records[i].value = value;
    return records;
}

const ByteOutputRecord* byte_output_borrowed_record_later(gboolean fail, const gchar** later) {
    *later = fail ? "\xff" : "good";
    return byte_output_borrowed_records(42);
}

static GArray* borrowed_record_array;
static GPtrArray* borrowed_record_ptrarray;
static guint record_clears;

static void count_record_clear(gpointer data) {
    (void)data;
    record_clears++;
}

GArray* byte_output_borrowed_record_array(gboolean fail, const gchar** later) {
    const ByteOutputRecord* records = byte_output_borrowed_record_later(fail, later);
    if (!borrowed_record_array) {
        borrowed_record_array = g_array_new(FALSE, FALSE, sizeof(*records));
        g_array_set_clear_func(borrowed_record_array, count_record_clear);
        g_array_append_vals(borrowed_record_array, records, 3);
    }
    return borrowed_record_array;
}

GPtrArray* byte_output_borrowed_record_ptrarray(gboolean fail, const gchar** later) {
    const ByteOutputRecord* records = byte_output_borrowed_record_later(fail, later);
    if (!borrowed_record_ptrarray) {
        borrowed_record_ptrarray = g_ptr_array_new_with_free_func(count_record_clear);
        for (guint i = 0; i < 3; i++)
            g_ptr_array_add(borrowed_record_ptrarray, (gpointer)&records[i]);
    }
    return borrowed_record_ptrarray;
}

guint byte_output_record_clears(void) {
    return record_clears;
}

void byte_output_release_borrowed_record_arrays(void) {
    g_clear_pointer(&borrowed_record_array, g_array_unref);
    g_clear_pointer(&borrowed_record_ptrarray, g_ptr_array_unref);
}
