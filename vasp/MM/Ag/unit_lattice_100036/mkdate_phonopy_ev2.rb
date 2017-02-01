include Math

tmp_pos=[]
File::open("100/POSCAR") {|f|
  f.each {|line|
      #もっといい方法ありそう                                                                              
      tmp_pos << line.chomp.split(" ")
  }
}
lattice=tmp_pos[2][0].to_f

for num in 0..15
  dir=95+num



  tmp_data=[]
  File::open("#{dir}/OSZICAR") {|f|
    f.each {|line| 
      #もっといい方法ありそう
      tmp_data << line.chomp.split(" ")
    }
  }

  puts "#{(dir/100.0*lattice)**3} #{tmp_data.last[2].to_f}"
end
