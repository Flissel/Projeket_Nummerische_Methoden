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
    of a Dominicator Model with Mutation and Selection.
	"""
	struct Testcase 
		Title::String
		A_PayOff::Matrix{Float64}
		ChosenStrategies::Vector{Vector{Float64}}
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
			- StartStrategies (Vector{Vector{Float64}}): A vector of starting strategies (just for prints)
			- T (Int): The total time for the testcase
		"""
		function Testcase(	Title::String,A_PayOff::Matrix{Float64},
			 				ChosenStrategies::Vector{Vector{Float64}}, StartPopulation::Vector{Float64},
			 				Mutationrate::Vector{Int},StartStrategies::Vector{Vector{Float64}})
			T 
			NGenerations = NGENERATIONS
			new(
			Title,	
			A_PayOff,
			ChosenStrategies,
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
		Strategies = STRATEGIES_ALL_DEFECT
		#copy for later
		StartStrategies = deepcopy(Strategies)
		#define stardised Startpopulation
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		#define TestOjk
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test #return
	end
	"""
	Test Tit-For-Tat
	"""
	function testcase_tit_for_tat()
	    Title ="Tit_For_Tat"
		A_PayOff = A_PAYOFF
		Stragies = STRATEGIES_TIT_FOR_TAT
		StartStragies = deepcopy(Stragies)
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Stragies,StandardisedStartPopulation,Mutationrate,StartStragies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------

	#-----------------------------------------------------------------------------------------
	"""
	Test All_Cooperate
	"""
	function testcase_all_cooperate()
	    Title ="All_Cooperate"
		A_PayOff = A_PAYOFF
		Strategies = STRATEGIES_ALL_COOPERATE
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
		Strategies = STRATEGIES_GRIMM
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION 
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
		Strategies = STRATEGIES_EXTREM_MIX_UP
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION 
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
		Strategies = STRATEGIES_RANDOM
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
		Strategies = STRATEGIES_MIX_UP
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------
	"""
	Test Coex
	"""
	function testcase_coex()
	    Title ="Coex"
		A_PayOff = A_PAYOFF
		Strategies = STRATEGIES_COEX
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------
	"""
	Test TFT_VS_ADF
	"""
	function testcase_tft_vs_adf()
	    Title ="TFT_VS_ADF"
		A_PayOff = A_PAYOFF
		Strategies = STRATEGIES_TFT_VS_DF
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end 
	#-----------------------------------------------------------------------------------------
	"""
	Test TFT_VS_AC
	"""
	function testcase_tft_vs_ac()
	    Title ="TFT_VS_AC"
		A_PayOff = A_PAYOFF
		Strategies = STRATEGIES_TFT_VS_AC
		StartStrategies = deepcopy(Strategies)
		StartPopulation = STARTPOPULATION 
		StandardisedStartPopulation = StartPopulation / sum(StartPopulation)
		Mutationrate = deepcopy(MUTATIONRATE)
		Test = Testcase(Title,A_PayOff,Strategies,StandardisedStartPopulation,Mutationrate,StartStrategies)
		Test								
	end
	
end #of Testcases