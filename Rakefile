require "bundler/gem_tasks"
task :default => :spec
desc "transfer hikis/*.hiki to latex"
task :latex do
  target = 'handout_sample'
  command = "hiki2latex --pre latexes/handout_pre.tex hikis/#{target}.hiki > latexes/#{target}.tex"
  system command
  command = "open latexes/#{target}.tex"
  system command
end


