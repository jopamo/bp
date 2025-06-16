#include "config.h"
#include "Imlib2_Loader.h"

#include <gif_lib.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

#define DBG_PFX "LDR-gif"

#ifndef PIXEL_ARGB
#define PIXEL_ARGB(a, r, g, b) \
  (((uint32_t)(a) << 24) | ((uint32_t)(r) << 16) | ((uint32_t)(g) << 8) | (uint32_t)(b))
#endif

#ifndef D
#define D(fmt, ...)
#endif
#ifndef DL
#define DL(fmt, ...)
#endif
#ifndef E
#define E(fmt, ...)
#endif

static const char *const _formats[] = { "gif" };

static struct {
   const unsigned char *data;
   const unsigned char *dptr;
   unsigned int         size;
} mdata;

static void
mm_init(const void *src, unsigned int size)
{
   mdata.data = mdata.dptr = src;
   mdata.size = size;
}

static int
mm_read(GifFileType *gif, GifByteType *dst, int length)
{
   (void) gif;
   if (length <= 0 ||
       mdata.dptr < mdata.data ||
       mdata.dptr + length > mdata.data + mdata.size)
      return -1;
   memcpy(dst, mdata.dptr, length);
   mdata.dptr += length;
   return length;
}

static int
_load(ImlibImage *im, int load_data)
{
   GifFileType      *gif   = NULL;
   int               err    = 0;
   int               rc     = LOAD_FAIL;
   int               fcount = 0;
   int               frame  = 1;
   ImlibImageFrame  *pf    = NULL;
   SavedImage       *si    = NULL;
   int               w, h;
   int               i, j;
   int               transp = -1;
   uint32_t         *ptr   = NULL;
   ColorMapObject   *cmap  = NULL;
   uint32_t          palette[256];
   bool              multiframe = false;

   mm_init(im->fi->fdata, im->fi->fsize);

#if GIFLIB_MAJOR >= 5
   gif = DGifOpen(NULL, mm_read, &err);
#else
   gif = DGifOpen(NULL, mm_read);
#endif
   if (!gif)
   {
      E("DGifOpen failed (err=%d)\n", err);
      goto quit;
   }

   if (DGifSlurp(gif) != GIF_OK)
   {
      E("DGifSlurp failed\n");
      rc = LOAD_BADIMAGE;
      goto quit;
   }

   rc = LOAD_BADIMAGE;

   fcount = gif->ImageCount;
   D("Total frames in GIF: %d\n", fcount);

   if (im->frame > 0)
      frame = im->frame;
   else
      frame = 1;

   pf = __imlib_GetFrame(im);
   if (!pf)
   {
      rc = LOAD_OOM;
      goto quit;
   }
   pf->frame_count = fcount;
   pf->loop_count  = 0;
   if (fcount > 1)
      pf->frame_flags |= FF_IMAGE_ANIMATED;
   pf->canvas_w = gif->SWidth;
   pf->canvas_h = gif->SHeight;

   D("Canvas WxH=%dx%d, requested frame=%d\n", pf->canvas_w, pf->canvas_h, frame);

   if (frame > fcount)
   {
      E("Requested frame %d beyond total frames %d\n", frame, fcount);
      rc = LOAD_BADFRAME;
      goto quit;
   }

   si = &gif->SavedImages[frame - 1];
   w  = si->ImageDesc.Width;
   h  = si->ImageDesc.Height;

   im->w = w;
   im->h = h;

   pf->frame_x = si->ImageDesc.Left;
   pf->frame_y = si->ImageDesc.Top;
   D("Frame %d => x=%d, y=%d, w=%d, h=%d\n", frame, pf->frame_x, pf->frame_y, w, h);

   if (!IMAGE_DIMENSIONS_OK(w, h))
   {
      E("Bad dimensions %dx%d\n", w, h);
      rc = LOAD_FAIL;
      goto quit;
   }

   if (si->ImageDesc.ColorMap)
      cmap = si->ImageDesc.ColorMap;
   else
      cmap = gif->SColorMap;

   if (si->ExtensionBlockCount > 0)
   {
      for (i = 0; i < si->ExtensionBlockCount; i++)
      {
         ExtensionBlock *eb = &si->ExtensionBlocks[i];
         if (eb->Function == GRAPHICS_EXT_FUNC_CODE)
         {
            GraphicsControlBlock gcb;
            if (DGifExtensionToGCB(eb->ByteCount, eb->Bytes, &gcb) == GIF_OK)
            {
               transp = gcb.TransparentColor;
               D("Found transparency index: %d\n", transp);

               pf->frame_delay = gcb.DelayTime * 10;
               if (gcb.DisposalMode == DISPOSE_BACKGROUND || gcb.DisposalMode == DISPOSE_PREVIOUS)
                  pf->frame_flags |= FF_FRAME_DISPOSE_CLEAR;
               pf->frame_flags |= FF_FRAME_BLEND;
            }
         }
      }
   }

   multiframe = (fcount > 1);

   if (!load_data)
   {
      rc = LOAD_SUCCESS;
      goto quit;
   }

   memset(palette, 0, sizeof(palette));
   if (cmap)
   {
      int colors = (cmap->ColorCount > 256) ? 256 : cmap->ColorCount;
      for (i = 0; i < colors; i++)
      {
         int R = cmap->Colors[i].Red;
         int G = cmap->Colors[i].Green;
         int B = cmap->Colors[i].Blue;
         palette[i] = PIXEL_ARGB(0xFF, R, G, B);
      }
   }

   if (transp >= 0 && transp < 256)
   {
      palette[transp] &= 0x00FFFFFF;
      im->has_alpha = 1;
   }
   else
   {
      im->has_alpha = 0;
   }

   ptr = __imlib_AllocateData(im);
   if (!ptr)
   {
      rc = LOAD_OOM;
      goto quit;
   }

   {
      GifByteType *src = si->RasterBits;
      for (i = 0; i < h; i++)
      {
         for (j = 0; j < w; j++)
         {
            *ptr++ = palette[*src++];
         }

         if (!multiframe && im->lc && __imlib_LoadProgressRows(im, i, 1))
         {
            rc = LOAD_BREAK;
            goto quit;
         }
      }
      if (multiframe && im->lc)
         __imlib_LoadProgress(im, 0, 0, w, h);
   }

   rc = LOAD_SUCCESS;

quit:

   if (gif)
   {
#if GIFLIB_MAJOR > 5 || (GIFLIB_MAJOR == 5 && GIFLIB_MINOR >= 1)
      DGifCloseFile(gif, NULL);
#else
      DGifCloseFile(gif);
#endif
   }

   return rc;
}

IMLIB_LOADER(_formats, _load, NULL);
