left_dir, right_dir = ARGV
# validate arguments
raise ArgumentError, 'To run script specify 2 arguments - paths to folders that should be compared.' unless left_dir && right_dir
[left_dir, right_dir].each{|path| raise ArgumentError, "There are no such folder #{path}." unless Dir.exist?(path)}

def traverse_dir(path)
	files = {}
	dirs = []

	(Dir.entries(path) - %w(. ..)).each do |name|
		full_name = File.join(path, name)
		files[name] = File.size(full_name) if File.file?(full_name)
		dirs << name if File.directory?(full_name)
	end
	return files, dirs
end

def compare_dirs(left_path, right_path, level=0)
	left_files, left_dirs = traverse_dir(left_path) 
	right_files, right_dirs = traverse_dir(right_path) 

	output = []
	length = 20 # length of path
	size_length = 8 # length of file size
	full_length = length + size_length

	(left_files.keys - right_files.keys).each do |fname|
		output << " #{' '*(level)}%#{full_length - level}s  |" % [fname]
	end	
	(right_files.keys - left_files.keys).each do |fname|
		output << " #{' '*(level)}%#{full_length - level}s  |  %s" % ['', fname]
	end
	(left_files.keys&right_files.keys).each do |fname|
		output << " #{' '*(level)}%#{length}s %#{size_length}s | %-#{size_length}s %s" % [fname, left_files[fname], right_files[fname], fname] unless left_files[fname] == right_files[fname]
	end
	(left_dirs - right_dirs).each do |fname|
		output << " #{' '*level}%#{full_length- level}s  |" % [fname]
	end	
	(right_dirs - left_dirs).each do |fname|
		output << " #{' '*level}%#{full_length - level}s  |  %s" % ['', fname]
	end

	unless output.empty?
		puts "#{' '*level} %#{full_length - level}s <=> %s" % [left_path, right_path]
		puts output.join("\n")
		puts
	end	

	# recursivly compare subfolders with the same name
	(right_dirs&left_dirs).each do |fname|
		compare_dirs(File.join(left_path, fname), File.join(right_path, fname), level + 1)
	end
end


compare_dirs(left_dir, right_dir)

#ruby file_comparison.rb ./data/1  ./data/2
