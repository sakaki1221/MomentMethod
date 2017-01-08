include Math

x=700
gt_k2=0.07853396460668971

p  xcothx = x/tanh(x)
 p   xcothx = x*(exp(x)+exp(-x))/(exp(x)-exp(-x))
  p  xcothx2 = xcothx**2
p    xcothx3 = xcothx**3
p    xcothx4 = xcothx**4
p    xcothx5 = xcothx**5
    small_a1 = 1.0 + xcothx/2.0
    small_a2 = 13.0/3.0 + 47.0*xcothx/6.0 + 23.0*xcothx2/6.0 + xcothx3/2.0
    small_a3 = -(25.0/3.0 + 121.0*xcothx/6.0 + 50.0*xcothx2/3.0 + 16.0*xcothx3/3.0 + xcothx4/2.0)
    small_a4 = 43.0/3.0 + 93.0*xcothx/2.0 + 169.0*xcothx2/3.0 + 83.0*xcothx3/3.0 + 22.0*xcothx4/3.0 + xcothx5/2.0
    p large_a = small_a1 + small_a2*gt_k2**2 + small_a3*gt_k2**3 + small_a4*gt_k2**4

p exp(x)
p exp(-x)
