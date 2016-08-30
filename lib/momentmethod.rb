require 'optparse'
require 'fileutils'
require 'momentmethod/version'
require 'momentmethod/momentmethod.rb'
p ARGV
@argv = ARGV
#target_path = ARGV[0] #==nil ? './' : @argv[0]
@opts = {calculation: :momentmethod, structure: "jindofcc", plot_type: "energy"}

command_parser = OptionParser.new do |opt|
  opt.on('-v', '--version','show program Version.') {
    opt.version = Momentmethod::VERSION
    puts opt.ver
  }
  opt.on('--structure [STRUCTURE]','plot k and gamma in Moment method by gnuplot, STRUCTURE=jindofcc, sakakifcc') {|v|
    @opts[:structure]= v.to_s if v!=nil
  }
  opt.on('--plot [PROTTYPE]','plot data by gnuplot, PROTTYPE=') {|v|
    @opts[:calculation]=:plot
    @opts[:plot_type]= v.to_s if v!=nil
  }
end
command_parser.parse!(@argv)
target_path = @argv[0]==nil ? './' : @argv[0]

FileUtils.cd(target_path){
  case @opts[:calculation]
  when :momentmethod then
    MomentMethod.new(@opts[:structure])
  when :plot then
    DataPlot.new(@opts[:plot_type],@opts[:structure])
  end
}
