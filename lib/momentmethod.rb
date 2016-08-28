require 'optparse'
require 'momentmethod/version'
require 'momentmethod/momentmethod.rb'
p ARGV[0]
target_path = ARGV[0] #==nil ? './' : @argv[0]
FileUtils.cd(target_path){
  MomentMethod.new("jindofcc")
}
