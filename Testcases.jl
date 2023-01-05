module Testcases
	using LinearAlgebra,DelimitedFiles 
	

	export Testcase, testcase_all_defect

	struct Testcase 
		
		A_PayOff::Matrix{Float64}
		ChosenStragies::Vector{Vector{Float64}}
		StartPopulation::Vector{Float64}
		NGenerations::Int
		Mutationrate::Float64

		function Testcase(A_PayOff::Matrix{Float64}, ChosenStragies::Vector{Vector{Float64}}, StartPopulation::Vector{Float64},Mutationrate::Int)
			NGenerations = 10000
			
			new(
			A_PayOff,
			ChosenStragies,
			StartPopulation,
			NGenerations,
			Mutationrate
			)
		end
		
	end

		
"""
Test 1 ALL AllDefect
"""

function testcase_all_defect()
	println("\n============ Testcase: All_Defect: ==============")
	println("\n============ chosen PayOff_Matrix  ==============")
	A_PayOff = [4.0 0.0; 5.0 1.0]
	writedlm(stdout, A_PayOff)
	
	#show(stdout, "text/plain", A_PayOff)
	AllDefect = [[0.12, 0.0], [0.1, 0.2], [0.2, 0.2], [0.15, 0.1]]
	StartPopulation = [50.,75.,60.,103.] ## edit here for new startpop
	StandardisedStartPopulation = StartPopulation / sum(StartPopulation)

	println("\n============ chosen Mutaionsrate   ==============")
	Mutationrate = 10
	println("After $Mutationrate generations 1 mutation")

	println("\n============ chosen strategies:    ==============")
	println(AllDefect) 

	println("\n============ Intially Population:  ==============")
	println(StartPopulation) 

	Test = Testcase(A_PayOff,AllDefect,StandardisedStartPopulation,Mutationrate)
	Test
end

"""
Test 2 All_Cooperate
"""
function testcase_all_cooperate()
    
	println("\n============ Testcase: All_Cooperate: ===============")
	A_PayOff = [4.0 0.0; 5.0 1.0]
	AllCooperate = [[0, 0], [0, 0.2], [0.2, 0.2], [0.4, 0.3]]

	println("\n============ chosen strategies: ===============")
	println(AllCooperate) 									
end 

end