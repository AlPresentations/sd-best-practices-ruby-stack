puts ARGV # ["arg1", "art 2"]
puts $* # ["arg1", "art 2"]
puts "File:   "
puts __FILE__ # script.rb
puts $: # [/home/dpanov/.rvm/rubies/ruby-2.1.1/lib/ruby/site_ruby/2.1.0, /home/dpanov/.rvm/rubies/ruby-2.1.1/lib/ruby/site_ruby/2.1.0/x86_64-linux, /home/dpanov/.rvm/rubies/ruby-2.1.1/lib/ruby/site_ruby, /home/dpanov/.rvm/rubies/ruby-2.1.1/lib/ruby/vendor_ruby/2.1.0, /home/dpanov/.rvm/rubies/ruby-2.1.1/lib/ruby/vendor_ruby/2.1.0/x86_64-linux, /home/dpanov/.rvm/rubies/ruby-2.1.1/lib/ruby/vendor_ruby, /home/dpanov/.rvm/rubies/ruby-2.1.1/lib/ruby/2.1.0, /home/dpanov/.rvm/rubies/ruby-2.1.1/lib/ruby/2.1.0/x86_64-linux]
puts $0 #
consts =  Module.constants # [Object, Module, Class, BasicObject, Kernel, NilClass, NIL, Data, TrueClass, ...]
require "fileutils"
puts (Module.constants - consts) # [FileUtils, Etc]
