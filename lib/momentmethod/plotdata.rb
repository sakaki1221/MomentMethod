require 'yaml'
require 'gnuplot'
include Math

class PlotData < MomentMethodJ

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
    @@y0_no_large_a=[]
    @@y0_large_a=[]
    p "Im PlotData"
    select
    @@temp=900
    theta = BOLTZ2*@@temp
    atom_mass = @@potential.atom_mass/AVOGADO

    for i in 0..10
      start=2.5
      @@a1 << a1 = (start+0.01*i)
      a1=a1*1e-10
      calc_k_noboltz(2.591922999748051e-10,sqrt(2.0)*2.591922999748051e-10,"sakakifcc")
      @@k << k = calc_k_noboltz(a1,sqrt(2)*a1 ,"sakakifcc")
      omega = sqrt(k/atom_mass*1e-3)
      #HBAR2
      x = HBAR2*omega/(2.0*theta)
      @@gamma << gamma = calc_gamma_noboltz(a1,sqrt(2)*a1,"sakakifcc")
      @@gamma_jindo << gamma_jindo = calc_gamma_noboltz(a1,sqrt(2)*a1,"jindofcc")
      gt_k2 = gamma*theta/k**2
      calc_gamma_noboltz(2.591922999748051e-10,sqrt(2.0)*2.591922999748051e-10,"sakakifcc")
      @@large_a << large_a = calc_large_a(x, gt_k2)
      @@large_a_maple << large_a_maple =calc_large_a_maple(x, gt_k2)
      @@y0_no_large_a<<sqrt((2.0*gamma*theta**2)/(3*k**3))
      @@y0 << y0 = calc_y0(k, gamma, theta, large_a)
      @@y0_jindo << y0 = calc_y0(k, gamma_jindo, theta, large_a)
      @@y0_jindo_maple << y0 = calc_y0(k, gamma_jindo, theta, large_a_maple)
      @@y0_maple << y0 = calc_y0(k, gamma, theta, large_a_maple)
      @@y0_large_a<<sqrt(large_a)
    end
    #plot_large_a
    #plot_y0_no_large_a
    #plot_gamma
    plot_y0_thesis2
  end
  def plot_y0_no_large_a
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
        plot.ylabel '                                                          '
        plot.xlabel 'Nearest atomic distance[Å]'
        #plot.set "format x '%.2e'"
        plot.set "format y '%.1e'"
        # => plot.set "xtics 2.52, 0.02, 2.6"
        plot.set "xtics font 'times,15'"
        plot.set "ytics font 'times,15'"
        #plot.set "ytics 1e-12"
        plot.set "xrange [2.51:2.6]"
        #plot.set "yrange [4.0e-13:7.8e-13]"
        plot.set "xlabel font 'times,18'"
        plot.set "ylabel font 'times,30'"
        x =@@a1
        plot.data << Gnuplot::DataSet.new( [x, @@y0_no_large_a] ) do |ds|
          ds.with = "lines"
          #ds.title = "large_a"
          #ds.with = "l lw 2"
          ds.linewidth=2
          ds.notitle
        end
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
  def plot_y0_thesis
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.set "term aqua size 450, 400"
        #plot.set "terminal postscript eps enhanced "
        #plot.output "hoge.eps"
        #plot.title  "#{@@element}-#{@@temp}K-y0"
        plot.ylabel "   [m]"
        plot.xlabel 'Nearest atomic distance[Å]'

        #plot.set "format x '%.2e'"
        plot.set "format y '%.1e'"
        #plot.set "xtics 2.52e-10, 2e-12, 2.6e-10"
        plot.set "xtics 2.52, 0.02, 2.6"
        plot.set "xtics font 'times,20'"
        plot.set "ytics font 'times,20'"
        #plot.set "xtics 5e-12"
        plot.set "xrange [2.51:2.6]"
        plot.set "yrange [4.0e-13:7.8e-13]"
        plot.set "xlabel font 'times,21'"
        plot.set "ylabel font 'times,21'"
        x=@@a1
        plot.data << Gnuplot::DataSet.new( [x, @@y0] ) do |ds|
          ds.with = "lines"
          ds.title = "Past paper"
          #ds.notitle
          ds.with = "lp pt 2"
        end
        plot.data << Gnuplot::DataSet.new( [x, @@y0_maple] ) do |ds|
          ds.with = "lines"
          ds.title = "My calculation"
          #ds.notitle
          ds.with = "lp pt 1"
        end
      end
    end
  end
  def plot_y0_thesis2
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
        plot.set "term aqua size 450, 400"
        #plot.set "terminal postscript eps enhanced "
        #plot.output "hoge.eps"
        #plot.title  "#{@@element}-#{@@temp}K-y0"
        plot.ylabel "   [m]"
        plot.xlabel 'Nearest atomic distance[Å]'
        #plot.set "format x '%.2e'"
        plot.set "format y '%.1e'"
        #plot.set "xtics 2.52e-10, 2e-12, 2.6e-10"
        plot.set "xtics 2.52, 0.02, 2.6"
        #plot.set "xtics 5e-12"
        plot.set "xtics font 'times,20'"
        plot.set "ytics font 'times,20'"
        plot.set "xrange [2.51:2.6]"
        plot.set "yrange [4e-12:9e-12]"
        plot.set "xlabel font 'times,21'"
        plot.set "ylabel font 'times,21'"
        #plot.set "yrange [4.0e-13:7.8e-13]"
        x=@@a1
        plot.data << Gnuplot::DataSet.new( [x, @@y0] ) do |ds|
          ds.with = "lines"
          ds.title = "Past paper"
          #ds.notitle
          ds.with = "lp pt 2"
        end
        plot.data << Gnuplot::DataSet.new( [x, @@y0_maple] ) do |ds|
          ds.with = "lines"
          ds.title = "My calculation"
          #ds.notitle
          ds.with = "lp pt 1"
        end
      end
    end
  end
end
