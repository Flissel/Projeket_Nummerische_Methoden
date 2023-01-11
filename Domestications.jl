"""
	Domestications Module 
		develop Populations Trajectory based on Stragies, Mutaionrate and LongTermPayOff

"""
module Domestications
	#used packages
	using  Distributions
	
	#exported methods
	export Domesticator,simulate,add_initialzation
#-----------------------------------------------------------------------------------------
# Module types:
#-----------------------------------------------------------------------------------------
"""
Domesticator 
	A structure representing the state and configuration of a quasi-species model with mutation and selection
"""
mutable struct Domesticator

	A_LongTermPayOff::Matrix{Float64}			#LongTermPayOff
    A_PayOff::Matrix{Float64}					#PayOff
    NStrategies::Vector{Vector{Float64}}        #an n Population strategies 
    Mutationrate::Int							#Mutationduration
	resolution::Int								#res
    t::Vector{Float64}							#Time-Series 
    x::Vector{Vector{Float64}}	                #Time-series of n population types
	
	"""
	Domesticator(A_PayOff::Matrix{Float64}, NStrategies::Vector{Vector{Float64}}, Mutationrate::Int, NGenerations::Int )
		Constructor function for the Domesticator struct
		
		Parameters:
		- A_PayOff (Matrix{Float64}): The payoff matrix
		- NStrategies (Vector{Vector{Float64}}): An n-dimensional vector of strategies
		- Mutationrate (Int): The mutation rate of the model
		- NGenerations (Int): The number of generations to simulate
	"""
 	function Domesticator(A_PayOff::Matrix{Float64}, NStrategies::Vector{Vector{Float64}}, Mutationrate::Int, NGenerations::Int )
		new(
			ones(length(NStrategies),length(NStrategies)),
			A_PayOff,
			NStrategies,
			Mutationrate,
			NGenerations,
			zeros(Float64,NGenerations+1), 
            Vector{Vector{Float64}}(undef, NGenerations+1)
		)
    end
end
#-----------------------------------------------------------------------------------------
# Module methods:
#-----------------------------------------------------------------------------------------
"""
	Sets the initial state of the Domesticator struct

	Parameters:
	- Domini (Domesticator): The Domesticator struct
	- StartPopulation (Vector{Float64}): Initial population of each strategy
	- Strategies (Vector{Vector{Float64}}): A vector of strategies
	"""
function add_initialzation(Domini::Domesticator,StartPopulation::Vector{Float64},Stragies::Vector{Vector{Float64}})
	Domini.x[1] = deepcopy(StartPopulation)
	Domini.A_LongTermPayOff = calculate_longterm_payoff_matrix(Domini.A_PayOff, Domini.NStrategies)
	Domini.NStrategies = deepcopy(Stragies)
end
#-----------------------------------------------------------------------------------------
"""
function simulate(Domini::Domesticator,T::Real)

	Simulate the population over a specified number of generations

	Parameters:
	- Domini (Domesticator): The state and configuration of the quasi-species model
	- T (Real): The number of generations to simulate
"""
function simulate(Domini::Domesticator,T::Real)
	
	dt = T/Domini.resolution;		# Full time-step
	dt2 = dt/2;						# RK2 half time-step
	
	# Set up time scale and initial value of population:
	Domini.t[:] = 0:dt:T
	
	# Calculate population trajectory:
	for step = 1:Domini.resolution
		# Perform RK2 half-step:
		x  = Domini.x[step] #./sum(Domini.x)
		R  = x' * Domini.A_LongTermPayOff * x
		xh = x + dt2 * x .* (Domini.A_LongTermPayOff * x .- R)

		# Perform RK2 full-step:
		R  = xh' * Domini.A_LongTermPayOff * xh 
		Domini.x[step+1] = x + dt * xh .* (Domini.A_LongTermPayOff * xh .- R)
		
		if step % Int(Domini.Mutationrate) == 1		
			rotation_mutation(Domini,step)
			Domini.A_LongTermPayOff = calculate_longterm_payoff_matrix(Domini.A_PayOff, Domini.NStrategies)
		end	
	end
end
#-----------------------------------------------------------------------------------------

