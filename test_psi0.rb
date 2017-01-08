include Math
  def calc_psi0(x, theta)
    arg0 = 1.0 - exp(-2.0*x)
    return psai0 = 3.0*theta*(x+log(arg0))
  end

x_vasp=1.3439269141784942e-12
theta_vasp=1.2425836679999999e-20
x=0.1343926914174239
theta=1.242583668e-13

p arg0 = 1.0 - exp(-2.0*x)
p arg0_vasp = 1.0 - exp(-2.0*x_vasp)
p log(arg0)
p log(arg0_vasp)
p x+log(arg0)
p x+log(arg0_vasp)
