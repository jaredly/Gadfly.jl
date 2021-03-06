---
title: Themes
author: Daniel Jones
order: 2
...

Many parameters controlling the appearance of plots can be overridden by passing
a `Theme` object to the `plot` function.

The constructor for `Theme` takes zero or more named argument each of which
overrides the default theme's value.


# Parameters

  * `default_color`: When the color aesthetic is not bound, geometry uses this
    color for drawing. (ColorValue)
  * `default_point_size`: Size of points in the point and boxplot geometry.
     (Measure)
  * `line_width`: Width of lines in the line geometry. (Measure)
  * `panel_fill`: Background color used in the main plot panel. (
    ColorValue or Nothing)
  * `panel_stroke`: Border color of the main plot panel. (ColorValue or
    Nothing)
  * `grid_color`: Color of grid lines. (ColorValue or Nothing)
  * `grid_color_focused`: In the D3 backend, mousing over the plot makes the
    grid lines emphasised by transitioning to this color. (ColorValue or Nothing)
  * `grid_line_width`: Width of grid lines. (Measure)
  * `minor_label_font`: Font used for minor labels such as guide entries and
    labels. (String)
  * `minor_label_font_size`: Font size used for minor labels. (Measure)
  * `minor_label_color`: Color used for minor labels. (ColorValue)
  * `major_label_font`: Font used for major labels usch as guide titles and axis
    labels. (String)
  * `major_label_font_size`: Font size used for major labels. (Measure)
  * `major_label_color`: Color used for major labels. (ColorValue)
  * `bar_spacing`: Spacing between bars in `Geom.bar`. (Measure)
  * `boxplot_spacing`: Spacing between boxplots in `Geom.boxplot`. (Measure)
  * `errorbar_cap_length`: Length of caps on error bars. (Measure)
  * `highlight_width`: Width of lines drawn around plot geometry like points,
    and boxplot rectangles. (Measure)
  * `highlight_color`: Color used to outline plot geometry. This is a function
    that alters (e.g. darkens) the fill color of the geometry. (Function)
  * `middle_color`: Color altering function used to draw the midline in
    boxplots. (Function)
  * `middle_width`: Width of the middle line in boxplots. (Measure)


# Examples

```{.julia hide="true" results="none"}
using RDatasets
using Gadfly

Gadfly.prepare_display()
Gadfly.set_default_plot_size(12cm, 8cm)
srand(12345)
```

```julia
plot(x=rand(10), y=rand(10),
     Theme(panel_fill=color("black"), default_color=color("orange")))
```

