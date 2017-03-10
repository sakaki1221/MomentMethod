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
    @@data_energy_no_u0=[]
    @@data_lattice=[]
    @@data_large_a=[]
    @@data_y0_large_a=[]
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
=begin
    for i in 0..10
      break if @@element=="Ag"&& i==9 #Agは800K以降計算できないから
      temp = 100*(i-1)
      temp = 10 if i==1
      temp = 1 if i==0
=end
    for i in 1..60
    #for i in 0..10#0K-10Kテスト用
      if i==0 then
        temp = 1e-20
      elsif i<11
        temp = i
      else
        temp = 20*(i-10)
      end
      break if @@element=="Cu"&& temp>960 #Agは800K以降計算できないから
      break if @@element=="Ag"&& temp>700 #Agは800K以降計算できないから
      @@data_temp << temp
      #p "theta"
      theta = BOLTZ2*temp
      gap = Array.new(11){ Array.new(201) }
      aa1,aa2=[],[]
      aa1[0]=a0
      comp_gap = 0
      for change in 1..10 #width to displace 精度上げてる
        for same in 1..200
          gap[change][same] = (same-1)*(10**(-(11+change))).to_f #start 1e-10
          aa1[change] = aa1[change-1] + gap[change][same]
          aa2[change] = aa1[change]*sqrt(2.0)
          a1, a2 = aa1[change], aa2[change]
          k = calc_k_noboltz(a1,a2,@structure)
          atom_mass = @@potential.atom_mass/AVOGADO*1e-3 #gをkgに変換
          k/atom_mass
          omega = sqrt(k/atom_mass)
          x = HBAR2*omega/(2.0*theta)
          gamma = calc_gamma_noboltz(a1,a2,@structure)
          gt_k2 = gamma*theta/k**2
          u0 = calc_u0_j(a1,a2)
          psi0 = calc_psi0(x,theta)
          large_a = calc_large_a_maple(x, gt_k2)
          y0 = calc_y0(k, gamma, theta, large_a)
          psi_nonli = calc_psi_nonli(k, x, gamma,theta) #nonlinear fcc thesis(1988)p516(19)
          total_gap = comp_gap + gap[change][same]
          break if y0 - total_gap < 0
        end
        #厳密には結果に表示される格子の長さとk,gammaの値は合わない．
        #これは，格子の長さはy0を越える前のもので，他のデータはy0を越えた後のものをプロットしてるから
        #ただ，値の差は無視できるほど小さいためこのままにしておく．
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
      psi_no_u0 = psi0_ev + psi_nonli_ev
      @@data_energy << psi
      @@data_energy_no_u0 << psi_no_u0
      @@data_lattice <<a1_cal
      @@data_y0_large_a << sqrt(large_a)
      puts "u0_ev, psi0_ev, psi_nonli_ev, psi,psi_no_u0"
      check(u0_ev, psi0_ev, psi_nonli_ev, psi,psi_no_u0)
      puts "\n"
    end
=begin
    #ここからデータプロット用
    p "lattice-------------------------------------------"
    @@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_lattice[i]}" }
    p "coeff---------------------------------------------"
    output_coeff_TE(@@data_temp, @@data_lattice,a0)
    p "free energy----------------------------------------"
    @@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_energy[i]}" }
    p "free energy no u0 ----------------------------------------"
    @@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_energy_no_u0[i]}" }
    p "sqrt(large_a) ----------------------------------------"
    @@data_temp.each_with_index {|tmp, i| puts "#{tmp} #{@@data_y0_large_a[i]}" }
    plot_y0_large_a
=end
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
    #ポテンシャルが1/2倍により調整
    @gamma1 = (1.0/24.0)*(diff_u4_a1 + diff_u4_a2)
    @gamma2 = (6.0/24.0)*(diff_x2y2_a1 + diff_x2y2_a2)
    testgamma1 = 4.0/3.0*@@potential.de4dr4(a1)+4.0*@@potential.de3dr3(a1)/a1+2.0*@@potential.de2dr2(a1)/(a1*a1)-2.0*@@potential.dedr(a1)/(a1*a1*a1)
    testgamma2= 1.0/3.0*@@potential.de4dr4(a2)+4.0*@@potential.de3dr3(a2)/a2-4.0*@@potential.de2dr2(a2)/(a2*a2)+4.0*@@potential.dedr(a2)/(a2*a2*a2)
    #return gamma = testgamma1+testgamma2
    return gamma = 4.0*(@gamma1+@gamma2)#p516(18)
  end
  def calc_u0_j(a1,a2)#もとのcalc_u0の２倍したもの
    z1=12
    z2=6
    return u0 = z1*@@potential.energy(a1) + z2*@@potential.energy(a2)
  end
  def plot_y0_large_a
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        #       plot.set "term aqua size 800, 800"
        #  plot.terminal "png enhanced"
        #        plot.multiplot
        #        plot.size "0.33,0.5"
        #        plot.origin "0.0,0.5"
        #plot.set "output 'energy_#{@@element}.png'"
        #    plot.output "energy.eps"
        #plot.title  "#{@@element}--#{@@temp}-large_a"
        plot.set "term aqua size 450, 400"
        plot.ylabel ' '
        plot.xlabel 'Temperature[K]'
        #plot.set "format x '%.2e'"
        #plot.set "format y '%.1e'"
        #plot.set "xtics 2.52, 0.02, 2.6"
        plot.set "xtics font 'times,15'"
        plot.set "ytics font 'times,15'"
        #plot.set "xtics 5e-12"
        plot.set "xrange [0:200]"
        #plot.set "yrange [4.0e-13:7.8e-13]"
        plot.set "xlabel font 'times,18'"
        plot.set "ylabel font 'times,18'"
        plot.data << Gnuplot::DataSet.new( [@@data_temp, @@data_y0_large_a] ) do |ds|
          ds.with = "lines"
          #ds.title = "large_a"
          ds.notitle
          ds.with = "lp pt 2 lw 2 ps 2"
        end
      end
    end
  end
end
