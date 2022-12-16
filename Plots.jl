module Plots

    export do_heatmap,do_surface,do_lines
using CairoMakie
#using GLMakie

function do_heatmap(d)
    xs = ys = range(0.,length(d.nStrategies)-1,length=length(d.nStrategies))
    populationsize = deepcopy(d.A)
    fig,ax,hm = heatmap(xs,ys,d.x[1])
    Colorbar(fig[:,end+1], hm)
    display(fig)
    sleep(1)
end

function do_surface(d)
    xs = ys = range(0.,length(d.nStrategies)-1,length=length(d.nStrategies))
    populationsize = deepcopy(d.x)
    #println(d.x)
    fig,ax,hm = surface(xs,ys,d.x[1])
    Colorbar(fig[:,end+1], hm)

    display(fig)
    sleep(1)
end


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

    fig =   lines(xs,pop1)
            lines!(xs,pop2)
            lines!(xs,pop3)
            lines!(xs,pop4)
    
    display(fig)

    sleep(1e-3)
end
end