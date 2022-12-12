"""
    Dominicators 

        Module that displays 


"""

module Dominicators

    import GLMakie

    struct Dominicator 

        A::Matrix{Real}				# Interaction game payoff matrix
	    resolution::Int				# Resolution of timescale
	    t::Vector{Float64}			# Timescale
	    x::Vector{Vector{Float64}}	# Time-series of three population types


        function Dominicator(A::Matrix)
            ngenerations = 1000
		    new(
		    	A, ngenerations,
		    	zeros(Float64,ngenerations+1),
		    	Vector{Vector{Float64}}(undef,ngenerations+1)
		    )
        end 
    end

    function simulate!( Domini::Dominicator, x0::Vector{Float64}, T::Real)
        dt = T/Domini.resolution;		# Full time-step
        dt2 = dt/2;						# RK2 half time-step
        
        # Set up time scale and initial value of population:
        Domini.t[:] = 0:dt:T
        Domini.x[1] = x0 / sum(x0)
        
        # Calculate population trajectory:
        for step = 1:Domini.resolution
            # Perform RK2 half-step:
            x  = Domini.x[step]
            R  = x' * Domini.A * x
            xh = x + dt2 * x .* (Domini.A*x .- R)
    
            # Perform RK2 full-step:
            R  = xh' * Domini.A * xh
            Domini.x[step+1] = x + dt * xh .* (Domini.A*xh .- R)
        end
    end

    """
	unittest()
Use replicator dynamics to simulate cyclic dominance in 3 rock-scissors-paper population types.
"""
function unittest()
	println("\n============ Unit test Interactors: ===============")

	# Define RSP payoff matrix:
	Arsp = [
			 0  1 -1
			-1  0  1
			 1 -1  0
		]

	# Define lizard payoff matrix:
	Aliz = [
			4 2 1
			3 1 3
			5 0 2
		]

	# Set up plot:
	fig = Figure()
	ax1 = Axis(fig[1,1])
	ax2 = Axis(fig[1,2])
	
	# RSP:
	intrctr = Interactor( Float64.(Arsp))
	simulate!( intrctr, [20.,10.,1.], 15)
	plot3!(ax1,intrctr)
	
	# Lizard:
	intrctr = Interactor( Float64.(Aliz))
	simulate!( intrctr, [20.,10.,1.], 15)
	plot3!(ax2,intrctr).parent

end


