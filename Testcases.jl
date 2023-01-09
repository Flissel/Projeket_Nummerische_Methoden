module Testcases

	using DelimitedFiles
	

	export Testcase, testcase_all_defect ,testcase_tit_for_tat, testcase_all_cooperate,testcase_grimm

	struct Testcase 
		Title::String
		A_PayOff::Matrix{Float64}
		ChosenStragies::Vector{Vector{Float64}}
		StartPopulation::Vector{Float64}
		NGenerations::Int
		Mutationrate::Vector{Int}
		StartStrategies::Vector{Vector{Float64}}

		function Testcase(	Title::String,A_PayOff::Matrix{Float64},
			 				ChosenStragies::Vector{Vector{Float64}}, StartPopulation::Vector{Float64},
			 				Mutationrate::Vector{Int},StartStrategies::Vector{Vector{Float64}})
			NGenerations = 10000
			new(
			Title,	
			A_PayOff,
			ChosenStragies,
			StartPopulation,
			NGenerations,
			Mutationrate,
			StartStrategies,
			)
		end
		
	end
 
	global const MUTIONRATE = [1,100,250,500,1000]
"""
Test AllDefect
"""
function testcase_all_defect()
	#define Title
	Title ="All_Defect"
	println("\n============ Testcase: All_Defect: ==============")
	println("============ chosen PayOff_Matrix  ==============")
	#define PayOff
	A_PayOff = [4.0 0.0; 5.0 1.0]
	writedlm(stdout, A_PayOff)
	println("============ chosen Mutaionsrate   ==============")
	#define Mutaionsrate
	Mutationrate = MUTIONRATE
	println("After $Mutationrate generations 1 mutation")
	println("============ chosen strategies:    ==============")
	#define Stragies
	Stragies = [[0.01, 0.03], [0.12, 0.2], [0.5, 0.3], [0.15, 0.1]]
	#copy for later
	StartStrategies = deepcopy(Stragies)
	println(Stragies) 
	println("============ Intially Population:  ==============")
	#define stardised Startpopulation
	StartPopulation = [1.,1.,1.,1.] ## edit here for new startpop
	StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
	println(StartPopulation) 
	#define Testobj
	Test = Testcase(Title,A_PayOff,Stragies,StandardisedStartPopulation,Mutationrate,StartStrategies)
	Test
end

"""
Test 2 Tit-For-Tat
"""
function testcase_tit_for_tat()
    Title ="Tit_For_Tat"
	println("\n============ Testcase: Tit-For-Tat: ==============")
	println("============ chosen PayOff_Matrix  ==============")
	A_PayOff = [4.0 0.0; 5.0 1.0]
	writedlm(stdout, A_PayOff)
	Stragies = [[0.9, 0.01], [0.9, 0.002], [0.8, 0.001], [0.85, 0.2]]
	StartStragies = deepcopy(Stragies)
	StartPopulation = [1.,1.,1.,1.] ## edit here for new startpop
	StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
 
	println("============ chosen Mutaionsrate   ==============")
	Mutationrate = MUTIONRATE
	println("After $Mutationrate generations 1 mutation")

	println("============ chosen strategies:    ==============")
	println(Stragies) 

	println("============ Intially Population:  ==============")
	println(StartPopulation) 

	Test = Testcase(Title,A_PayOff,Stragies,StandardisedStartPopulation,Mutationrate,StartStragies)
	Test								
end 

function testcase_all_cooperate()
    Title ="All_Cooperate"
	println("\n============ Testcase: Testcase_All_Cooperate: ==============")
	println("============ chosen PayOff_Matrix  ==============")
	A_PayOff = [4.0 0.0; 5.0 1.0]
	writedlm(stdout, A_PayOff)
	Stragies = [[0.9, 0.92], [0.9, 0.8], [0.8, 1.], [0.85, 0.95]]
	StartStragies = deepcopy(Stragies)
	StartPopulation = [1.,1.,1.,1.] ## edit here for new startpop
	StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
 
	println("============ chosen Mutaionsrate   ==============")
	Mutationrate = MUTIONRATE
	println("After $Mutationrate generations 1 mutation")

	println("============ chosen strategies:    ==============")
	println(Stragies) 

	println("============ Intially Population:  ==============")
	println(StartPopulation) 

	Test = Testcase(Title,A_PayOff,Stragies,StandardisedStartPopulation,Mutationrate,StartStragies)
	Test								
end 
function testcase_grimm()
    Title ="Grimm"
	println("\n============ Testcase: Testcase_Grimm: ==============")
	println("============ chosen PayOff_Matrix  ==============")
	A_PayOff = [4.0 0.0; 5.0 1.0]
	writedlm(stdout, A_PayOff)
	Stragies = [[0.4, 0.], [0.5, 0.], [0.5, 0.], [0.45, 0.]]
	StartStragies = deepcopy(Stragies)
	StartPopulation = [1.,1.,1.,1.] ## edit here for new startpop
	StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
 
	println("============ chosen Mutaionsrate   ==============")
	Mutationrate = MUTIONRATE
	println("After $Mutationrate generations 1 mutation")

	println("============ chosen strategies:    ==============")
	println(Stragies) 

	println("============ Intially Population:  ==============")
	println(StartPopulation) 

	Test = Testcase(Title,A_PayOff,Stragies,StandardisedStartPopulation,Mutationrate,StartStragies)
	Test								
end 
function testcase_mixed_up()
    Title ="Mixed_up"
	println("\n============ Testcase: Testcase_Grimm: ==============")
	println("============ chosen PayOff_Matrix  ==============")
	A_PayOff = [4.0 0.0; 5.0 1.0]
	writedlm(stdout, A_PayOff)
	Stragies = [[0.0, 0.0], [1., 0.0], [0.0, 1.0], [1.0, 0.0]]
	StartStragies = deepcopy(Stragies)
	StartPopulation = [1.,1.,1.,1.] ## edit here for new startpop
	StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
 
	println("============ chosen Mutaionsrate   ==============")
	Mutationrate = MUTIONRATE
	println("After $Mutationrate generations 1 mutation")

	println("============ chosen strategies:    ==============")
	println(Stragies) 

	println("============ Intially Population:  ==============")
	println(StartPopulation) 

	Test = Testcase(Title,A_PayOff,Stragies,StandardisedStartPopulation,Mutationrate,StartStragies)
	Test								
end 	
end