include("Testcases.jl")
include("Domestications.jl")
include("Plots.jl")

using GLMakie:save
const T = 10
 
function presentation()
    #get all Testcases
    Tests = [Testcases.testcase_all_defect(),Testcases.testcase_grimm(),
            Testcases.testcase_all_cooperate(),Testcases.testcase_tit_for_tat()]
    i = 1 # countervar
    ALLSimulatedDominisInTest=[] 
    for Test in Tests
        #numberOfLayouts=length(Test.Mutationrate)
        #make for every Mutationrate an SimulationObj
        for Mutationsrate in Test.Mutationrate
            Domini = Domestications.Domesticator(Test.A_PayOff,Test.ChosenStragies,Mutationsrate,Test.NGenerations)
            push!(ALLSimulatedDominisInTest,Domini)
        end
        for Domini in ALLSimulatedDominisInTest 
             # add addInitialzation
            Domestications.add_initialzation(Domini,Test.StartPopulation)
            # simulate
            Domestications.simulate!(Domini,T) 
            # fancy printing
            println("\nTest: " , Test.Title," with every $(Domini.Mutationrate) Generation one Mutation")
            println("Start Population:" , Domini.x[1])
            println("Last Populationvalues: ", Domini.x[end])
            println("Envolved Stategies: ", Domini.NStrategies)
            # setup Plot 
            fig,ax = Plots.setup_figure(Test.Title,Domini.Mutationrate,Domini.resolution)
            # fill with data
            Plots.fill_figure_with_data(Domini,fig,ax,Test.StartStrategies,i)	
            # push into a list for Layout
            i += 1 
        end
        fig = Plots.setup_layout(ALLSimulatedDominisInTest,Test.Title,Test.NGenerations)
        fig = Plots.fill_layout_with_data(ALLSimulatedDominisInTest,fig,Test.StartStrategies,Test.Title)
        ALLSimulatedDominisInTest = []
        display(fig)
        sleep(40)
    end 

end   
Main.presentation()


    