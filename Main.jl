include("Testcases.jl")
include("Domestications.jl")
include("Plots.jl")


const T = 10

function presentation()
    ###################
    println("Test1: ")
    # erstelle Tastecase 1
    Test1 = Testcases.testcase_all_defect()
    # erstelle Dominicator 
    Domini = Domestications.Domesticator(Test1.A_PayOff,Test1.ChosenStragies,Test1.Mutationrate)
    # add addInitialzation
    Domestications.add_initialzation(Domini,Test1.StartPopulation)
    # simuliere 
    Domestications.simulate!(Domini,T) # 10 Generationen
    # speichere Bild nach der ersten Simulation
    # plt1 = Plots.do_lines(Domini)	

    # nimm die Spalte mit den kleinsten Wert 
    mutate_worst_Strategie(Domini)

    Domestications.add_initialzation(Domini,Test1.StartPopulation)
    Domestications.simulate!(Domini,T)
    # plt2 = Plots.do_lines(Domini)



    

   
    # nehme diese und verändere seine Werte um rand() in der nähe von der besten stragie 
   
        

        # übernehme die neue Stragie und do_nowak erneut 
         # ende
    
    #simuliere erneut 
    #Domestications.simulate!(Domini,T)

    #Speichere Bild nach der zweiten Simulation 
    #Plots.do_lines(Domini)
    
    #erstelle Layout 
    #füge den Layout die beiden Bilder hinzu

    #TODO save pic to Outputs
    # erstelle Path 
    # funktion mit speichere 
    
    # fuction Mutate_domini 
                # u will need fitness for selection and how mutation will be placed 
                # Mutationrate will be given 
                # rerun simulation 
    # save_pic 

    # fuction do_Layout and function add pics module plots 

    # save to Outputs
    # next Mutationrate 
    # redo until noMore Tests requried reached 

	
    
    #####################
    println("Test2: ")
   
   # display_results(Test)

end   

function mutate_worst_Strategie(Domini) 

    bestStrategie= findmax(Domini.x[end])
    worstStrategie = findmin(Domini.x[end])
    
    randval1 = 0.2 * rand( )
    randval2 = 0.2 * rand( )
    
    StrategieToMutate = Domini.NStrategies[worstStrategie[2]]

    TemplateStrategie = Domini.NStrategies[bestStrategie[2]]

    println("Strategie To Mutate: " , StrategieToMutate)
    println("Strategie for Mutations: " , TemplateStrategie)

    StrategieToMutate[1] = randval1 + TemplateStrategie[1]
    StrategieToMutate[2] = randval2 + TemplateStrategie[2]

    if StrategieToMutate[1] > 1 
        StrategieToMutate[1] = TemplateStrategie[1] - randval1
   end    	
   if StrategieToMutate[2] > 1 
        StrategieToMutate[2] = TemplateStrategie[2] - randval2
   end 
end    
   
Main.presentation()


    