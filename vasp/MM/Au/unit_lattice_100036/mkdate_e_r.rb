include Math

lattice = 4.1728519023148678/sqrt(2.0)

for num in 0..15
  dir=95+num



  tmp_data=[]
  File::open("#{dir}/OSZICAR") {|f|
    f.each {|line| 
      #もっといい方法ありそう
      tmp_data << line.chomp.split(" ")
    }
  }

  puts "#{dir/100.0*lattice} #{tmp_data.last[2].to_f/4.0}"
end
