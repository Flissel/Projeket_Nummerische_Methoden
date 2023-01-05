include("Testcases.jl")
include("Domestications.jl")
include("Plots.jl")


const T = 10

function presentation()
    tests = [Testcases.testcase_all_defect(),Testcases.testcase_grimm(),Testcases.testcase_all_cooperate(),Testcases.testcase_tit_for_tat()]
    i = 1 
    for test in tests
        Dominis=[] 
        for Mutationsrate in test.Mutationrate
            Domini = Domestications.Domesticator(test.A_PayOff,test.ChosenStragies,Mutationsrate,test.NGenerations)
            push!(Dominis,Domini)
        end
        Plts = []
        for Domini in Dominis 
             # add addInitialzation
            Domestications.add_initialzation(Domini,test.StartPopulation)
            # simuliere 
            Domestications.simulate!(Domini,T) 
            println("\nStart Population:" , Domini.x[1])
            println("Last Populationvalues: ", Domini.x[end])
            println("Chosen Stategies: ", Domini.NStrategies)
            # speichere Bild nach der ersten Simulation
            fig = Plots.setup_figure(test.Title,Domini.Mutationrate)
            plt = Plots.fill_figure_with_data(Domini,fig,test.StartStrategies)	
            push!(Plts,plt)
            savefig("./Outputs/p"* string(i))
            
            if i % 5 == 0 
                layout=Plots.setup_layout(Plts) 
                savefig("./Outputs/layout"*string(i))
                display(layout)
            end 
            i += 1 
        end  
    end 

end   
Main.presentation()


    