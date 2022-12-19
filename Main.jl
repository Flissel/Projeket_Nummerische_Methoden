include("Testcases.jl")
include("Domestications.jl")
include("Plots.jl")
           
const T = 10			
function presentation()

    ###################
    println("Test1: ")
    #erstelle Tastecase 1
    Test1 = Testcases.testcase_all_defect()
    #simuliere Test 1
    Domini = Domestications.Domesticator(Test1.A_PayOff,Test1.ChosenStragies,Test1.NGenerations)
    Domestications.addInitialzation(Domini,Test1.StartPopulation)
    
    for stragie in 1:length(Domini.NStrategies)
        Domestications.simulate!(Domini,T)
    end    
   #  obs_DF= Oberservable(DataFrame())
    #TODO reshape Domini.x to arr with pop1 new arr with pop2
	Plots.do_lines(Domini)	
    #####################
    println("Test2: ")
   
   # display_results(Test)

end   
Main.presentation()


    