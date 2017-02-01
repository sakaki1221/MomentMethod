  require 'yaml'
  require 'gnuplot'
  include Math

module Potential_cu
  LATTICE=2.57162307160314e-10
  #LATTICE=2.57e-10
  MASS=63.5460
  def e_r(x)
    return -5.96026114143602*10**(-19)+1.23442838541439*10**(-12)*x+112.218057322094*(x-2.57162307160314*10**(-10))**2-1.75623086213742*10**12*(x-2.57162307160314*10**(-10))**3+1.77737068997001*10**22*(x-2.57162307160314*10**(-10))**4-2.02516305994660*10**32*(x-2.57162307160314*10**(-10))**5+2.50645257470012*10**42*(x-2.57162307160314*10**(-10))**6-4.31336880622327*10**51*(x-2.57162307160314*10**(-10))**7
  end
  def de2dr2(x)
    return 2934.25439712463-1.05373851728245*10**13*x+2.13284482796401*10**23*(x-2.57162307160314*10**(-10))**2-4.05032611989320*10**33*(x-2.57162307160314*10**(-10))**3+7.51935772410035*10**43*(x-2.57162307160314*10**(-10))**4-1.81161489861377*10**53*(x-2.57162307160314*10**(-10))**5
  end

  def de4dr4(x)
    return 6.67611622405331*10**24-2.43019567193592*10**34*x+9.02322926892042*10**44*(x-2.57162307160314*10**(-10))**2-3.62322979722754*10**54*(x-2.57162307160314*10**(-10))**3
  end
end

module Potential_ag
  LATTICE=2.94422938448347e-10
  MASS=107.8682
  def e_r(x)
    #a7
    return -4.53077266136435*10**(-19)+4.06517304843791*10**(-13)*x+83.1807916776768*(x-2.94422938448347*10**(-10))**2-1.36030005128436*10**12*(x-2.94422938448347*10**(-10))**3+1.31344285874641*10**22*(x-2.94422938448347*10**(-10))**4-1.18869318873115*10**32*(x-2.94422938448347*10**(-10))**5+3.66395968557818*10**42*(x-2.94422938448347*10**(-10))**6-6.46965793939468*10**52*(x-2.94422938448347*10**(-10))**7
  end
  def de2dr2(x)
    #a7
    return 2569.38281297882-8.16180030770616*10**12*x+1.57613143049569*10**23*(x-2.94422938448347*10**(-10))**2-2.37738637746230*10**33*(x-2.94422938448347*10**(-10))**3+1.09918790567346*10**44*(x-2.94422938448347*10**(-10))**4-2.71725633454577*10**54*(x-2.94422938448347*10**(-10))**5
  end

  def de4dr4(x)
    #a7
    return 4.51496878457627*10**24-1.42643182647738*10**34*x+1.31902548680815*10**45*(x-2.94422938448347*10**(-10))**2-5.43451266909152*10**55*(x-2.94422938448347*10**(-10))**3
  end
end

module Potential_au
  LATTICE=2.95108288440487e-10
  MASS=196.96654
  def e_r(x)
    #a7
    return -5.25017141092899*10**(-19)+2.93559888798504*10**(-12)*x+128.160505853292*(x-2.95108288440487*10**(-10))**2-2.20186375482671*10**12*(x-2.95108288440487*10**(-10))**3+2.15136942091036*10**22*(x-2.95108288440487*10**(-10))**4-1.10092243560573*10**32*(x-2.95108288440487*10**(-10))**5+4.95859067439561*10**41*(x-2.95108288440487*10**(-10))**6-1.01578974632316*10**52*(x-2.95108288440487*10**(-10))**7
  end
  def de2dr2(x)
    #a7
    return 4155.05047610291-1.32111825289603*10**13*x+2.58164330509243*10**23*(x-2.95108288440487*10**(-10))**2-2.20184487121146*10**33*(x-2.95108288440487*10**(-10))**3+1.48757720231868*10**43*(x-2.95108288440487*10**(-10))**4-4.26631693455727*10**53*(x-2.95108288440487*10**(-10))**5
  end
  def de4dr4(x)
    #a7
    return 4.41502468914656*10**24-1.32110692272688*10**34*x+1.78509264278242*10**44*(x-2.95108288440487*10**(-10))**2-8.53263386911456*10**54*(x-2.95108288440487*10**(-10))**3
  end
