"""
	Module Testcases
	 Providing Tests for Domestications Module
"""
module Testcases

include("PlayGround.jl")
	#-----------------------------------------------------------------------------------------
	# Module types:
	#-----------------------------------------------------------------------------------------	
	"""
    A structure representing the testcase configuration 
    of a quasi-species model with mutation and selection.
	"""
	struct Testcase 
		Title::String
		A_PayOff::Matrix{Float64}
		ChosenStragies::Vector{Vector{Float64}}
		StartPopulation::Vector{Float64}
		NGenerations::Int
		Mutationrate::Vector{Int}
		StartStrategies::Vector{Vector{Float64}}
		T::Int
		"""
		Testcase(   Title::String, A_PayOff::Matrix{Float64},
					ChosenStragies::Vector{Vector{Float64}}, StartPopulation::Vector{Float64},
					Mutationrate::Vector{Int}, StartStrategies::Vector{Vector{Float64}})

			Parameters:
			- Title (String): The Title of the testcase
			- A_PayOff (Matrix{Float64}): The payoff matrix
			- ChosenStragies (Vector{Vector{Float64}}): A vector of chosen strategies
			- StartPopulation (Vector{Float64}): The starting population of the testcase
			- Mutationrate (Vector{Int}): The mutation rate of the testcase
			- StartStrategies (Vector{Vector{Float64}}): A vector of starting strategies
			- T (Int): The total time for the testcase
		"""
		function Testcase(	Title::String,A_PayOff::Matrix{Float64},
			 				ChosenStragies::Vector{Vector{Float64}}, StartPopulation::Vector{Float64},
			 				Mutationrate::Vector{Int},StartStrategies::Vector{Vector{Float64}})
			T 
			NGenerations = NGENERATIONS
			new(
			Title,	
			A_PayOff,
			ChosenStragies,
			StartPopulation,
			NGenerations,
			Mutationrate,
			StartStrategies,
			T
			)
		end
	end
	
	#-----------------------------------------------------------------------------------------
	# Module methods:
	#-----------------------------------------------------------------------------------------
	"""
	Test 2 Tit-For-Tat
	"""
	function testcase_tit_for_tat()
	    Title ="Tit_For_Tat"
		A_PayOff = A_PAYOFF
		Stragies = [[0.9, 0.01], [0.9, 0.002], [0.8, 0.001], [0.85, 0.2]]
		StartStragies = deepcopy(Stragies)
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Stragies,StandardisedStartPopulation,Mutationrate,StartStragies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------
	"""
	Test AllDefect
	"""
	function testcase_all_defect()
		#define Title
		Title ="All_Defect"
		#define PayOff
		A_PayOff = A_PAYOFF
		#define Mutaionsrate
		Mutationrate = deepcopy(MUTATIONRATE)
		#define Stragies
		Strategies = [[0.01, 0.03], [0.12, 0.2], [0.5, 0.3], [0.15, 0.1]]
		#copy for later
		StartStrategies = deepcopy(Strategies)
		#define stardised Startpopulation
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test
	end
	#-----------------------------------------------------------------------------------------
	"""
	Test All_Cooperate
	"""
	function testcase_all_cooperate()
	    Title ="All_Cooperate"
		A_PayOff = A_PAYOFF
		Strategies = [[0.9, 0.92], [0.9, 0.8], [0.8, 0.9], [0.85, 0.95]]
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------
	"""
	Test Grimm
	"""
	function testcase_grimm()
	    Title ="Grimm"
		A_PayOff = A_PAYOFF
		Strategies = [[0.4, 0.01], [0.5, 0.01], [0.5, 0.01], [0.45, 0.001]]
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION ## edit here for new startpop
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------
	"""
	Test Extrem_Mixed_up
	"""
	function testcase_extrem_mixed_up()
	    Title ="Extrem_Mixed_up"
		A_PayOff = A_PAYOFF
		Strategies = [[0.01, 0.01], [0.99, 0.01], [0.01, 0.99], [0.99, 0.01]]
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION ## edit here for new startpop
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------
	"""
	Test Random
	"""
	function testcase_random()
	    Title = "Random"
		A_PayOff = A_PAYOFF
		Strategies = [[rand(0.2:0.2:0.8), rand(0.2:0.2:0.8)],
		    		 [rand(0.2:0.2:0.8), rand(0.2:0.2:0.8)], 
					 [rand(0.2:0.2:0.8), rand(0.2:0.2:0.8)], 
					 [rand(0.2:0.2:0.8), rand(0.2:0.2:0.8)]]
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------
	"""
	Test Mixed_up
	"""
	function testcase_mixed_up()
	    Title ="Mixed_up"
		A_PayOff = A_PAYOFF
		Strategies = [[0.31, 0.31], [0.66, 0.31], [0.61, 0.69], [0.69, 0.31]]
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION ## edit here for new startpop
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end 
end