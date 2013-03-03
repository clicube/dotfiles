Files = ["zshrc", "vimrc"]

task :install do
  Files.each do |f|
    target = File.expand_path "~/.#{f}"
    sh "ln -s #{File.expand_path f} #{target}" unless File.exist? target
  end
end

