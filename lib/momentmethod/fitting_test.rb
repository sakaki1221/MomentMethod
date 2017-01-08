require 'yaml'
require 'gnuplot'
include Math

module Potential_cu
  LATTICE=2.5713342796904244e-10
  MASS=63.5460
  def e_r(x)
    #a7
    return -5.927815923*10**(-19)-1.264485242*10**(-11)*x+113.2571889*(x-2.5713342796904244*10**(-10))**2-1.731822699*10**12*(x-2.5713342796904244*10**(-10))**3+1.460574702*10**22*(x-2.5713342796904244*10**(-10))**4-2.591057536*10**32*(x-2.5713342796904244*10**(-10))**5+9.908485395*10**42*(x-2.5713342796904244*10**(-10))**6-1.292303247*10**53*(x-2.5713342796904244*10**(-10))**7
  end
  def de2dr2(x)
    #return -1.755563006*10**32*x**3+3.392100231*10**22*x**2+5.985033020*10**12*x-563.3971450
    #a6
    #return  3081.718546-1.110796691*10**13*x+1.685778480*10**23*(x-2.571365343*10**(-10))**2+1.419810884*10**33*(x-2.571365343*10**(-10))**3+4.858076385*10**44*(x-2.571365343*10**(-10))**4
    #a7
    #return 3148.124946-1.136622349*10**13*x+1.686800549*10**23*(x-2.571365343*10**(-10))**2+1.238303146*10**34*(x-2.571365343*10**(-10))**3+4.845517536*10**44*(x-2.571365343*10**(-10))**4-8.083436424*10**55*(x-2.571365343*10**(-10))**5
    #accurate a6
    #return 2916.227311-1.046114230*10**13*x+1.930143533*10**23*(x-2.5713342796904244*10**(-10))**2-4.607000236*10**33*(x-2.5713342796904244*10**(-10))**3+1.227996084*10**44*(x-2.5713342796904244*10**(-10))**4
    #accirate
    return 2898.371422-1.039093619*10**13*x+1.752689642*10**23*(x-2.5713342796904244*10**(-10))**2-5.182115072*10**33*(x-2.5713342796904244*10**(-10))**3+2.972545618*10**44*(x-2.5713342796904244*10**(-10))**4-5.427673637*10**54*(x-2.5713342796904244*10**(-10))**5
  end

  def de4dr4(x)#fitting　a0-a6まで
    #return 1.491752018*10**43*x**2-3.842677552*10**33*x+3.376180078*10**22
    #a6
    #return -1.853355804*10**24+8.518865304*10**33*x+5.829691662*10**45*(x-2.571365343*10**(-10))**2
    #a7
    #return -1.876741865*10**25+7.429818876*10**34*x+5.814621042*10**45*(x-2.571365343*10**(-10))**2-1.616687285*10**57*(x-2.571365343*10**(-10))**3
    #accurate a6
    #return 7.493711289*10**24-2.764200142*10**34*x+1.473595301*10**45*(x-2.5713342796904244*10**(-10))**2
    #accurate a7
    return 8.345508007*10**24-3.109269044*10**34*x+3.567054741*10**45*(x-2.5713342796904244*10**(-10))**2-1.085534727*10**56*(x-2.5713342796904244*10**(-10))**3
  end
end

module Potential_ag
  LATTICE=2.943844474684869e-10
  MASS=107.8682
  def e_r(x)
    #a7
    return -4.508176447*10**(-19)-8.472644537*10**(-12)*x+83.48728005*(x-2.943844474684869*10**(-10))**2-1.283392655*10**12*(x-2.943844474684869*10**(-10))**3+1.320249169*10**22*(x-2.943844474684869*10**(-10))**4-2.981714359*10**32*(x-2.943844474684869*10**(-10))**5+6.097575827*10**42*(x-2.943844474684869*10**(-10))**6-3.296812231*10**52*(x-2.943844474684869*10**(-10))**7
  end
  def de2dr2(x)
    #a7
    return 2433.839586-7.700355930*10**12*x+1.584299003*10**23*(x-2.943844474684869*10**(-10))**2-5.963428720*10**33*(x-2.943844474684869*10**(-10))**3+1.829272748*10**44*(x-2.943844474684869*10**(-10))**4-1.384661137*10**54*(x-2.943844474684869*10**(-10))**5
  end

  def de4dr4(x)
    #a7
    return 1.085010381*10**25-3.578057232*10**34*x+2.195127298*10**45*(x-2.943844474684869*10**(-10))**2-2.769322274*10**55*(x-2.943844474684869*10**(-10))**3
  end
end

module Potential_au
  LATTICE=2.9506518770140278e-10
  MASS=196.96654
  def e_r(x)
    #a7
    return -5.199063986*10**(-19)-1.470715019*10**(-11)*x+127.8427308*(x-2.9506518770140278*10**(-10))**2-2.113917847*10**12*(x-2.9506518770140278*10**(-10))**3+2.367818982*10**22*(x-2.9506518770140278*10**(-10))**4-3.252871937*10**32*(x-2.9506518770140278*10**(-10))**5+3.867303481*10**41*(x-2.9506518770140278*10**(-10))**6+7.800792251*10**52*(x-2.9506518770140278*10**(-10))**7
  end
  def de2dr2(x)
    #a7
    return 3998.146860-1.268350708*10**13*x+2.841382778*10**23*(x-2.9506518770140278*10**(-10))**2-6.505743872*10**33*(x-2.9506518770140278*10**(-10))**3+1.160191044*10**43*(x-2.9506518770140278*10**(-10))**4+3.276332746*10**54*(x-2.9506518770140278*10**(-10))**5
  end

  def de4dr4(x)
    #a7
    return 1.208598778*10**25-3.903446324*10**34*x+1.392229253*10**44*(x-2.9506518770140278*10**(-10))**2+6.552665492*10**55*(x-2.9506518770140278*10**(-10))**3
  end
