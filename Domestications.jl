#========================================================================================#
"""
	Mutators

Module Mutators: A model of mutation and the quasi-species equation.

Author: Niall Palfreyman, 22/11/2022
"""
module Domestications

	export Domesticator,simulate!,addInitialzation
#-----------------------------------------------------------------------------------------
# Module types:
#-----------------------------------------------------------------------------------------
"""
	Mutator

A Mutator represents the time-evolution of a quasi-species model with mutation and selection.
"""
mutable struct Domesticator

	A_LongTermPayOff::Matrix{Float64}			#
    A_PayOff::Matrix{Float64}					#
    NStrategies::Vector{Vector{Float64}}        #an n Population strategies 
    resolution::Int
    t::Vector{Float64}
    x::Vector{Vector{Float64}}	                #Time-series of n population types

	"""
		
	"""

 	function Domesticator(A_PayOff::Matrix{Float64}, NStrategies::Vector{Vector{Float64}},NGenerations)

		new(
			ones(length(NStrategies),length(NStrategies)),
			A_PayOff,
			NStrategies,
			NGenerations,
			zeros(Float64,NGenerations+1), 
            Vector{Vector{Float64}}(undef, NGenerations+1)

		)
    end
end



#-----------------------------------------------------------------------------------------
# Module methods:
#-----------------------------------------------------------------------------------------
function addInitialzation(Domini::Domesticator,StartPopulation::Vector{Float64})
	Domini.x[1] = deepcopy(StartPopulation)
	Domini.A_LongTermPayOff = do_nowak(Domini.A_PayOff, Domini.NStrategies)
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
	end
end
#nowak
#     A[i,j] ≡ R*s[i,j].*s[j,i] + S*s[i,j].*(1-s[j,i]) + T*(1-s[i,j]).*s[j,i] + P*(1-s[i,j])(1-s[j,i]) bestimmte kombination aus s, zeigt die transformation von population 
#     s[i,j] ≡ (r[i]*qj + qi)/(1 - r[i]*r[j]) matrix von werten, berechnet aus strategien
#     r[i]   ≡ pi - qi
#     |r[i]*r[j]| < 1
# end
function do_nowak(A_PayOff,NStrategies)
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
	A_LongTermPayOff
end


end		# ... of module Domestications

 
