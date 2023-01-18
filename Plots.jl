
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
    
        This function creates a new figure with specified title, subtitle and axis labels.
        It takes in three parameters:
        - Title: a string, the title of the figure
        - Mutationrate: an integer, the rate of mutation in the data
        - xlims: the limit of x-axis
        It returns a tuple of figure and axis.
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
    
        This function adds data to an existing figure.
        It takes in four parameters:
        - Domini: the data to be plotted
        - fig: the figure to be plotted on
        - ax: the axis of the figure
        - Strategy: the strategy used to generate the data
        It returns the modified figure
    """
    function fill_figure_with_data(Domini,fig,ax,Strategy)
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
        # add linediagramm for each pop with label of Strategie of start and end
        lines!( xs,
                pop1, 
                label = string(Strategy[1] ," -> ",Strategie_1," repsented with $(map((x) -> round(x, digits = 3), pop1[end]))") ,
                lw = 15 ,linestyle=:dash
                )
        lines!(xs,pop2, label = string(Strategy[2] ," -> ", Strategie_2," repsented with $(map((x) -> round(x, digits = 3),pop2[end]))") , lw = 10 , linestyle =:dot)
        lines!(xs,pop3, label = string(Strategy[3] ," -> ", Strategie_3," repsented with $(map((x) -> round(x, digits = 3),pop3[end]))") , lw = 10 , linestyle =:dashdot)
        lines!(xs,pop4, label = string(Strategy[4] ," -> ", Strategie_4," repsented with $(map((x) -> round(x, digits = 3),pop4[end]))") , lw = 10  )
        #add Legend 
        fig[2, 1] = Legend(fig, ax, " Strategies", framevisible = true)
        #Pictures in Folder Output 
        save("./Outputs/"*fig.content[1].title.val*string(Domini.Mutationrate)*".png",fig)
        return fig
    end
    #-----------------------------------------------------------------------------------------
    """
    function setup_layout(ALLSimulatedDominis,title,xlims)
    
        This function creates a new layout with multiple subplots for displaying multiple figures.
        It takes in three parameters:
        - ALLSimulatedDominis: a list of data to be plotted
        - title: the title of the layout
        - xlims: the limit of x-axis
        It returns the created layout.
    """
    function setup_layout(ALLSimulatedDominis,title,xlims)
        #new fig    
        fig = Figure(resolution = (1920,700)) # resolution ?
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
        # get axes to plot into 
        axes = Plots.setup_axes(ALLSimulatedDominis,title,xlims,positions)
        fig
    end
    """
    function setup_axes(ALLSimulatedDominis,title,xlims,positions)
    
        This function creates a list of axes with specified x- and y-labels, title, subtitle, and limits,
        It takes in four parameters:
        - ALLSimulatedDominis: a list of data to be plotted
        - title: the title of the layout
        - xlims: the limit of x-axis
        - positions: the positions of the axis in the layout
        It returns the list of created axes.
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
    
        This function plots the data on the given layout with specified x- and y-labels, title, subtitle, and limits,
        It takes in four parameters:
        - ALLSimulatedDominis: a list of data to be plotted
        - fig: the layout where the data will be plotted
        - StartStrategies: the starting strategies for the plots
        - Title: the title of the layout
        It returns the layout with all the plots.
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
            lines!(fig.content[i],pop1, label = string(StartStrategies[1] ," -> ", Strategie_1," repesented with $(map((x) -> round(x, digits = 3),pop1[end])) popsize") , lw = 15 ,color = :purple,linestyle=:dash )
            lines!(fig.content[i],pop2, label = string(StartStrategies[2] ," -> ", Strategie_2," repesented with $(map((x) -> round(x, digits = 3),pop2[end])) popsize") , lw = 15 ,color = :red, linestyle =:dot)
            lines!(fig.content[i],pop3, label = string(StartStrategies[3] ," -> ", Strategie_3," repesented with $(map((x) -> round(x, digits = 3),pop3[end])) popsize") , lw = 15 ,color = :green, linestyle =:dashdot)
            lines!(fig.content[i],pop4, label = string(StartStrategies[4] ," -> ", Strategie_4," repesented with $(map((x) -> round(x, digits = 3),pop4[end])) popsize") , lw = 15 ,color = :blue) 
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