require 'fileutils'

files = `git show --pretty="format:" --name-only HEAD`.split("\n")
files.each do |file|
  FileUtils.touch file unless file == ''
  # Wait juuust long enough
  sleep 0.2
end