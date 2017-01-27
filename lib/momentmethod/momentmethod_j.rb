require 'yaml'
require 'gnuplot'
include Math

class MomentMethodJ < MomentMethod
  BOLTZ2 = 1.38064852e-23
  PLANCK2 = 6.626e-34
  HBAR2 = PLANCK2/(2.0*PI)

  def initialize(structure)
    ###plotのために必要な変数
    @@data_temp=[]
    @@data_energy=[]
    @@data_lattice=[]
    ###
    puts "Hi,momentmethod_j"
    @structure=structure
    puts "structure = #{@structure}"
      select
    calc_moment_j
  end

  def calc_moment_j
    p "start calc_moment_j"
    a0 = calc_a0(@@potential.m, @@potential.n, @@potential.r0)
    #a0 =2.50e-8
    p "a0="
    check(a0)
    for i in 0..10
      break if @@element=="Ag"&& i==9 #Agは800K以降計算できないから
      temp = 100*(i-1)
      temp = 10 if i==1
      temp = 1 if i==0
      @@data_temp << temp
      #p "theta"
      theta = BOLTZ2*temp
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
          #puts "a1, same, change"
          #check(a1, same, change)
          k = calc_k_noboltz(a1,a2,@structure)
          atom_mass = @@potential.atom_mass/AVOGADO*1e-3
          k/atom_mass
          omega = sqrt(k/atom_mass)
          x = HBAR2*omega/(2.0*theta)
          gamma = calc_gamma_noboltz(a1,a2,@structure)
          gt_k2 = gamma*theta/k**2
          u0 = calc_u0_j(a1,a2)
          psi0 = calc_psi0(x,theta)
          large_a = calc_large_a_maple(x, gt_k2)
          y0 = calc_y0(k, gamma, theta, large_a)
          case @structure
          when "fitting_test","vasp"
            psi_nonli = calc_psi_linear(k, x, gamma, theta)#とりあえず変数はそのままnonli
          else
            psi_nonli = calc_psi_nonli(k, x, gamma,theta) #nonlinear fcc thesis(1988)p516(19)
          end
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
  end
  def calc_k_noboltz(a1,a2,structure)#ボルツマン定数かけてないk
    k = 2.0*@@potential.de2dr2(a1) + 4.0*@@potential.dedr(a1)/a1 + @@potential.de2dr2(a2) + 2.0*@@potential.dedr(a2)/a2;
    return k*2#1原子あたりのポテンシャルだから
  end
  def calc_gamma_noboltz(a1,a2,structure)
    case structure
    when "jindofcc"
      diff_u4_a1 = 2.0*@@potential.de4dr4(a1) + 12.0*@@potential.de3dr3(a1)/a1 - 42.0*@@potential.de2dr2(a1)/(a1*a1) + 42.0*@@potential.dedr(a1)/(a1*a1*a1)
      diff_u4_a2 = 2.0*@@potential.de4dr4(a2) + 12.0*@@potential.de2dr2(a2)/(a2*a2) - 12.0*@@potential.dedr(a2)/(a2*a2*a2)
      diff_x2y2_a1 = @@potential.de4dr4(a1) + 2.0*@@potential.de3dr3(a1)/a1 - 8.0*@@potential.de2dr2(a1)/(a1*a1) + 8.0*@@potential.dedr(a1)/(a1*a1*a1)
      diff_x2y2_a2 = 4.0*@@potential.de3dr3(a2)/a2 - 11.0*@@potential.de2dr2(a2)/(a2*a2) + 11.0*@@potential.dedr(a2)/(a2*a2*a2)
    when "sakakifcc"
      diff_u4_a1 = 2.0*@@potential.de4dr4(a1) + 12.0*@@potential.de3dr3(a1)/a1 - 6.0*@@potential.de2dr2(a1)/(a1*a1) + 6.0*@@potential.dedr(a1)/(a1*a1*a1)
      diff_u4_a2 = 2.0*@@potential.de4dr4(a2) + 12.0*@@potential.de2dr2(a2)/(a2*a2) - 12.0*@@potential.dedr(a2)/(a2*a2*a2)
      diff_x2y2_a1 = @@potential.de4dr4(a1) + 2.0*@@potential.de3dr3(a1)/a1 + 3.0*@@potential.de2dr2(a1)/(a1*a1) - 3.0*@@potential.dedr(a1)/(a1*a1*a1)
      diff_x2y2_a2 = 4.0*@@potential.de3dr3(a2)/a2 - 6.0*@@potential.de2dr2(a2)/(a2*a2) + 6.0*@@potential.dedr(a2)/(a2*a2*a2)
    else
      p "*******************missed structure**********************"
      exit(0)
    end
    @gamma1 = (1.0/48)*(diff_u4_a1 + diff_u4_a2)
    @gamma2 = (6.0/48)*(diff_x2y2_a1 + diff_x2y2_a2)
    testgamma1 = 4.0/3.0*@@potential.de4dr4(a1)+4.0*@@potential.de3dr3(a1)/a1+2.0*@@potential.de2dr2(a1)/(a1*a1)-2.0*@@potential.dedr(a1)/(a1*a1*a1)
    testgamma2= 1.0/3.0*@@potential.de4dr4(a2)+4.0*@@potential.de3dr3(a2)/a2-4.0*@@potential.de2dr2(a2)/(a2*a2)+4.0*@@potential.dedr(a2)/(a2*a2*a2)
    #return gamma = testgamma1+testgamma2
    return gamma = 8.0*(@gamma1+@gamma2)#p516(18)
  end
  def calc_u0_j(a1,a2)#もとのcalc_u0の２倍したもの
    z1=12
    z2=6
    return u0 = z1*@@potential.energy(a1) + z2*@@potential.energy(a2)
  end
end
