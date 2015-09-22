Files = ["zshrc", "vimrc","screenrc","gemrc","gitconfig"]

Dir.chdir File.dirname(__FILE__)

Files.each do |f|
  target = File.expand_path "~/.#{f}"
  if !File.exist? target
    cmd = "ln -s #{File.expand_path f} #{target}"
    puts cmd
    system cmd
  end
end

