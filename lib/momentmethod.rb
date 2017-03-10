require 'optparse'
require 'fileutils'
require 'momentmethod/version'
require 'momentmethod/momentmethod'
require 'momentmethod/fitting_test'
require 'momentmethod/momentmethod_j'
require 'momentmethod/plotdata'
p ARGV
@argv = ARGV
#target_path = ARGV[0] #==nil ? './' : @argv[0]
@opts = {calculation: :momentmethod, structure: "sakakifcc", plot_type: "energy"}

command_parser = OptionParser.new do |opt|
  opt.on('-v', '--version','show program Version.') {
    opt.version = Momentmethod::VERSION
    puts opt.ver
  }
  opt.on('--structure [STRUCTURE]','STRUCTURE=jindofcc, sakakifcc') {|v|
    @opts[:structure]= v.to_s if v!=nil
  }
  opt.on('--fittingtest','test for vasp') {
    @opts[:calculation]=:fittingtest
  }
  opt.on('--potj','test for vasp') {
    @opts[:calculation]=:potj
  }
  opt.on('--plotdata','test for vasp') {
    @opts[:calculation]=:plotdata
  }
end
command_parser.parse!(@argv)
$target_path = @argv[0]==nil ? './' : @argv[0]

case @opts[:calculation]
when :momentmethod then
  MomentMethod.new(@opts[:structure])
when :plotdata then
  PlotData.new
when :fittingtest then
  FittingTest.new()
when :potj then
  MomentMethodJ.new(@opts[:structure])
end
