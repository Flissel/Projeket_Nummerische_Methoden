
# include("Requirements.jl") # just run me ones. 
include("Testcases.jl")
include("Domestications.jl")
include("Plots.jl")
include("Playground.jl")
"""
    presentation() 
         - Runs all testcases 
         - based on:
              amount of tests,
              mutaionsrates,
           will be Domesticator Obj defined, and simulated 
         - in Folder Outputs will be every Figure,Scene saved as png 
         - the layouts will be displayed for some seconds on Screen  
"""
function presentation()
    #get all Testcases
    Tests = [
             Testcases.testcase_tit_for_tat(),
             Testcases.testcase_all_defect(),
             Testcases.testcase_all_cooperate(),
             Testcases.testcase_grimm(),
             Testcases.testcase_mixed_up(),
             Testcases.testcase_random(),
             Testcases.testcase_tft_vs_ac(),
             Testcases.testcase_tft_vs_adf(),
             Testcases.testcase_extrem_mixed_up(),
             Testcases.testcase_coex() 
            ]
    #ObjContainer
    ALLSimulatedDominisInTest=[] 
    for Test in Tests
        #make for every Mutationrate an SimulationObj
        for Mutationrate in Test.Mutationrate
            Domini = Domestications.Domesticator(Test.A_PayOff,Test.ChosenStrategies,Mutationrate,Test.NGenerations)
            push!(ALLSimulatedDominisInTest,Domini)
        end
        # simulate each Domini
        for Domini in ALLSimulatedDominisInTest 
             # add addInitialzation
            Domestications.add_initialzation(Domini,Test.StartPopulation,Test.ChosenStrategies)
            # simulate
            Domestications.simulate(Domini,Test.T) 
            # fancy printing
            Main.fancy_printing(Test,Domini)
            # setup Figure 
            fig,ax = Plots.setup_figure(Test.Title,Domini.Mutationrate,Domini.resolution)
            # fill with data
            Plots.fill_figure_with_data(Domini,fig,ax,Test.StartStrategies)	 
        end
        #sets up the layout
        fig = Plots.setup_layout(ALLSimulatedDominisInTest,Test.Title,Test.NGenerations)
        #fill wtih the data 
        fig = Plots.fill_layout_with_data(ALLSimulatedDominisInTest,fig,Test.StartStrategies,Test.Title)
        ALLSimulatedDominisInTest = [] 
        Main.add_results_to_terminal(Test.Title) 
        display(fig)
        sleep(TIME_DISPLAY_LAYOUT)
    end 
   
end   
  
"""
    function fancy_printing(Test,Domini)
        does the Out in Terminal 
            based on given 
            - Test 
            - Mutationrate
"""
function fancy_printing(Test, Domini)
    println("\nTest:                " , Test.Title," with every $(Domini.Mutationrate) Steps 1 Mutation")
    println("Start Population:      " , Domini.x[1])
    println("Last Populationvalues: " , map((x) -> round(x, digits = 4), Domini.x[end]))
    println("Start Stategies        " ,Test.ChosenStrategies)
    println("Developed Stategies:   " , map((x) -> round(x, digits = 4), Domini.NStrategies[1]),
                                        map((x) -> round(x, digits = 4), Domini.NStrategies[2]),
                                        map((x) -> round(x, digits = 4), Domini.NStrategies[3]),
                                        map((x) -> round(x, digits = 4), Domini.NStrategies[4]))
end

"""
    function add_results_to_terminal(title)
        This function prints the results of the specified title to the terminal.
        It takes in one parameter:
        - title: the title of the result that should be printed to the terminal
"""
    function add_results_to_terminal(title)
        results = Dict("All_Defect" => RES_ALL_DEFECT,
                       "Tit_For_Tat" => RES_TIT_FOR_TAT,
                       "All_Cooperate" => RES_ALL_COOPERATE,
                       "Grimm" => RES_GRIMM,
                       "Extrem_Mixed_up" => RES_EXTREM_MIXED_UP,
                       "Random" => RES_RANDOM,
                       "Mixed_up" => RES_MIXED_UP,
                       "Coex" => RES_COEX,
                       "TFT_VS_ADF" => RES_TFT_VS_ADF,
                       "TFT_VS_AC" => RES_TFT_VS_AC)
        println()
        if haskey(results, title)
            println("Results: $title")
            println(results[title]) 
        end
        
    end

Main.presentation()
    