#========================================================================================#
"""
	Mutators

Module Mutators: A model of mutation and the quasi-species equation.

Author: Niall Palfreyman, 22/11/2022
"""





module Domestications
	using DelimitedFiles , Distributions
	export Domesticator,simulate!,add_initialzation,calculate_longterm_payoff_matrix
#-----------------------------------------------------------------------------------------
# Module types:
#-----------------------------------------------------------------------------------------
"""
	Domesticator

A Mutator represents the time-evolution of a quasi-species model with mutation and selection.
"""
mutable struct Domesticator

	A_LongTermPayOff::Matrix{Float64}			#
    A_PayOff::Matrix{Float64}					#
    NStrategies::Vector{Vector{Float64}}        #an n Population strategies 
    Mutationrate::Int
	resolution::Int
    t::Vector{Float64}
    x::Vector{Vector{Float64}}	                #Time-series of n population types

	"""
		
	"""

 	function Domesticator(A_PayOff::Matrix{Float64}, NStrategies::Vector{Vector{Float64}},Mutationrate::Int,NGenerations::Int )
		

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
function add_initialzation(Domini::Domesticator,StartPopulation::Vector{Float64})
	Domini.x[1] = deepcopy(StartPopulation)
	Domini.A_LongTermPayOff = calculate_longterm_payoff_matrix(Domini.A_PayOff, Domini.NStrategies)
end

function simulate!(Domini::Domesticator,T::Real)
	
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
		
		if step % Int(Domini.Mutationrate) == 0		
			mutate_worst_strategie(Domini,step)
			Domini.A_LongTermPayOff = calculate_longterm_payoff_matrix(Domini.A_PayOff, Domini.NStrategies)
		end	
	end
end
#nowak
#     A[i,j] ≡ R*s[i,j].*s[j,i] + S*s[i,j].*(1-s[j,i]) + T*(1-s[i,j]).*s[j,i] + P*(1-s[i,j])(1-s[j,i]) bestimmte kombination aus s, zeigt die transformation von population 
#     s[i,j] ≡ (r[i]*qj + qi)/(1 - r[i]*r[j]) matrix von werten, berechnet aus strategien
#     r[i]   ≡ pi - qi
#     |r[i]*r[j]| < 1
# end
function calculate_longterm_payoff_matrix(A_PayOff,NStrategies)
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
	#
	for k in 1:strategieSize
		tmp = NStrategies[k][:]
		r[k] = tmp[1] - tmp[2]
	end
	#
	for i in 1:strategieSize
		for j in 1:strategieSize
			q[j] = NStrategies[j][2]
			q[i] = NStrategies[i][2]
			s[i,j] = (r[i] * q[j] + q[i])/(1 - r[i]*r[j])
		end
	end

	for i in 1:strategieSize
		for j in 1:strategieSize
			A_LongTermPayOff[i,j] = R*s[i,j]*s[j,i] + S*s[i,j]*(1-s[j,i]) + T*(1-s[i,j])*s[j,i] + P*(1-s[i,j])*(1-s[j,i])	
		end
	end
	#writedlm(stdout, A_LongTermPayOff)
	A_LongTermPayOff
end

function mutate_worst_strategie(Domini,step) 
	#find min max of Population
    bestStrategie= findmax(Domini.x[step])
    worstStrategie = findmin(Domini.x[step])
	#save their Stragies 
    TargetStrategie = deepcopy(Domini.NStrategies[worstStrategie[2]])
    TemplateStrategie = deepcopy(Domini.NStrategies[bestStrategie[2]])
	#show in Terminal
   # println("\nStrategie To Mutate: " , TargetStrategie )
  #  println("Strategie used as Template: " , TemplateStrategie)
	#calulate some randomes 
	randval1 = 0.2 * rand(Uniform(-1,1)) 
    randval2 = 0.2 * rand(Uniform(-1,1)) 
	#new Stragie in area of the TemplateStragie 
    TargetStrategie[1] = randval1 + TemplateStrategie[1]
    TargetStrategie[2] = randval2 + TemplateStrategie[2]

	# for hold StragieValues in an Area from 0 - 1 
	if TargetStrategie[1] > 1 
		TargetStrategie[1] = TemplateStrategie[1] - abs(randval1)
   	end       	
   	if TargetStrategie[2] > 1 
		TargetStrategie[2] = TemplateStrategie[2] - abs(randval2)
   	end 
	if TargetStrategie[1] < 0 
		TargetStrategie[1] = TemplateStrategie[1] +  abs(randval1)
   	end   
	if TargetStrategie[2] < 0
		TargetStrategie[2] = TemplateStrategie[2] + abs(randval1)
   	end    

	#println("\nStragie $(Domini.NStrategies[worstStrategie[2]]) mutated to $TargetStrategie at Generation $step")
	
	#replace old Stragie with new
	Domini.NStrategies[worstStrategie[2]][1] = TargetStrategie[1]
	Domini.NStrategies[worstStrategie[2]][2] = TargetStrategie[2]
end    

end		# ... of module Domestications

 
