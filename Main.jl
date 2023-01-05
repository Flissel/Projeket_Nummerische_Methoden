include("Testcases.jl")
include("Domestications.jl")
include("Plots.jl")


const T = 10

function presentation()
    
    println("Test 1: ")
    # erstelle Tastecase 1
    Test1 = Testcases.testcase_all_defect()
    # erstelle Dominicator 
    Domini = Domestications.Domesticator(Test1.A_PayOff,Test1.ChosenStragies,Test1.Mutationrate)
    # add addInitialzation
    Domestications.add_initialzation(Domini,Test1.StartPopulation)
    # simuliere 
    Domestications.simulate!(Domini,T) # 10 Generationen
    println("\n Start Population:" , Domini.x[1])
    println("Last Populationvalues: ", Domini.x[end])
    println("Chosen Stategies: ", Domini.NStrategies)
    # speichere Bild nach der ersten Simulation
    plt1 = Plots.do_lines(Domini)	
    # TODO mache ein Layout und 
    
    println("Test2: ")
   
   # display_results(Test)

end   

   
   
Main.presentation()


    