"""
function calculate_longterm_payoff_matrix(A_PayOff,NStrategies)

	Calculates the long-term payoff matrix for a given payoff matrix and set of strategies
	    Based on:
	    A[i,j] ≡ R*s[i,j].*s[j,i] + S*s[i,j].*(1-s[j,i]) + T*(1-s[i,j]).*s[j,i] + P*(1-s[i,j])(1-s[j,i])  
	    s[i,j] ≡ (r[i]*qj + qi)/(1 - r[i]*r[j])
	    r[i]   ≡ pi - qi
	    |r[i]*r[j]| < 1

	Parameters:
	- A_PayOff (Matrix{Float64}): The payoff matrix
	- NStrategies (Vector{Vector{Float64}}): An n-dimensional vector of strategies

	Returns:
	- A_LongTermPayOff (Matrix{Float64}): The calculated long-term payoff matrix
"""
function calculate_longterm_payoff_matrix(A_PayOff::Matrix{Float64},NStrategies::Vector{Vector{Float64}})
	#declartion
	r = zeros(size(NStrategies, 1))
	strategieSize = length(NStrategies)
	s = zeros(strategieSize, strategieSize)
	A_LongTermPayOff = deepcopy(s)
	q = Vector{Float64}(undef, strategieSize)
	#give values
	R = A_PayOff[1, 1]
	S = A_PayOff[1, 2]
	T = A_PayOff[2, 1]
	P = A_PayOff[2, 2]
	#Calculate r
	for k in 1:strategieSize
		tmp = NStrategies[k][:]
		r[k] = tmp[1] - tmp[2]
	end
	# Calculate Values for Matrix
	for i in 1:strategieSize
		for j in 1:strategieSize
			q[j] = NStrategies[j][2]
			q[i] = NStrategies[i][2]
			s[i,j] = (r[i] * q[j] + q[i])/(1 - r[i]*r[j])
		end
	end
	# set it
	for i in 1:strategieSize
		for j in 1:strategieSize
			A_LongTermPayOff[i,j] = R*s[i,j]*s[j,i] + S*s[i,j]*(1-s[j,i]) + T*(1-s[i,j])*s[j,i] + P*(1-s[i,j])*(1-s[j,i])	
		end
	end
	A_LongTermPayOff
end
#-----------------------------------------------------------------------------------------
"""
function rotation_mutation(Domini::Domesticator, step::Int) 
	
	is a mutation function used to update a strategy in a population of strategies in a Quasi-Species model.

	The function takes in two arguments:
	
	Domini (Domesticator): A Domesticator struct representing the state and configuration of a Quasi-species model
	step (Int): Current generation step.
	The function is responsible for updating the strategy of the worst performing strategy in the population, by taking a template strategy from the best performing strategies in the population. The template strategy is then slightly altered by adding random values within a certain range. Finally, these new values are clamped to a certain range to ensure that the strategy remains valid.
	
	This function modifies the Domini struct passed in by replacing the strategy of the worst performing strategy with the new mutated strategy.

"""
function rotation_mutation(Domini::Domesticator, step::Int)
	worstStrategy = findmin(Domini.x[step])
	templateStrategy=select_template_strategie(Domini,step)
	# random max min vals based on the TemplateStrategie
    minVal = abs(minimum(templateStrategy) + rand(Uniform(-0.2,0.2)))
    maxVal = abs(maximum(templateStrategy) + rand(Uniform(-0.2,0.2)))

	# random vals for Distribution of Template
    randValq =  rand(Uniform(- 0.2, 0.2))
    randValp =  rand(Uniform(- 0.2, 0.2))
    templateStrategy[1] = randValq + templateStrategy[1]
    templateStrategy[2] = randValp + templateStrategy[2]

	#To hold the Stragie in range of 0-1 
	if maxVal > 0.999 
		maxVal = abs(0.1 * rand(Uniform(-1,1)))
	end	
    templateStrategy[1] = clamp(templateStrategy[1],minVal,maxVal)
    templateStrategy[2] = clamp(templateStrategy[2],minVal,maxVal)

	#replace 
    Domini.NStrategies[worstStrategy[2]][1] = templateStrategy[1]
    Domini.NStrategies[worstStrategy[2]][2] = templateStrategy[2]
end
#-----------------------------------------------------------------------------------------
"""
function select_template_strategie(Domini::Domesticator, step::Int)

	Selects a template strategy from the set of strategies in the Domesticator struct.

	Parameters:
	- Domini (Domesticator): The Domesticator struct containing the set of strategies
	- step (Int): The current step/generation in the simulation

	Returns:
	- templateStrategy (Vector{Float64}): A copy of the selected template strategy
"""
function select_template_strategie(Domini::Domesticator, step::Int)
	#best worst target 
	bestStrategy = findmax(Domini.x[step])

    # get the number of strategies
    numStrategies = length(Domini.NStrategies)

    # Define the probability of selecting the best strategy
    probBest = 0.7 # 70% chance of selecting the best strategy
    probOther = (1 - probBest) / (numStrategies - 1)

    # Create the probability array
    probArray = fill(probOther, numStrategies)
    probArray[bestStrategy[2]] = probBest

    # Generate a random number between 1 and the total number of strategies 
    selectedTemplate = rand(Categorical(probArray))

    #Select the template strategy based on the random number
    templateStrategy = deepcopy(Domini.NStrategies[selectedTemplate])
	templateStrategy
end	
#-----------------------------------------------------------------------------------------
end# ... of module Domestications

 
