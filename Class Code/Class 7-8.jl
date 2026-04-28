"""
    countTransitions(s, n_states)

Count transitions in state sequence `s` and return
an n_states × n_states matrix of counts.
"""
function countTransitions(s, n_states)
    N = zeros(Int, n_states, n_states)   # Initialize count matrix
    for t in 2:length(s)
        N[s[t-1], s[t]] += 1            # Increment the (i,j) count
    end
    return N
end

s = [1, 1, 2, 1, 2, 2, 1]

N = zeros(Int, 2, 2)

#t = 2
s[1]
s[2]
N[s[1], s[2]] += 1 # N[1, 1] += 1   

# t = 3
s[2]
s[3]
N[s[2], s[3]] += 1 # N[1, 2

N = countTransitions(s, 2) # should return [2 3; 2 1]


sum(N, dims=2) # sum over the rows
sum(N, dims=1) # sum over the columns

sumNrows = sum(N, dims=2)

P_est = N ./ sumNrows # divide each row by its sum to get probabilities

#equivalent to 
P_est = zeros(2,2)
P_est[1, :] = N[1, :] ./sumNrows[1]
P_est[2, :] = N[2, :] ./sumNrows[2]



sample_sizes = [50, 200, 1000, 5000, 20000]
errors = zeros(length(sample_sizes))
for n in sample_sizes
    s_sim, _ = simulateMarkov(P, X̄, n)
    N_sim = countTransitions(s_sim, 2)
    P_est_sim = N_sim ./ sum(N_sim, dims=2)
    println("Sample size: $n")
    println("Estimated P:\n$P_est_sim\n")
    push!(errors, norm(P_est_sim - P)) # Store the error (norm of difference)
end





#### McCall

β = 0.95       # discount factor
S = 5         # number of possible wage offers
w̄ = LinRange(1., 10., S)   # wage offers
p = ones(S)/S  # equal probability of each wage
c = 3.

println(collect(w̄))

w̄ = collect(w̄)

V1 = zeros(S) # initialize value function guess
for j in 1:S
    V1[j] = max(w̄[j],c)
end

V1 = max.(w̄, c) # vectorized version of the above loop
using LinearAlgebra
Q1 = dot(p,V1) # expected value of a wage offer

#note different than
dot(p,w̄)

using LinearAlgebra
T = 4                                # number of periods the worker lives
S = length(w̄)                        # number of possible wages
V = zeros(T, S)                       # V[t,s] = value with t periods left, offer s
Q = zeros(T)                          # Q[t] = expected value of random offer

V[1, :] = max.(c, w̄)                 # base case: last period, just pick max
Q[1] = dot(p, V[1, :])               # expected value in last period

for t in 2:T                          # build up from t=2 to t=T
    Vaccept = w̄ + β*V[t-1, :]        # wage today + discounted continuation
    Vreject = c + β*Q[t-1]            # benefits today + discounted random offer
    V[t, :] = max.(Vaccept, Vreject)  # optimal choice for each wage
    Q[t] = dot(p, V[t, :])           # update expected value
end

function iterateBellman(V, Q, β, p, w̄, c)     # V, Q from next period
    V_accept = w̄ .+ β .* V                       # w̄[s] + β*V[s] for each wage s
    V_reject = c  + β  * Q                        # c + β*Q (same for all wages)
    V_new = max.(V_accept, V_reject)            # pick the better option
    Q_new = dot(p, V_new)                       # expected value of random offer
    C = V_accept .>= V_reject                   # 1 = accept, 0 = reject
    return (V=V_new, Q=Q_new, C=C)               # named tuple of results
end


t=3
iterateBellman(V[t-1,:],Q[t-1],β,p,w̄,c).V #This should give me V[t,:],Q[t]
#compare to
V[t,:]


#Same as the for loop above
for t in 2:T                          # build up from t=2 to t=T
    V[t,:],Q[t],C = iterateBellman(V[t-1,:],Q[t-1],β,p,w̄,c)
end
