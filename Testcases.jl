module Testcases

	export Testcase, testcase_all_defect

	struct Testcase 
		
		A_PayOff::Matrix{Float64}
		ChosenStragies::Vector{Vector{Float64}}
		StartPopulation::Vector{Float64}
		NGenerations::Int

		function Testcase(A_PayOff::Matrix{Float64},ChosenStragies::Vector{Vector{Float64}},StartPopulation::Vector{Float64},NGenerations::Int=100)
			new(
			A_PayOff,
			ChosenStragies,
			StartPopulation,
			NGenerations
			)
		end
		
	end

		
"""
Test 1 ALL AllDefect
"""

function testcase_all_defect()
	println("\n============ Testcase: All_Defect: ===============")
	# Define cyclic mutation matrix (column sum = 1):
	A_PayOff = [4.0 0.0; 5.0 1.0]
	AllDefect = [[0, 0], [0, 0.2], [0.2, 0.2], [0.4, 0.3]]
	StartPopulation = [1.,1.,1.,1.]
	StandardisedStartPopulation = StartPopulation / sum(StartPopulation)

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

	# Define cyclic mutation matrix (column sum = 1):
	A_PayOff = [4.0 0.0; 5.0 1.0]
	AllCooperate = [[0, 0], [0, 0.2], [0.2, 0.2], [0.4, 0.3]]

	println("\n============ chosen strategies: ===============")
	println(AllCooperate) 

									
end 

end