end

module Potential_al
  LATTICE=2.8548067117232896e-10
  MASS=26.9815386
  def e_r(x)
    #a7
    return -5.954241574*10**(-19)-1.481716173*10**(-11)*x+69.82455844*(x-2.8548067117232896*10**(-10))**2-9.634608277*10**11*(x-2.8548067117232896*10**(-10))**3+1.016459325*10**22*(x-2.8548067117232896*10**(-10))**4-6.746972685*10**29*(x-2.8548067117232896*10**(-10))**5-7.251538618*10**42*(x-2.8548067117232896*10**(-10))**6+1.469426114*10**53*(x-2.8548067117232896*10**(-10))**7
  end
  def de2dr2(x)
    #a7
    return 1789.945780-5.780764966*10**12*x+1.219751190*10**23*(x-2.8548067117232896*10**(-10))**2-1.349394537*10**31*(x-2.8548067117232896*10**(-10))**3-2.175461586*10**44*(x-2.8548067117232896*10**(-10))**4+6.171589680*10**54*(x-2.8548067117232896*10**(-10))**5
  end

  def de4dr4(x)
    #a7
    return 2.670638015*10**23-8.096367222*10**31*x-2.610553903*10**45*(x-2.8548067117232896*10**(-10))**2+1.234317936*10**56*(x-2.8548067117232896*10**(-10))**3
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
    @@data_lattice=[]
    @@data_k=[]
    @@data_gamma=[]
    @@data_a0=[]
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
    for i in 0..11
      temp = 100*(i-1)
      temp = 10 if i==1
      temp = 1 if i==0
      @@data_temp << temp
      p "theta"
      p theta = BOLTZ2*temp
      gap = Array.new(6){ Array.new(201) }
      aa1,aa2=[],[]
      aa1[0]=a0
      comp_gap = 0
      for change in 1..5 #width to displace
        for same in 1..200
          gap[change][same] = (same-1)*(10**(-(11+change))).to_f #start 1e-10
          aa1[change] = aa1[change-1] + gap[change][same]
          aa2[change] = aa1[change]*sqrt(2)
          a1, a2 = aa1[change], aa2[change]
          puts "a1, same, change"
          check(a1, same, change)
          k = calc_k_fitting(a1,a2,@structure)
          atom_mass = MASS/AVOGADO*1e-3#
          k/atom_mass
          omega = sqrt(k/atom_mass)
          x = HBAR2*omega/(2.0*theta)
          gamma = calc_gamma_noBOLTZ(a1,a2,@structure)*10
          gt_k2 = gamma*theta/k**2
          u0 = e_r(a1)
          psi0 = calc_psi0_vasp(x,theta)
          large_a = calc_large_a(x, gt_k2)
          y0 = calc_y0(k, gamma, theta, large_a)
          psi_nonli = calc_psi_linear(k, x, gamma, theta)#線形結合の場合
          total_gap = comp_gap + gap[change][same]
          #テストでゼロ点振動を入れてみる
          p zeroenergy = ev_from_j(HBAR2*omega/2.0)
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
      puts "T(K), a1, a2_cal(A), k, g="
      check(temp, a1_cal, a2_cal, k, gamma)
      puts "temp, u0, harmonic free, free="
      check(temp, u0, psi0, psi_nonli)
      #eVに単位変換
      u0_ev = ev_from_j(u0)
      psi0_ev = ev_from_j(psi0)
      psi_nonli_ev = ev_from_j(psi_nonli)
      psi = u0_ev + psi0_ev + psi_nonli_ev
      @@data_energy << psi
      @@data_lattice <<a1_cal
      puts "u0_ev, psi0_ev, psi_nonli_ev, psi, large_a"
      check(u0_ev, psi0_ev, psi_nonli_ev, psi, large_a)
      puts "\n"

    end
    plot_k_gamma
  end

  def calc_k_fitting(a1,a2,structure)
    case structure
    when "fitting_test"
      k = (5.692097474e6-2.141523420e14*a1+5.413711083e22*(a1-2.512603723e-8)**2-2.352757090e30*(a1-2.512603723e-8)**3)
    when "vasp"
      #0番目のポテンシャルのみだから1/2倍しないでいい．とりあえずevからergに変換しとく
      a1=a1*1e10
      k = (192.3313091-69.33663132*a1+135.4613676*(a1-2.5713342796904244)**2+88.20445888*(a1-2.5713342796904244)**3)*1.60218e-12
    else
      k =de2dr2(a1)
    end
    return k
  end



  def calc_gamma_noBOLTZ(a1,a2,structure)
    @gamma1 = (1.0/48)
    @gamma2 = (6.0/48)
    #return gamma = 4.0*(@gamma1+@gamma2)#p516(18)
    #return 4*@gamma1
    return gamma = de4dr4(a1)/6
  end
  def calc_psi0_vasp(x, theta)
    arg0 = 1.0 - exp(-2.0*x)
    return psai0 = theta*(x+log(arg0))
  end


  def plot_k_gamma
    p start=(LATTICE*1e11).to_i/10.0
    for num in 1..199
      a0= (start+num.to_f/1000)*1e-10
      @@data_a0 << a0
      @@data_k << de2dr2(a0)
      @@data_gamma << de4dr4(a0)/6.0
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
