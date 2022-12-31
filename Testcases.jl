module Testcases

	export Testcase, testcase_all_defect

	struct Testcase 
		
		A_PayOff::Matrix{Float64}
		ChosenStragies::Vector{Vector{Float64}}
		StartPopulation::Vector{Float64}
		NGenerations::Int
		Mutationrate::Int

		function Testcase(A_PayOff::Matrix{Float64}, ChosenStragies::Vector{Vector{Float64}}, StartPopulation::Vector{Float64})
			NGenerations = 1000
			Mutationrate = NGenerations * 0.01
			
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
	println("\n============ Testcase: All_Defect: ===============")
	A_PayOff = [4.0 0.0; 5.0 1.0]
	AllDefect = [[0, 0], [0, 0.2], [0.2, 0.2], [0.4, 0.3]]
	StartPopulation = [1.,1.,1.,1.]
	StandardisedStartPopulation = StartPopulation / sum(StartPopulation)

	println("\n============ chosen Mutaionsrate ==============")
	Mutationrate = 10
	println(Mutationrate)

	println("\n============ chosen strategies: ===============")
	println(AllDefect) 

	println("\n============ Intially Population: ===============")
	println(StartPopulation) 

	Test = Testcase(A_PayOff,AllDefect,StandardisedStartPopulation)
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