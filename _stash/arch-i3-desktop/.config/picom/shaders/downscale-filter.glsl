#version 330
/**
 * Goal: Fullscreen subpixel antialiasing filter.
 *
 * Motivation:
 * - Natural, less pixelated look.
 *   See https://entropymine.com/imageworsener/subpixel (note: there's image, useful to calibrate subpixel shift parameter).
 * - It's written while celebrating the expiration of patents, covering subpixel graphics layout.
 *
 * Principle:
 * - XRandr sets 3x scaled virtual display resolutions 3x higher than physical (for popular rgb layouts, supported by freetype).
 * - Picom shader performs all the downscale filtering (interpolation, channels shift, sharpening) against content with multiplied resolution.
 *   - Sharpening amount is kept just enough to get same crispness as for freetype-rendered text.
 * - After it's done, necessary pixels are simply picked by Xrandr with nearest neighbor downscale method.
 *
 * Downsides:
 * Very power hungry, so good graphics card is required for relatively smooth experience (good if not gaming grade).
 * Besides 9x more Mpix, there's also some ~2x overhead (could be more), yet there's possible frequency throtling on overheat.
 *
 * Setup:
 * - Other subpixel rendering methods (e.g. font subpixel rendering) don't combine with this.
 * - Mouse pointer bypasses picom, so you may need prefiltered mouse theme.
 * - WARNING: This shader is meaned to be applied to screen instead of windows.
 *   When used per-window, this may need more job than one screen; using 'wx_3fold' makes empty content for windows, not aligned to 3x3 pixel block center.
 *
 * Example ~/.xprofile:
 * ############################
 *		export GDK_SCALE=3
 *		export GDK_DPI_SCALE=0.33333
 *		export ELM_SCALE=3
 *		export QT_AUTO_SCREEN_SCALE_FACTOR=0
 *		export QT_SCREEN_SCALE_FACTORS=3
 *
 *      # Size needs to be configured early, before desktop loading, or it could behave incorrectly.
 *		xrandr --output LVDS1 --scale 1x1 --filter nearest 
 *		xrandr --output LVDS1 --scale 3x3 --filter nearest
 * ############################
 */

/*********** Configuration choices ************/

#define wx_3fold 0 /** Flag to skip positions to be ignored by following nearest filter, greatly reducing power waste.
                    ** Only for 3-fold window position (best use is for screen post-processing). */
#define FUNC 1  /** Filter function choice.
                 ** 0 - 3x3 averaging: no stages (default, intended for first run test),
                 ** 1 - 3x3 averaging + subpixel: 0 to 2 stages. */
#define STAGE 0 /** Stage number to run (0 - single stage version). */
#define GAMMA 2.0 /** Use custom gamma correction instead of builtin square.
                   ** NOTE: Use proper gamma calibration tool to find right value, don't judge by color fringes intensity. */

#if FUNC == 1
	#define LCD_RGB     /** Subpixel order choice:       LCD_RGB,  LCD_BGR. */
	#define LCD_HORZ    /** Subpixel layout orientation: LCD_HORZ, LCD_VERT. */
	#define shift (100) /** Subpixel shift in percents from full (0..1/3 pixel width for linear RGB stripes). */
	#define RGB_CONTRAST 1.0
	/** Antiblur level. Negates extra blur after box is applied to existing 3px or wider areas.
	 ** Recomended default is 1.0. Higher values might have clear support shadows overweight. */
#endif

/*********** Implementations ***********************/

/** Development note:
 ** When 'wx_3fold' is enabled, filtering in multiple per-axis stages doesn't enhance performance for small kernels,
 ** because 1st stage can skip only 1/3 points instead of 1/9.
 **
 ** Expecting full-screen post-processing support in picom. */

vec4 default_post_processing( vec4 c);

uniform vec2 texcoord;
uniform sampler2D tex;

#if wx_3fold
	const vec4 skip_color = vec4( 0.0, 0.0, 0.0, 1.0);
#endif

#if defined GAMMA
	const vec4 pow_to_lin   = vec4( 2.2);
	const vec4 pow_from_lin = vec4( 1.0 / 2.2);
	#define to_lin( c)   c=pow( c, pow_to_lin )
	#define from_lin( c) c=pow( c, pow_from_lin )
#else
	#define to_lin( c)   c*=( c)
	#define from_lin( c) c=sqrt( c)
#endif

#if FUNC == 0
/***************************** Greyscale 3x3 box (test) *****************************/

vec4 window_shader()
{
#if wx_3fold
	if (int( texcoord.x) % 3 != 1)
		return skip_color;
	if (int( texcoord.y) % 3 != 1)
		return skip_color;
#endif
	vec4 accum = vec4( 0), tmp;
	ivec2 p = ivec2( texcoord);
	p.y--;
	int x = int( texcoord.x) - 1;
	for (int i=0; i<3; i++, p.y++)
	{
		p.x = x;
		for (int j=0; j<3; j++, p.x++)
		{
			tmp = texelFetch( tex, p, 0);
			to_lin( tmp);
			accum += tmp;
		}
	}
	accum /= 9;
	from_lin( accum);
	return accum;
}

#endif
/********** Subpixel: linear RGB stripe format ********************************/
#if FUNC == 1

