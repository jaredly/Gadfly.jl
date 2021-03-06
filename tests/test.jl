#!/usr/bin/env julia

using Gadfly
using RDatasets

tests = [
    ("points",                       6inch, 3inch),
    ("function_plots",               6inch, 3inch),
    ("function_layers",              6inch, 3inch),
    ("colored_points",               6inch, 3inch),
    ("vstack",                       6inch, 6inch),
    ("hstack",                       6inch, 3inch),
    ("colorful_hist",                6inch, 3inch),
    ("discrete_histogram",           6inch, 3inch),
    ("stacked_discrete_histogram",   6inch, 3inch),
    ("stacked_continuous_histogram", 6inch, 3inch),
    ("dodged_discrete_histogram",    6inch, 3inch),
    ("array_aesthetics",             6inch, 3inch),
    ("subplot_grid",                 6inch, 3inch),
    ("subplot_grid_histogram",       6inch, 3inch),
    ("labels",                       6inch, 6inch),
    ("percent",                      6inch, 6inch),
    ("timeseries_day",               6inch, 3inch),
    ("timeseries_month",             6inch, 3inch),
    ("timeseries_year_1",            6inch, 3inch),
    ("timeseries_year_2",            6inch, 3inch),
    ("timeseries_year_3",            6inch, 3inch),
    ("custom_themes",                6inch, 3inch),
    ("issue98",                      6inch, 3inch),
    ("issue82",                      6inch, 3inch),
    ("histogram2d",                  6inch, 3inch),
    ("rectbin",                      6inch, 3inch),
    ("density",                      6inch, 3inch),
    ("colorful_density",             6inch, 3inch),
    ("explicit_colorkey_title",      6inch, 3inch),
    ("explicit_subplot_titles",      6inch, 3inch),
    ("subplot_grid_smooth",          6inch, 8inch),
    ("histogram_errorbar",           6inch, 3inch),
    ("issue106",                     6inch, 3inch),
    ("continuous_color_scale_range", 6inch, 3inch),
    ("continuous_scale_range",       6inch, 3inch),
    ("log10_scale_range",            6inch, 3inch),
    ("histogram_explicit_bins",      6inch, 3inch),
    ("histogram2d_explicit_bins",    6inch, 3inch),
    ("explicit_number_format",       6inch, 3inch),
    ("explicit_xy_ticks",            6inch, 3inch),
    ("boxplot",                      6inch, 3inch),
    ("subplot_categorical_bar",      6inch, 3inch),
    ("errorbar",                     6inch, 3inch),
    ("issue120",                     6inch, 3inch),
    ("histogram2d_discrete",         6inch, 3inch),
    ("layer_themes",                 6inch, 3inch),
    ("discrete_color_manual",        6inch, 3inch),
    ("ordered_line",                 6inch, 3inch),
    ("nan_skipping",                 6inch, 3inch),
    ("hexbin",                       6inch, 3inch)
]


backends = {
    "svg" => (name, width, height) -> SVG("$(name).svg", width, height),
    "d3"  => (name, width, height) -> D3("$(name).js",   width, height),
    "png" => (name, width, height) -> PNG("$(name).png", width, height),
    "ps"  => (name, width, height) -> PS("$(name).ps",   width, height),
    "pdf" => (name, width, height) -> PDF("$(name).pdf", width, height)
}


function run_tests(output_filename)
    testdir = Pkg.dir("Gadfly", "tests")
    if !isempty(ARGS)
        whitelist = Set(ARGS...)
    else
        whitelist = Set([name for (name, width, height) in tests]...)
    end

    for (name, width, height) in tests
        if !in(name, whitelist)
            continue
        end

        for (backend_name, backend) in backends
            println(STDERR, "Rendering $(name) on $(backend_name) backend.")
            try
                p = evalfile(joinpath(testdir, "$(name).jl"))
                draw(backend(name, width, height), p)
            catch
                println(STDERR, "FAILED!")
                rethrow()
            end
        end
    end

    d3src = Pkg.dir("Compose", "data", "d3.v3.min.js")
    gadflysrc = Pkg.dir("Gadfly", "src", "gadfly.js")

    output = open(output_filename, "w")
    print(output,
        """
        <!DOCTYPE html>
        <html>
        <meta charset="utf-8" />
        <head>
            <title>Gadfly Test Plots</title>
        </head>
        <body>
        <script src="$(d3src)"></script>
        <script src="$(gadflysrc)"></script>
        <div style="width:900; margin:auto; text-align: center; font-family: sans-serif; font-size: 20pt;">
        """)

    for (name, width, height) in tests
        if !in(name, whitelist)
            continue
        end

        println(output, "<p>", name, "</p>")
        print(output, """<div id="$(name)"></div>""")
        print(output, """<script src="$(name).js"></script>""")
        print(output, """<script>draw("#$(name)")</script>""")
        print(output, """<img width="450px" src="$(name).svg">""")
        print(output, """<img width="450px" src="$(name).png">\n""")
    end

    print(output,
        """
        </div>
        </body>
        """)

    close(output)
end


run_tests("test.html")


