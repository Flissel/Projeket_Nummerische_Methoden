
"""
module Plots 
    for setup Figures,Layouts
"""
module Plots

using GLMakie
 
    #exported methods
    export fill_figure_with_data, setup_figure, setup_layout, setup_axes_to_plot_into, fill_layout_with_data
    #-----------------------------------------------------------------------------------------
	# Module methods:
	#-----------------------------------------------------------------------------------------
    """
    function setup_figure(Title::String, Mutationrate::Int, xlims)
    """
    function setup_figure(Title::String, Mutationrate::Int, xlims)
        fig = Figure()
        ax = Axis(fig[1, 1], xlabel = "Time Steps", ylabel = "Population Trajectory",
            title = Title ,subtitle ="One mutation after $Mutationrate Time Steps",limits = (0, xlims, 0, 1))
        fig,ax
    end
    #-----------------------------------------------------------------------------------------
    """
    function fill_figure_with_data(Domini,fig,ax,Startegie)
    """
    function fill_figure_with_data(Domini,fig,ax,Startegie)
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
        lines!(xs,pop1, label = string(Startegie[1] ," -> ", Strategie_1), lw = 10 ,linestyle=:dash )
        lines!(xs,pop2, label = string(Startegie[2] ," -> ", Strategie_2) , lw = 10 , linestyle =:dot)
        lines!(xs,pop3, label = string(Startegie[3] ," -> ", Strategie_3) , lw = 10 , linestyle =:dashdot)
        lines!(xs,pop4, label = string(Startegie[4] ," -> ", Strategie_4) , lw = 10  )
        fig[1, 2] = Legend(fig, ax, " Strategies", framevisible = true)
        save("./Outputs/"*fig.content[1].title.val*string(Domini.Mutationrate)*".png",fig)
        return fig
    end
    #-----------------------------------------------------------------------------------------
    """
    function setup_layout(ALLSimulatedDominis,title,xlims)
    """
    function setup_layout(ALLSimulatedDominis,title,xlims)
        #new fig    
        fig = Figure(resolution = (1920,1080)) # resolution ?
        #separte fig in pieces
        positions=[]
        NumberOfPltsInLayout = length(ALLSimulatedDominis)
        a = 0
        b = 2
        for i = 0 : (NumberOfPltsInLayout - 1)
            push!(positions , fig[1:3,a+i:b+i])
            a += 2
            b += 2
        end
        axes = Plots.setup_axes(ALLSimulatedDominis,title,xlims,positions)
        fig
    end
    #-----------------------------------------------------------------------------------------
    """
    function setup_axes(ALLSimulatedDominis,title,xlims,positions)
    """
    function setup_axes(ALLSimulatedDominis,title,xlims,positions)
        axes = []
        i=1
        for Domini in ALLSimulatedDominis
            ax = Axis(positions[i]  ,xlabel = "Time Steps", ylabel = "Population Trajectory",
                      title = title ,subtitle ="One mutation after $(Domini.Mutationrate) Time Steps",
                      limits = (0, xlims, 0, 1))
            push!(axes,ax)
            i+=1        
        end
        axes
    end
    #-----------------------------------------------------------------------------------------
    """
    function fill_layout_with_data(ALLSimulatedDominis,fig,StartStrategies,Title)
    """
    function fill_layout_with_data(ALLSimulatedDominis,fig,StartStrategies,Title)
        i=1
        posVal=0
        for Domini in ALLSimulatedDominis
            numberOfGen = length(Domini.x)
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
            #add to fig
            lines!(fig.content[i],pop1, label = string(StartStrategies[1] ," -> ", Strategie_1), lw = 10 ,linestyle=:dash )
            lines!(fig.content[i],pop2, label = string(StartStrategies[2] ," -> ", Strategie_2) , lw = 10 , linestyle =:dot)
            lines!(fig.content[i],pop3, label = string(StartStrategies[3] ," -> ", Strategie_3) , lw = 10 , linestyle =:dashdot)
            lines!(fig.content[i],pop4, label = string(StartStrategies[4] ," -> ", Strategie_4) , lw = 10  ) 
            #add Legend
            fig[4, posVal] = Legend(fig,fig.content[i], "Envoled strategies", framevisible = true)
            posVal +=3
            i += 1
        end 
        save("./Outputs/layout_"*Title*".png", fig)
        fig
    end
    #-----------------------------------------------------------------------------------------
end #of Plots