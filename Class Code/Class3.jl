a = 4


f = x -> a*x

f(1)


function getPrimes(n)
    primes = Int[]
    for i in 2:n
        isprime = true
        for p in primes
            if i%p == 0
                isprime = false
            end
        end
        if isprime
            push!(primes, i)
        end
    end
    return primes
end


function divide(a, b)
    quotient = a ÷ b    # integer division
    remainder = a % b
    return (quotient=quotient, remainder=remainder)
end

"""
    square(x)

Return the square of `x`.
"""
function square(x)
    return x^2
end

x = 5.0
ρ = 0.8
print(ρ * x + randn())



T = 10
ρ = 0.8

x = zeros(T) # pre-allocate array of zeros
x[1] = 5.0  # set initial condition

# simulate using a for loop
for t in 2:T
    x[t] = ρ * x[t-1] + randn() #update using previous period's value
end
@show x 

#or unrolled
x[1] = 5.0
x[2] = ρ * x[1] + randn() # t= 2
x[3] = ρ * x[2] + randn() # t= 3
x[4] = ρ * x[3] + randn() # t= 4
x[5] = ρ * x[4] + randn() # t= 5
x[6] = ρ * x[5] + randn() # t= 6
x[7] = ρ * x[6] + randn() # t= 7
x[8] = ρ * x[7] + randn() # t= 8
x[9] = ρ * x[8] + randn() # t= 9
x[10] = ρ * x[9] + randn() # t= 10


using Plots
p = plot(x)
p = scatter(x, xlabel="Time")
xlabel!(p,"Time")
ylabel!("x")
title!("Simulated AR(1) Process")
savefig("simulated_ar1.pdf")


"""
    simulateAR1(x0, T, ρ=0.8)

Simulate `T` periods of the AR(1) process xₜ = ρ*xₜ₋₁ + εₜ.
"""
function simulateAR1(x0, T, ρ=0.8)
    x = zeros(T) #pre-allocate array using T
    x[1] = x0 #set initial condition
   
    for t in 2:T #for loop to update
        x[t] = ρ * x[t-1] + randn()
    end
    return x #return the array
end


"""
    simulateAR1(x0, T, ρ=0.8)

Simulate `T` periods of the AR(1) process xₜ = ρ*xₜ₋₁ + εₜ.
"""
function simulateAR1(x0, T, ρ=0.8)
    x = zeros(T) #pre-allocate array using T
    x[1] = x0 #set initial condition
   
    for t in 1:T-1 #for loop to update
        x[t+1] = ρ * x[t] + randn()
    end
    return x #return the array
end


using NonlinearSolve

fun(u,p) = [u[1]^2 - p]

fun(1.41,2)

prob = NonlinearProblem(fun, [-1.0], 2.0)

sol = solve(prob)

using NonlinearSolve