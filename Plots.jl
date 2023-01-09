module Plots

    export fill_figure_with_data, setup_figure, setup_layout, setup_axes_to_plot_into, fill_layout_with_data
    using GLMakie


function fill_figure_with_data(Domini,fig,ax,Startegie,NumberOfPlot=1)
    # x values
    numberOfGen = length(Domini.x)
    xs = collect(0.:1:numberOfGen-1)
    # define container for Pop
    pop1,pop2,pop3,pop4 = Float64[],Float64[],Float64[],Float64[]
    #sepeate the timeseries of Population
    for pop = 1:numberOfGen 
       push!(pop1,Domini.x[pop][1])
       push!(pop2,Domini.x[pop][2])
       push!(pop3,Domini.x[pop][3])
       push!(pop4,Domini.x[pop][4])
    end
    #round the Values of the envoled Stragies
    Strategie_1 = map((x) -> round(x, digits = 3), Domini.NStrategies[1])
    Strategie_2 = map((x) -> round(x, digits = 3), Domini.NStrategies[2])
    Strategie_3 = map((x) -> round(x, digits = 3), Domini.NStrategies[3])
    Strategie_4 = map((x) -> round(x, digits = 3), Domini.NStrategies[4])
    fig
    lines!(xs,pop1, label = string(Startegie[1] ," -> ", Strategie_1), lw = 3 ,linestyle=:dash )
    lines!(xs,pop2, label = string(Startegie[2] ," -> ", Strategie_2) , lw = 3 , linestyle =:dot)
    lines!(xs,pop3, label = string(Startegie[3] ," -> ", Strategie_3) , lw = 3 , linestyle =:dashdot)
    lines!(xs,pop4, label = string(Startegie[4] ," -> ", Strategie_4) , lw = 3  )
    fig[1, 2] = Legend(fig, ax, " Strategies", framevisible = false)
    save("./Outputs/Plot"*string(NumberOfPlot)*".png",fig)
    
    return fig
end


function setup_figure(Title::String, Mutationrate::Int, xlims)
    fig = Figure()
    ax = Axis(fig[1, 1], xlabel = "NGenerations", ylabel = "Population Trajectory",
        title = Title *"\nMutation after $Mutationrate Generations",limits = (0, xlims, 0, 1))
    fig,ax
end

function setup_layout(ALLSimulatedDominis,title,xlims)
    #new fig    
    fig = Figure(resolution = (1920,1040 )) # resolution ?
    #separte fig in pieces
    positions=[]
    NumberOfPltsInLayout = length(ALLSimulatedDominis)
    for i = 1 : NumberOfPltsInLayout + 1 # +1 for Legend
        push!(positions , fig[1,i])
    end
    axes = Plots.setup_axes(ALLSimulatedDominis,title,xlims,positions)
    resolution = (800, 600)
    fig
end

function setup_axes(ALLSimulatedDominis,title,xlims,positions)
    axes = []
    i=1
    for Domini in ALLSimulatedDominis
        ax = Axis(positions[i]  ,xlabel = "NGenerations", ylabel = "Population Trajectory",
            title = title *"\nMutation after $(Domini.Mutationrate) Generations",limits = (0, xlims, 0, 1))
        push!(axes,ax)
        i+=1        
    end
    axes
end

function fill_layout_with_data(ALLSimulatedDominis,fig,StartStrategies,Title)
    i=1
    for Domini in ALLSimulatedDominis
        numberOfGen = length(Domini.x)
        xs = collect(0.:1:numberOfGen-1)
        # define container for Pop
        pop1,pop2,pop3,pop4 = Float64[],Float64[],Float64[],Float64[]
        #sepeate the timeseries of Population
        for pop = 1:numberOfGen 
           push!(pop1,Domini.x[pop][1])
           push!(pop2,Domini.x[pop][2])
           push!(pop3,Domini.x[pop][3])
           push!(pop4,Domini.x[pop][4])
        end
        #round the Values of the envoled Stragies
        Strategie_1 = map((x) -> round(x, digits = 3), Domini.NStrategies[1])
        Strategie_2 = map((x) -> round(x, digits = 3), Domini.NStrategies[2])
        Strategie_3 = map((x) -> round(x, digits = 3), Domini.NStrategies[3])
        Strategie_4 = map((x) -> round(x, digits = 3), Domini.NStrategies[4])
       
        lines!(fig.content[i],pop1, label = string(StartStrategies[1] ," -> ", Strategie_1), lw = 3 ,linestyle=:dash )
        lines!(fig.content[i],pop2, label = string(StartStrategies[2] ," -> ", Strategie_2) , lw = 3 , linestyle =:dot)
        lines!(fig.content[i],pop3, label = string(StartStrategies[3] ," -> ", Strategie_3) , lw = 3 , linestyle =:dashdot)
        lines!(fig.content[i],pop4, label = string(StartStrategies[4] ," -> ", Strategie_4) , lw = 3  ) 
        i += 1
    end 
    
    save("./Outputs/layout_"*Title*".png", fig)
    fig
end
#content
end