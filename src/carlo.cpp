#include "../src/ddm_fpt_lib.h"
extern "C" 
{
  int fpt(double mu,double bound,const double dt,const double tmax,double *g1,double *g2)
  {
    ExtArray e_mu(ExtArray::shared_noowner(&mu),1),e_bound(ExtArray::shared_noowner(&bound),1);
    int n_max=(int)ceil(tmax/dt);
    DMBase *dm=DMBase::create(e_mu,e_bound,dt);
    ExtArray e_g1(ExtArray::shared_noowner(g1),n_max),e_g2(ExtArray::shared_noowner(g2),n_max);

    dm->pdfseq(n_max,e_g1,e_g2);
    delete dm;

    return 0;
  }
  
  int rand_asym(double mu,double bound_lo,double bound_hi,const double dt_rand,const int n,const int seed,double *t,int *bound_cond)
  {
    ExtArray e_mu(ExtArray::shared_noowner(&mu),1),
      e_bound_lo(ExtArray::shared_noowner(&bound_lo),1),
      e_bound_hi(ExtArray::shared_noowner(&bound_hi),1);
    
    DMBase *dm=DMBase::create(mu,ExtArray::const_array(1.0),e_bound_lo,e_bound_hi,
			      ExtArray::const_array(0.0),ExtArray::const_array(0.0),dt_rand);

    DMBase::rngeng_t rngeng;
    rngeng.seed(seed);

    int i;
    
    for(i=0;i<n;i++)
    {
      DMSample s=dm->rand(rngeng);
      t[i]=s.t();
      bound_cond[i]=s.upper_bound() ? 1 : 0;
    }

    delete dm;

    return 0;
  }  
}

  
