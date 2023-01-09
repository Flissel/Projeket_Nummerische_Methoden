#========================================================================================#
"""
	Mutators

Module Mutators: A model of mutation and the quasi-species equation.

Author: Niall Palfreyman, 22/11/2022
"""

module Mutators

	export mutate!

#-----------------------------------------------------------------------------------------
# Module types:
#-----------------------------------------------------------------------------------------
"""
	QuasiSpeciesModel

A QuasiSpeciesModel represents the time-evolution of a quasi-species model with mutation and selection.
"""
struct QuasiSpeciesModel
	mutation_matrix::Matrix{Real}					# Mutation matrix
	fitness_values::Vector{Real}					# Vector of three type fitnesses
	time_steps::Int									# Resolution of timescale
	timescale::Vector{Float64}						# Timescale
	population_trajectory::Vector{Vector{Float64}}	# Time-series of three population types

	"""
		QuasiSpeciesModel( mutation_matrix, fitness_values)

	The one-and-only QuasiSpeciesModel constructor: Create a QuasiSpeciesModel population stepping from
	time zero to ngenerations (1000), using fitness values fitness_values.
	"""
 	function QuasiSpeciesModel( mutation_matrix::Matrix{Float64}, fitness_values::Vector{Float64})  
		time_steps = 900
		new(
			mutation_matrix,
			fitness_values/sum(fitness_values),
			time_steps,
			zeros(Float64,time_steps+1),
			Vector{Vector{Float64}}(undef,time_steps+1)
		)
	end
end
#-----------------------------------------------------------------------------------------
# Module methods:
#-----------------------------------------------------------------------------------------

function simulate!( mut::QuasiSpeciesModel, initial_population::Vector{Float64}, total_time::Real)
	time_step = total_time / mut.time_steps;			# Full time-step
	half_time_step = time_step / 2;						# RK2 half time-step
	
	# Set up time scale and initial value of population:
	mut.timescale[:] = 0:time_step:total_time
	mut.population_trajectory[1] = initial_population / sum(initial_population)
	
	# Calculate population trajectory:
	for step = 1:mut.time_steps
		# Perform RK2 half-step:
		current_population  = mut.population_trajectory[step]
		R  = mut.fitness_values' * current_population
		half_step_population = current_population + half_time_step * (mut.mutation_matrix * (mut.fitness_values .* current_population) - R * current_population)

		# Perform RK2 full-step:
		R  = mut.fitness_values' * half_step_population
		mut.population_trajectory[step+1] = current_population + time_step * (mut.mutation_matrix * (mut.fitness_values .* half_step_population) - R * half_step_population)
	end
end


"""
	mutate!()

Simulate cyclic mutation and selection dynamics of 3 population types.
"""
function mutate!(CurrentPopulation::Vector{Float64},MutationRotationMatrix::Matrix{Float64},FitnessValues::Vector{Float64})
	mut = QuasiSpeciesModel( MutationRotationMatrix, FitnessValues)
	simulate!( mut, CurrentPopulation, 1.)
	sum(mut.population_trajectory)/10     # edit for field
end
end		# ... of module Mutators