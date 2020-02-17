function fpt(mu::Float64, bound::Float64, Δt::Float64, tmax::Float64)
  # mu::Float64=1.0
  # bound::Float64=1.0
  # dt::Float64=0.01
  # tmax::Float64=4

  nsteps = Int(tmax/Δt)
  g1 = Array{Float64}(undef, nsteps)
  g2 = Array{Float64}(undef, nsteps)

  err = ccall((:fpt, "./ddm_fpt_lib"),
                Cint, (Cdouble, Cdouble, Cdouble, Cdouble, Ptr{Cdouble}, Ptr{Cdouble}),
                mu, bound, Δt, tmax, g1, g2)

  return g1, g2
end


function rand_asym(mu::Float64, bound_lo::Float64, bound_hi::Float64, Δt_rand::Float64, n::Int, seed::Int)
  # mu::Float64=1.0
  # bound_lo::Float64=-1.5
  # bound_hi::Float64=1.0
  # dt_rand::Float64=0.001
  # n::Int32=10000
  # seed::Int32=0

  t = Array{Float64}(undef,n)
  bound_cond = Array{Int}(undef,n)

  err=ccall((:rand_asym,"./ddm_fpt_lib"),Cint,(Cdouble,Cdouble,Cdouble,Cdouble,Cint,Cint,Ptr{Cdouble},Ptr{Cint}),
            mu,bound_lo,bound_hi, Δt_rand, n, seed, t, bound_cond)

  return t, bound_cond
end


# mu::Float64=1.0
# bound::Float64=1.0
# dt::Float64=0.01
# tmax::Float64=4

# bound_lo::Float64=-1.5
# bound_hi::Float64=1.0
# Δt_rand::Float64=0.001
# n::Int=10000
# seed::Int=0


g1, g2 = fpt(1.0, 1.0, 0.01, 10.0)
rt, choice = rand_asym(1.0, 1.5, 1.0, 0.01, 1, 123)