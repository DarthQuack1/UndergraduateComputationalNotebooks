using Optim,Plots

f = x -> (x-3)^2 + 1

plot(f,0,6)

result = optimize(f, 0.0, 6.0)

result.minimizer
result.minimum


function neg_profit(L; A=1.0, K̄=10.0, α=1/3, p=10.0, w=5.0)
    Y = A * K̄^α * L^(1-α)
    return -(p * Y - w * L)          # negate for minimization
end

result = optimize(neg_profit, 0.1, 1000.0)
L_star = Optim.minimizer(result)
println("Optimal labor: $(round(L_star, digits=2))")
println("Maximum profit: $(round(-Optim.minimum(result), digits=2))")

plot(neg_profit, 0.1, 50)

vline!([L_star], label="Optimal Labor", color=:red, linestyle=:dash)


function f_multi(x)
    return (x[1]-3)^2 + (x[2]+2)^2 + 1
end

f_multi([3.0, -2.0]) # should be 1

result_multi = optimize(f_multi, [0.0, 0.0])

result_multi.minimizer


### Linear Algebra

x= [1.,3.]

2*x

y = [2., 4.]

xy = x .* y
# same as

[1. * 2., 3. * 4.]

using LinearAlgebra
x = [1.,1.]
y = [-1,1.]
dot(x,y) # should be 0



A = [1. 2. ;
     3. 4. ]
A'

A = [1. 2. 3. ;
     4. 5. 6. ]
A'


A = [1. 2.;
     3. 4. ]

A_inv = inv(A)

A_inv * y 