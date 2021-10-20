# adapted from https://diffeq.sciml.ai/stable/tutorials/ode_example/
println("select this line and press alt+enter to run it")
# this is a comment

♫ = true # unicode is fun
¬ = !
¬true


##
println("shift+enter runs a block of code between '##' symbols")
##

println("...but only one block at a time")


## load packages, may take a while
using GLMakie, OrdinaryDiffEq, Interpolations




function nonlinearode!(du, u, p, t)
    θ,ω = u
    kθ,kω,θd,ωd = p
    du[1] = ω
    du[2] = sin(θ) + kθ*(θd(t)-θ) + kω*(ωd(t)-ω)
end

##
# trivial case
θ₀ = 0.01                           # initial angular deflection [rad]
ω₀ = 0.0                            # initial angular velocity [rad/s]
u₀ = [θ₀, ω₀]                       # initial state vector
tspan = (0.0,10.0)


tx = tspan[1]:0.001:tspan[2]        # timespan for θx and ωx
θx = zeros(length(tx))              # trivial case: both equal zero (steady-state)
ωx = zeros(length(tx))              # trivial case: both equal zero (steady-state)

θx = sin.(tx);
ωx = cos.(tx);

θd = LinearInterpolation(tx, θx)
ωd = LinearInterpolation(tx, ωx)
# now, can do things like θd(t)

##
kθ = 2
kω = 1
p = (kθ,kω,θd,ωd)
prob = ODEProblem(nonlinearode!,u₀,tspan,p)
sol = solve(prob, Tsit5())

##
τ = sol.t
θ = [u[1] for u in sol.u]
ω = [u[2] for u in sol.u]

lines(τ, θ)
##
function linearode!(du, u, p, t)
end