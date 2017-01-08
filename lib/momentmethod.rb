require 'optparse'
require 'fileutils'
require 'momentmethod/version'
require 'momentmethod/momentmethod'
require 'momentmethod/vasptest'
require 'momentmethod/vasptest_ev'
require 'momentmethod/e0test'
require 'momentmethod/testboltz_e8'
require 'momentmethod/e10boltz'
require 'momentmethod/fitting_test'
p ARGV
@argv = ARGV
#target_path = ARGV[0] #==nil ? './' : @argv[0]
@opts = {calculation: :momentmethod, structure: "jindofcc", plot_type: "energy"}

command_parser = OptionParser.new do |opt|
  opt.on('-v', '--version','show program Version.') {
    opt.version = Momentmethod::VERSION
    puts opt.ver
  }
  opt.on('--structure [STRUCTURE]','???plot k and gamma in Moment method by gnuplot, STRUCTURE=jindofcc, sakakifcc') {|v|
    @opts[:structure]= v.to_s if v!=nil
  }
  opt.on('--plot [PROTTYPE]','plot data by gnuplot, PROTTYPE=') {|v|
    @opts[:calculation]=:plot
    @opts[:plot_type]= v.to_s if v!=nil
  }
  opt.on('--test','test for vasp') {
    @opts[:calculation]=:vasptest
  }
  opt.on('--e0test','test for vasp') {
    @opts[:calculation]=:e0test
  }
  opt.on('--boltztest','test for vasp') {
    @opts[:calculation]=:boltztest
  }
  opt.on('--e10boltz','test for vasp') {
    @opts[:calculation]=:e10boltz
  }
  opt.on('--fittingtest','test for vasp') {
    @opts[:calculation]=:fittingtest
  }
end
command_parser.parse!(@argv)
$target_path = @argv[0]==nil ? './' : @argv[0]

case @opts[:calculation]
when :momentmethod then
  MomentMethod.new(@opts[:structure])
  #MomentPlot.new(@opts[:structure],1)
when :plot then
  DataPlot.new(@opts[:plot_type],@opts[:structure])
when :vasptest then
  VaspTest.new(@opts[:structure])
when :e0test then
  E0test.new(@opts[:structure])
when :boltztest then
  TestBoltz.new(@opts[:structure])
when :e10boltz then
  E10boltz.new(@opts[:structure])
when :fittingtest then
  FittingTest.new(@opts[:structure])
end

=begin
FileUtils.cd(target_path){
  case @opts[:calculation]
  when :momentmethod then
    MomentMethod.new(@opts[:structure])
  when :plot then
    DataPlot.new(@opts[:plot_type],@opts[:structure])
  end
}
=end
