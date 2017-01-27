#mapleでの熱膨張のプロットのためにJob.outからデータを生成する．
target_dir = ARGV[0]
output_dir = ARGV[1]
filenames = Dir.glob("#{target_dir}/*_*")
alldata = []
filenames.each do |dir|
  File::basename(dir)
  @element = dir.match(/[a-zA-Z]+/).to_s
  num = dir.match(/\d+/).to_s
  ratio = num.to_f/100
  flag = false
  data = []
  tmp_data =[]
  p File::open("#{dir}/Job.out") {|f|
    f.each {|line| 
      #もっといい方法ありそう
      flag = false if line=="\r\n"
      tmp_data << line.chomp.split(" ") if flag
      flag = true if line=="  ----- ----------- ----------- ----------- ----------- ----------- -----------\r\n"    
    }
  }
  #K, Ef, ratioのみのデータに
  tmp_data.each do |a|
    a.slice!(1..5)
    a << ratio
    data << a
  end
  alldata << data
end

#データ8つ結合とりあえず手で変更
tmp = alldata[0].zip(alldata[1],alldata[2],alldata[3],alldata[4],alldata[5])
tmp.each do |a|
  File.open("#{output_dir}/#{@element}_#{a[0][0]}.txt", "w") do |file|
    a.each do |b|
      file.puts(b[2].to_s+" "+b[1].to_s)
    end
  end
end
