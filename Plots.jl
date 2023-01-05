module Plots

    export fill_figure_with_data , setup_figure,setup_layout
    using Plots


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

function fill_figure_with_data(Domini,fig,Startegie)
    numberOfGen = length(Domini.x)
    xs = 0.:1:numberOfGen-1
    pop1,pop2,pop3,pop4 = Float64[],Float64[],Float64[],Float64[]

    for pop = 1:numberOfGen 
       push!(pop1,Domini.x[pop][1])
       push!(pop2,Domini.x[pop][2])
       push!(pop3,Domini.x[pop][3])
       push!(pop4,Domini.x[pop][4])
    end

    Strategie_1 = map((x) -> round(x, digits = 3), Domini.NStrategies[1])
    Strategie_2 = map((x) -> round(x, digits = 3), Domini.NStrategies[2])
    Strategie_3 = map((x) -> round(x, digits = 3), Domini.NStrategies[3])
    Strategie_4 = map((x) -> round(x, digits = 3), Domini.NStrategies[4])
    fig 
    plot!(xs,[pop1], label = string(Startegie[1] ," -> ", Strategie_1), lw = 3 , ls =:dash)
    plot!(xs,[pop2], label = string(Startegie[2] ," -> ", Strategie_2) , lw = 3 , ls =:dot)
    plot!(xs,[pop3], label = string(Startegie[3] ," -> ", Strategie_3) , lw = 3 , ls =:dashdot)
    plot!(xs,[pop4], label = string(Startegie[4] ," -> ", Strategie_4) , lw = 3  )
    return fig
end

function setup_figure(Title,Mutationrate)
    fig = plot( ylims = [0,1])     
    plot!(layout=[:autosize])
    plot!(legend=:topright, legendcolumns = 1, legendtitle = "Stragies")
    title!(Title *"\nMutation after $Mutationrate Generations")
    xlabel!("NGenerations")
    ylabel!("Population Trajectory")
    typeof(fig)
    fig
end

function setup_layout(Plts)
    p1,p2,p3,p4,p5 = Plts
    fig = plot(p1,p2,p3,p4,p5, layout = 5, size = [1000,1000],p4=:bottomleft,p5=:bottomright)
    fig
end

#content
end