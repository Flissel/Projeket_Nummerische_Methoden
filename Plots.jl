module Plots

    export do_heatmap,do_surface,do_lines
using CairoMakie
#using GLMakie

"""
    do_lines(d)
        makes a graph over the timeseries of the given population 
        TODO: 
                Observerbals:
                - Make and automacally updating graph --> Obersverbals (PKG)
                - add a slider for display envoling (pop pro schritt)
                - add a slider for display envoling in respct to Mutatrate 0.0 -> 1.0 Schrittweite

                Plotsattributs:
                - add display data by mouse (if possible)
                - Title "trajectory of population in respect to Mutatrate: Mutationrate using stragie : ausgewählte stragie" 
                - Lengend so that you can see which strategies goes where (Zudordung Stragien)
                
"""
function do_lines(Domini)
    numberOfGen = length(Domini.x)
    xs = 0.:1:numberOfGen-1
    pop1,pop2,pop3,pop4 = Float64[],Float64[],Float64[],Float64[]
    
    for pop = 1:numberOfGen 
       push!(pop1,Domini.x[pop][1])
       push!(pop2,Domini.x[pop][2])
       push!(pop3,Domini.x[pop][3])
       push!(pop4,Domini.x[pop][4])
    end
    fig = Figure()
    
    fig =   lines(xs,pop1)
            lines!(xs,pop2)
            lines!(xs,pop3)
            lines!(xs,pop4)
    ylims!(0,1)        
    display(fig)
end
end