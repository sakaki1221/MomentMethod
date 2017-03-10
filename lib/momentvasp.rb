require 'optparse'
require 'momentmethod/momentmethod'

p "momentvasp"
#関数を利用するPOSCARの読み込み，
#POSCAR.rbをrequireして，module Poscarを利用できるようにする．
p @poscar_path = ARGV[0]
require "./#{@poscar_path}"
require 'momentvasp/momentvasp' #moduleの都合上ここでrequireする必要がある．
MomentVASP.new()