end

module Potential_al
  LATTICE=2.85652568198522e-10#vasp
  #LATTICE=2.86605939471180e-10#phonopy0K
  MASS=26.9815386
  def e_r(x)
    #a7
    return -6.00058652993607*10**(-19)-6.70506573349830*10**(-14)*x+70.6149467699625*(x-2.85652568198522*10**(-10))**2-8.99084711673650*10**11*(x-2.85652568198522*10**(-10))**3+6.28402410985784*10**21*(x-2.85652568198522*10**(-10))**4-4.60379464576560*10**31*(x-2.85652568198522*10**(-10))**5+6.66273667310745*10**41*(x-2.85652568198522*10**(-10))**6-8.24471021076823*10**51*(x-2.85652568198522*10**(-10))**7
    #a8
    #return -6.00028918511838*10**(-19)-1.68470117042399*10**(-13)*x+70.5517616581594*(x-2.85652568198522*10**(-10))**2-8.94778654105298*10**11*(x-2.85652568198522*10**(-10))**3+6.98593111070868*10**21*(x-2.85652568198522*10**(-10))**4-9.54208783693992*10**31*(x-2.85652568198522*10**(-10))**5-7.64794568922811*10**41*(x-2.85652568198522*10**(-10))**6+1.46536910627569*10**53*(x-2.85652568198522*10**(-10))**7-2.70603606295040*10**63*(x-2.85652568198522*10**(-10))**8
  end
  def de2dr2(x)
    #a7
    return 1682.18503504556-5.39450827004190*10**12*x+7.54082893182942*10**22*(x-2.85652568198522*10**(-10))**2-9.20758929153120*10**32*(x-2.85652568198522*10**(-10))**3+1.99882100193224*10**43*(x-2.85652568198522*10**(-10))**4-3.46277828852266*10**53*(x-2.85652568198522*10**(-10))**5
    #a8
    #return 1674.67844640269-5.36867192463178*10**12*x+8.38311733285041*10**22*(x-2.85652568198522*10**(-10))**2-1.90841756738798*10**33*(x-2.85652568198522*10**(-10))**3-2.29438370676844*10**43*(x-2.85652568198522*10**(-10))**4+6.15455024635788*10**54*(x-2.85652568198522*10**(-10))**5-1.51538019525222*10**65*(x-2.85652568198522*10**(-10))**6
    end

  def de4dr4(x)
    #a7
    return 1.72891949546245*10**24-5.52455357491872*10**33*x+2.39858520231869*10**44*(x-2.85652568198522*10**(-10))**2-6.92555657704532*10**54*(x-2.85652568198522*10**(-10))**3
    #8
    #return 3.43852862257432*10**24-1.14505054043279*10**34*x-2.75326044812213*10**44*(x-2.85652568198522*10**(-10))**2+1.23091004927158*10**56*(x-2.85652568198522*10**(-10))**3-4.54614058575666*10**66*(x-2.85652568198522*10**(-10))**4
  end
end

class FittingTest < MomentMethod
  include Potential_al #ここ変えないといけない
  BOLTZ2 = 1.38064852e-23
  PLANCK2 = 6.626e-34
  HBAR2 = PLANCK2/(2.0*PI)

  def initialize(structure)
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
    puts "Hi,e0test"
    @structure=structure
    puts "structure = #{@structure}"
    calc_moment
  end

  def check(*val)
    p val.join(", ")
  end

  def calc_moment
    p "start calc_moment"
    a0=LATTICE
    p "a0="
    check(a0)
