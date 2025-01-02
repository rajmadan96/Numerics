"""
	PSO method: TestScript
	created: 2024, December
	author©: Rajmadan Lakshmanan
"""

using Test
include("PSO.jl")

function f1(x::Vector{Float64})::Vector{Float64}
	return x
end


function f2(x::Vector{Float64})::Vector{Float64}	# 3 dimensions
	return [x[1]; x[1]^2-x[2]; x[2]-x[3]^3]
end

function f3(x::Vector{Float64})::Vector{Float64}	# 3 dimensions
	return [x[1]-x[2]^2+3x[3]^2+10.3;
			(x[2]-3x[3])^3-x[2]-20;
			x[1]-x[3]^3-14.3]
end

function f4(x::Vector{Float64})::Vector{Float64}	# 4 dimensions
	return [x[1]; x[1]^2-x[2]; x[2]- x[3]^3+ x[4]^4; atan(x[4])]
end


function f5(x::Vector{Float64})::Vector{Float64}
	return [abs(x[1])^(1/3)+x[2]; x[1]^3-atan(x[2])]
end

function f6(x::Vector)
	[cos(x[1])-x[1]; sin(x[2]+x[1]^2)-3x[2]; x[3]-x[1]^2]
end

#	╭────────────────────────────────────────────────────────────────
#	│	PSO testscript
printstyled("\n\t══════════ Test PSO.jl ══════════\n"; bold= true, color= 4)
@testset "Test PSO" begin
	
	let tmp1= PSO(f1,rand(4))
	 	@test tmp1.xMin ≈ [0.0, 0, 0, 0] atol= 1e-5		# linear problem
	end
	
	let	tmp2= PSO(f2,rand(3))
		@test tmp2.xMin≈ [0.0, 0, 0] atol= 1e-2		# x³ at the solution
	end

	let	tmp3= PSO(f3, [3., 0.2, 7.3])
		@test tmp3.xMin≈ [14.713280, 5.165053, 0.744871] atol= 1e-4		# usual 4D function
	end

	let	tmp4= PSO(f4,rand(4); maxEval= 10000)
		@test tmp4.xMin≈ [0, 0.0, 0, 0] atol= 1e-2		# involves atan, thus many intermediary steps
	end

	let tmp5 = PSO(f5,rand(2); maxEval=10000)
		@test tmp5.xMin ≈ [0.0, 0.0] atol=1e-7
	end
	
	let	tmp6= PSO(f6,rand(3))
		@test tmp6.xMin≈ [0.7390851329315182, 0.23463546020718115, 0.54624683399294] atol= 0.001
	end
	
end
