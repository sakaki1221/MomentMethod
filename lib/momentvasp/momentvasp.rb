require 'yaml'
require 'gnuplot'
include Math
class MomentVASP < MomentMethod
  include Potcar
  BOLTZ2 = 1.38064852e-23
  PLANCK2 = 6.626e-34
  HBAR2 = PLANCK2/(2.0*PI)
  DIVIDE_NUM = 3 #修論では3次元から1次元で3で割っている

  def initialize()
    ###plotのために必要な変数
    @@data_temp=[]
    @@data_energy=[]
    @@data_energy_no_u0=[]
    @@data_lattice=[]
    @@data_k=[]
    @@data_gamma=[]
    @@data_a0=[]
    @@data_k2=[]
    @@data_gamma2=[]
    @@data_large_a=[]
    @@data_g_k2=[]
    ###
    puts "hello, momentvasp."
    calc_moment
  end

  def calc_moment
    p "start calc_moment"
    a0=LATTICE
    p "a0="
    p a0
#=begin
    for i in 0..11
      temp = 100*(i-1)
      temp = 10 if i==1
      temp = 1 if i==0
#=end
=begin
    for i in 0..60 #修論データの温度はこちら
      if i==0 then
        temp = 1e-20
      elsif i<11
        temp = i
      else
        temp = 20*(i-10)
      end
=end
      @@data_temp << temp
      #p "theta"
      theta = BOLTZ2*temp
      gap = Array.new(11){ Array.new(201) }
      aa1,aa2=[],[]
      aa1[0]=a0
      comp_gap = 0
      for change in 1..10 #width to displace
        for same in 1..200
          gap[change][same] = (same-1)*(10**(-(11+change))).to_f #start 1e-10
          aa1[change] = aa1[change-1] + gap[change][same]
          aa2[change] = aa1[change]*sqrt(2)
          a1, a2 = aa1[change], aa2[change]
          k = calc_k_fitting(a1)
          atom_mass = MASS/AVOGADO*1e-3#
          omega = sqrt(k/atom_mass)
          x = HBAR2*omega/(2.0*theta)
          gamma = calc_gamma_fitting(a1)
          gt_k2 = gamma*theta/k**2
          u0 = e_r(a1)
          psi0 = calc_psi0_linear(x,theta)*3#3倍しているのはy,z方向を考慮に入れるため
          large_a = calc_large_a_maple(x, gt_k2)
          y0 = calc_y0(k, gamma, theta, large_a)
          psi_linear = calc_psi_linear(k, x, gamma, theta)*3#3倍しているのはy,z方向を考慮に入れるため
          total_gap = comp_gap + gap[change][same]
          break if y0 - total_gap < 0
        end
        aa1[change] = aa1[change] - (10**(-(11+change))).to_f
        aa2[change] = aa1[change]*sqrt(2)
        comp_gap += gap[change][same-1]
        a1_cal = a0+comp_gap
        a2_cal = sqrt(2)*a1_cal
      end
      #ここから出力
      a1_cal = a1_cal*1.0e10
      a2_cal = a2_cal*1.0e10
      @@data_k2 << k
      @@data_gamma2 << gamma
      @@data_large_a << large_a
      @@data_g_k2 << gamma/k**2
      puts "T(K), a1, a2_cal(A), k, g="
      check(temp, a1_cal, a2_cal, k, gamma)
      puts "temp, u0, harmonic free, free="
      check(temp, u0, psi0, psi_linear)
      #eVに単位変換
      u0_ev = ev_from_j(u0)
      psi0_ev = ev_from_j(psi0)
      psi_linear_ev = ev_from_j(psi_linear)
      psi = u0_ev + psi0_ev + psi_linear_ev
      psi_no_u0 = psi0_ev + psi_linear_ev
      @@data_energy << psi
      @@data_energy_no_u0 << psi_no_u0
      @@data_lattice <<a1_cal
      puts "u0_ev, psi0_ev, psi_linear_ev, psi, psi_no_u0"
      check(u0_ev, psi0_ev, psi_linear_ev, psi, psi_no_u0)
      puts "\n"

    end
    #データ取り用
    #plot_k_gamma
    #a1-T出力
    #p "lattice-------------------------------------------"
    #@@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_lattice[i]}" }
    #p "coeff---------------------------------------------"
    #output_coeff_TE(@@data_temp, @@data_lattice,LATTICE)
    #p "free energy----------------------------------------"
    #@@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_energy[i]}" }
    #p "free energy no u0 ----------------------------------------"
    #@@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_energy_no_u0[i]}" }
    #p "k"
    #@@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_k2[i]}" }
    #p "gamma"
    #@@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_gamma2[i]}" }
    #p "large_a"
    #@@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_large_a[i]}" }
    #p "gamma/k^2---------------------------------"
    #@@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_g_k2[i]}" }
  end
  def calc_k_fitting(a1)
    k =de2dr2(a1)
    return k/DIVIDE_NUM
  end

  def calc_gamma_fitting(a1)
    gamma = de4dr4(a1)/6.0
    return gamma/DIVIDE_NUM
  end

  def calc_psi0_linear(x, theta)
    arg0 = 1.0 - exp(-2.0*x)
    return (theta*(x+log(arg0)))
  end
end