=begin
    for i in 0..11
      temp = 100*(i-1)
      temp = 10 if i==1
      temp = 1 if i==0
      #1-100まで調査用
      #for i in 1..100
      #temp=i
=end
    for i in 0..60
      if i==0 then
        temp = 1e-20
      elsif i<11
        temp = i
      else
        temp = 20*(i-10)
      end
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
          #puts "a1, same, change"
          #check(a1, same, change)
          k = calc_k_fitting(a1)
          atom_mass = MASS/AVOGADO*1e-3#
          k/atom_mass
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
          #テストでゼロ点振動を入れてみる
          #p zeroenergy = ev_from_j(HBAR2*omega/2.0)
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
      puts "u0_ev, psi0_ev, psi_linear_ev, psi, psi_no_u0, large_a"
      check(u0_ev, psi0_ev, psi_linear_ev, psi, psi_no_u0,large_a)
      puts "\n"

    end
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
    p "gamma/k^2---------------------------------"
    @@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_g_k2[i]}" }
  end

  def calc_k_fitting(a1)
    k =de2dr2(a1)
    return k/3.0
  end

  def calc_gamma_fitting(a1)
    gamma = de4dr4(a1)/6.0
    return gamma/3.0
  end

  def calc_psi0_linear(x, theta)
    arg0 = 1.0 - exp(-2.0*x)
    return (theta*(x+log(arg0)))
  end




  def plot_k_gamma
    start=(LATTICE*1e11).to_i/10.0
    for num in 1..199
      a0= (start+num.to_f/1000)*1e-10
      @@data_a0 << a0
      @@data_k << de2dr2(a0)
      @@data_gamma << de4dr4(a0)/6.0
    end
    p @@data_temp
    p @@data_lattice
    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.xlabel "temp[K]"
        plot.ylabel "a0"
        plot.grid
        temp=@@data_temp
        lattice=@@data_lattice
        plot.data << Gnuplot::DataSet.new([temp,lattice]) do |ds|
          ds.with      = "lines"
          ds.linewidth = 2
        end
      end
    end

    Gnuplot.open do |gp|
      Gnuplot::Plot.new(gp) do |plot|
        plot.multiplot
        plot.size "0.5,0.5"
        plot.origin "0.0,0.5"
        plot.xlabel "temp[K]"
        plot.ylabel "a0"
        plot.grid
        temp=@@data_temp
        lattice=@@data_lattice

        plot.data << Gnuplot::DataSet.new([temp,lattice]) do |ds|
          ds.with      = "lines"
          ds.linewidth = 2
        end
      end
      Gnuplot::Plot.new(gp) do |plot|
        plot.multiplot
        plot.size "0.5,0.5"
        plot.origin "0.5,0.5"
        plot.xlabel "temp[K]"
        plot.ylabel "free energy[eV/atom]"
        plot.grid
        temp=@@data_temp
        energy=@@data_energy

        plot.data << Gnuplot::DataSet.new([temp,energy]) do |ds|
          ds.with      = "lines"
          ds.linewidth = 2
        end
      end
      Gnuplot::Plot.new(gp) do |plot|
        plot.multiplot
        plot.size "0.5,0.5"
        plot.origin "0.0,0.0"
        plot.xlabel "a0"
        plot.ylabel "k"
        plot.set "format x '%.2e'"
        plot.set "format y '%.2e'"
        plot.set "xtics 0, 5e-12"
        plot.grid
        plot.data << Gnuplot::DataSet.new([@@data_a0,@@data_k]) do |ds|
          ds.with      = "lines"
          ds.linewidth = 2
        end
      end
      Gnuplot::Plot.new(gp) do |plot|
        plot.multiplot
        plot.size "0.5,0.5"
        plot.origin "0.5,0.0"
        plot.xlabel "a0"
        plot.ylabel "gamma"
        plot.grid
        plot.data << Gnuplot::DataSet.new([@@data_a0,@@data_gamma]) do |ds|
          ds.with      = "lines"
          ds.linewidth = 2
        end
      end
    end
  end
end