#if defined LCD_HORZ
	#define sub_x x
	#define sub_y y
#elif defined LCD_VERT
	#define sub_x y
	#define sub_y x
#endif

#if defined LCD_RGB
	#define ch_1st  r
	#define ch_last b
#elif defined LCD_BGR
	#define ch_1st  b
	#define ch_last r
#endif

#if defined shift
	#if (shift == 100)
		#undef shift
	#else
		float _shift = float( shift) / 100;
	#endif
#endif

#define RGB_SOFT int( RGB_CONTRAST == 0.0 ? 9000.0 : (27.0 / RGB_CONTRAST))

#if defined shift
	#define chan_shift( a, l)              \
	for (int j=1; j <= l/2; j++) {          \
		a[ l-1-j].ch_1st  = (1.0 - _shift) * a[ l-1-j].ch_1st  + _shift * a[ l-2-j].ch_1st; \
		a[ j].ch_last     = (1.0 - _shift) * a[ j].ch_last + _shift * a[ 1+j].ch_last;      \
	}                                        \
	to_lin( a[ l/2 ]);                       \
	for (int j=l/2+1; j < l-1; j++) {        \
		a[ l-1-j].ch_1st  = (1.0 - _shift) * a[ l-1-j].ch_1st  + _shift * a[ l-2-j].ch_1st; \
		a[ j].ch_last     = (1.0 - _shift) * a[ j].ch_last + _shift * a[ 1+j].ch_last;      \
		to_lin( a[ j]), to_lin( a[ l-1-j]);  \
	}
#else
	#define chan_shift( a, l)              \
	for (int j=1; j <= l/2; j++) {          \
		a[ l-1-j].ch_1st = a[ l-2-j].ch_1st; \
		a[ j].ch_last    = a[ 1+j].ch_last;  \
	}                                        \
	to_lin( a[ l/2 ]);                       \
	for (int j=l/2+1; j < l-1; j++) {        \
		a[ l-1-j].ch_1st = a[ l-2-j].ch_1st; \
		a[ j].ch_last    = a[ 1+j].ch_last;  \
		to_lin( a[ j]), to_lin( a[ l-1-j]);  \
	}
#endif

#define prepare_subpix_line( a, l, c) \
	c.sub_x = int( texcoord.sub_x) - int( l / 2); \
	for (int j=0; j < l; j++, c.sub_x++) \
	{                                     \
		a[ j] = texelFetch( tex, c, 0); /* Reading between stripes */ \
	}                     \
	chan_shift( a, l)

#define return_foreach_sub_line( l, accum_expr, accum_div) \
{                      \
	ivec2 p;            \
	p.sub_y = int( texcoord.sub_y) - 1; \
	for (int i=0; i < 3; i++, p.sub_y++) \
	{                                    \
		vec4 c[ l];                      \
		prepare_subpix_line( c, l, p);   \
		accum_expr;                       \
	}                                      \
	accum_div;                             \
}

#if STAGE == 0
/**************** One-stage implementation (worse performance) *******************/

vec4 window_shader()
{
#if wx_3fold
	if (int( texcoord.x) % 3 != 1)
		return skip_color;
	if (int( texcoord.y) % 3 != 1)
		return skip_color;
#endif
	vec4 accum[ 3] = vec4[ 3]( vec4(0), vec4(0), vec4(0) );
	return_foreach_sub_line(
		11,
		( accum[ 0] += c[1] + c[2] + c[3],
		  accum[ 1] += c[4] + c[5] + c[6],
		  accum[ 2] += c[7] + c[8] + c[9] ),
		( accum[ 0] /= 9, from_lin( accum[ 0]),
		  accum[ 1] /= 9, from_lin( accum[ 1]),
		  accum[ 2] /= 9, from_lin( accum[ 2]) )
	);
	return (RGB_SOFT * accum[ 1] - accum[ 0] - accum[ 2]) / (RGB_SOFT - 2);
}

#elif STAGE == 1
/**************** Stage 1 *******************/

vec4 window_shader()
{
#if wx_3fold
	if (int( texcoord.x) % 3 != 1)
		return skip_color;
	if (int( texcoord.y) % 3 != 1)
		return skip_color;
#endif
	vec4 accum = vec4(0);
	return_foreach_sub_line(
		5,
		accum += c[1] + c[2] + c[3],
		accum /= 9
	);
	from_lin( accum);
	return accum;
}

#elif STAGE == 2
/**************** Stage 2 *******************/
// NOTE: No gamma correction (contrast must be in perception scale)

vec4 window_shader()
{
#if wx_3fold
	if (int( texcoord.x) % 3 != 1)
		return skip_color;
	if (int( texcoord.y) % 3 != 1)
		return skip_color;
#endif
	vec4 c[3];
	ivec2 p;
	p.sub_y = int( texcoord.sub_y);
	p.sub_x = int( texcoord.sub_x) - 3;
	c[0] = texelFetch( tex, p, 0); p.sub_x += 3
	c[1] = texelFetch( tex, p, 0); p.sub_x += 3
	c[2] = texelFetch( tex, p, 0);
	return (RGB_SOFT * c[1] - c[0] - c[2]) / (RGB_SOFT - 2);
}

#endif
#endif
