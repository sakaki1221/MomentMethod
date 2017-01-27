include Math
#phonopyのoutputから温度と自由エネルギーを取り出す,kJ/molからeV/atomに変換
#ruby mkdata_medea_Ef.rb ../heat_expansion/Al/Al_100/Job.out
kJ2eV=6.242e+21
mol=6.022140857e23
tmp_data=[]
flag=false
File::open(ARGV[0]) {|f|
  f.each {|line|
      flag = false if line=="                 _\n"
      tmp_data << line.chomp.split(" ") if flag
      flag = true if line=="#      T [K]      F [kJ/mol]    S [J/K/mol]  C_v [J/K/mol]     E [kJ/mol]\n"
      #もっといい方法ありそう                                                                              
  }
}
tmp_data.each{|data|
  puts "#{data[0]} #{data[1].to_f/mol*kJ2eV}" if data[0].to_f <1001
}

