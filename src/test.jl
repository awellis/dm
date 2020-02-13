function fpt()
  mu::Float64=1.0
  bound::Float64=1.0
  dt::Float64=0.01
  tmax::Float64=4

  g1=Array{Float64}(undef,400)
  g2=Array{Float64}(undef,400)
  
  err=ccall((:fpt,"./ddm_fpt_lib"),Cint,(Cdouble,Cdouble,Cdouble,Cdouble,Ptr{Cdouble},Ptr{Cdouble}),mu,bound,dt,tmax,g1,g2)

  return g1,g2
end

function rand_asym()
  mu::Float64=1.0
  bound_lo::Float64=-1.5
  bound_hi::Float64=1.0
  dt_rand::Float64=0.001
  n::Int32=10000
  seed::Int32=0

  t=Array{Float64}(undef,n)
  bound_cond=Array{Int32}(undef,n)
  
  err=ccall((:rand_asym,"./ddm_fpt_lib"),Cint,(Cdouble,Cdouble,Cdouble,Cdouble,Cint,Cint,Ptr{Cdouble},Ptr{Cint}),
            mu,bound_lo,bound_hi,dt_rand,n,seed,t,bound_cond)

  return t,bound_cond
end
