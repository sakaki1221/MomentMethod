include Math

lattice = 4.1734614388124864

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
