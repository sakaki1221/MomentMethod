require 'yaml'
require 'gnuplot'
include Math

class PlotData < MomentMethod

  def initialize
    @@a1=[]
    @@k=[]
    @@gamma_jindo=[]
    @@gamma=[]
    @@large_a=[]
    @@large_a_maple=[]
    @@y0=[]
    @@y0_jindo=[]
    @@y0_jindo_maple=[]
    @@y0_maple=[]
    p "Im PlotData"
    select
    @@temp=900
    theta = BOLTZ*@@temp
    atom_mass = @@potential.atom_mass/AVOGADO

    for i in 1..10
      start=2.5
      @@a1 << a1 = (start+0.01*i)*1e-8
      @@k << k = calc_k(a1,sqrt(2)*a1 ,"sakakifcc")
      omega = sqrt(k/atom_mass)
      x = HBAR*omega/(2.0*theta)
      @@gamma << gamma = calc_gamma(a1,sqrt(2)*a1,"sakakifcc")
      @@gamma_jindo << gamma_jindo = calc_gamma(a1,sqrt(2)*a1,"jindofcc")
      gt_k2 = gamma*theta/k**2
      @@large_a << large_a = calc_large_a(x, gt_k2)
      @@large_a_maple << large_a_maple =calc_large_a_maple(x, gt_k2)
      @@y0 << y0 = calc_y0(k, gamma, theta, large_a)
      @@y0_jindo << y0 = calc_y0(k, gamma_jindo, theta, large_a)
      @@y0_jindo_maple << y0 = calc_y0(k, gamma_jindo, theta, large_a_maple)
      @@y0_maple << y0 = calc_y0(k, gamma, theta, large_a_maple)
    end
    plot_large_a
    plot_gamma
    plot_y0
  end
  def plot_large_a
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
#       plot.set "term aqua size 800, 800"
      #  plot.terminal "png enhanced"
#        plot.multiplot
#        plot.size "0.33,0.5"
#        plot.origin "0.0,0.5"
        #plot.set "output 'energy_#{@@element}.png'"
    #    plot.output "energy.eps"
        plot.title  "#{@@element}--#{@@temp}-large_a"
        plot.ylabel 'free energy[eV/atom]'
        plot.xlabel 'temperature[K]'
        plot.set "format x '%.2e'"
        plot.set "format y '%.2e'"
        x =@@a1
        plot.data << Gnuplot::DataSet.new( [x, @@large_a] ) do |ds|
          ds.with = "lines"
          ds.title = "large_a"
          #ds.notitle
        end
        plot.data << Gnuplot::DataSet.new([x, @@large_a_maple] ) do |ds|
          ds.with = "lines"
          ds.title = "large_a_maple"
          #ds.notitle
        end
      end
    end
    def plot_gamma
      Gnuplot.open do |gp|
        Gnuplot::Plot.new( gp ) do |plot|
          plot.set "term aqua size 800, 800"
          plot.title  "#{@@element}-#{@@temp}-gamma"
          plot.ylabel 'free energy[eV/atom]'
          plot.xlabel 'temperature[K]'
          plot.set "format x '%.2e'"
          plot.set "format y '%.2e'"
          x=@@a1
          plot.data << Gnuplot::DataSet.new( [x, @@gamma] ) do |ds|
            ds.with = "lines"
            ds.title = "gamma"
          end
          plot.data << Gnuplot::DataSet.new( [x, @@gamma_jindo] ) do |ds|
            ds.with = "lines"
            ds.title = "gamma_jindo"
          end
        end
      end
    end
    def plot_y0
      Gnuplot.open do |gp|
        Gnuplot::Plot.new( gp ) do |plot|
          plot.set "term aqua size 800, 800"
          plot.title  "#{@@element}-#{@@temp}-gamma"
          plot.ylabel 'free energy[eV/atom]'
          plot.xlabel 'temperature[K]'
          plot.set "format x '%.2e'"
          plot.set "format y '%.2e'"
          x=@@a1
          plot.data << Gnuplot::DataSet.new( [x, @@y0] ) do |ds|
            ds.with = "lines"
            ds.title = "y0"
          end
          plot.data << Gnuplot::DataSet.new( [x, @@y0_jindo] ) do |ds|
            ds.with = "lines"
            ds.title = "y0_jindo"
          end
          plot.data << Gnuplot::DataSet.new( [x, @@y0_jindo_maple] ) do |ds|
            ds.with = "lines"
            ds.title = "y0_jindo_maple"
          end
          plot.data << Gnuplot::DataSet.new( [x, @@y0_maple] ) do |ds|
            ds.with = "lines"
            ds.title = "y0_maple"
          end
        end
      end
    end
  end
end