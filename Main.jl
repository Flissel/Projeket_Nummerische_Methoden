#include("Requirements.jl") # just run me ones. 
include("Testcases.jl")
include("Domestications.jl")
include("Plots.jl")
"""
    presentation() 
         - Runs all testcases 
         - based on:
              amount of tests,
              mutaionsrates,
           will be Domesticator Obj defined, and simulated 
         - in Folder Outputs will be every Figure,Scene saved as png 
         - the layouts will be displayed for some seconds om Screen  
"""
function presentation()
    #get all Testcases
    Tests = [Testcases.testcase_tit_for_tat(),Testcases.testcase_all_defect(),
             Testcases.testcase_all_cooperate(),Testcases.testcase_grimm(),
             Testcases.testcase_extrem_mixed_up(),Testcases.testcase_random(),
             Testcases.testcase_mixed_up()]

    ALLSimulatedDominisInTest=[] 
    for Test in Tests
        #make for every Mutationrate an SimulationObj
        for Mutationrate in Test.Mutationrate
            Domini = Domestications.Domesticator(Test.A_PayOff,Test.ChosenStragies,Mutationrate,Test.NGenerations)
            push!(ALLSimulatedDominisInTest,Domini)
        end
        # simulate each Domini
        for Domini in ALLSimulatedDominisInTest 
             # add addInitialzation
            Domestications.add_initialzation(Domini,Test.StartPopulation,Test.ChosenStragies)
            # simulate
            Domestications.simulate(Domini,Test.T) 
            # fancy printing
            println("\nTest:                " , Test.Title," with every $(Domini.Mutationrate) Steps 1 Mutation")
            println("Start Population:      " , Domini.x[1])
            println("Last Populationvalues: " , map((x) -> round(x, digits = 4), Domini.x[end]))
            println("Start Stategies        " ,Test.ChosenStragies)
            println("Developed Stategies:   " , map((x) -> round(x, digits = 4), Domini.NStrategies[1]),map((x) -> round(x, digits = 4), Domini.NStrategies[2])
                                              , map((x) -> round(x, digits = 4), Domini.NStrategies[3]),map((x) -> round(x, digits = 4), Domini.NStrategies[4]))
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
        display(fig)
        sleep(10)
    end 
end   
Main.presentation()


    