#!/usr/bin/ruby

###############################################################################
# “THE COFFEEWARE LICENSE” (Revision 1):
# <ihsan@kehribar.me> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a coffee in return.
###############################################################################

if ARGV.length() != 2
	puts "Script description:"
	puts "    Splits a file into two pieces with custom proportion";
	puts "Example usage:";
	puts "    split.rb info.txt 10";
	puts "Example description:"
	puts "    Generates split1_info.txt and split2_info.txt";
	puts "    split1_info.txt file has %10 of the info.txt"
	puts "    split2_info.txt file has %90 of the info.txt"
else

	# Raw input file that we downloaded from web
	fd_output_1 = File.open("split1_" + ARGV[0] , "w")
	fd_output_2 = File.open("split2_" + ARGV[0] , "w")

	# Loop over the file
	inputBuffer = File.open(ARGV[0],"r").readlines();

	# File length
	fileLength = inputBuffer.length();

	# Initialize the buffer
	indexBuffer = Array.new(fileLength);

	# There has to be another way for this ...
	for i in 0...fileLength
		indexBuffer[i] = i;
	end

	# Shuffle the index buffer three times
	indexBuffer.shuffle!;
	indexBuffer.shuffle!;
	indexBuffer.shuffle!;

	# Calculate the file lengths according to the proportions
	len_file_1 = ((fileLength * ARGV[1].to_i()) / 100).to_i();
	
	if(len_file_1 > fileLength)
		len_file_1 = fileLength;
	end
	
	len_file_2 = fileLength - len_file_1;

	# Write the new files
	for i in 0...len_file_1
		fd_output_1.write(inputBuffer[indexBuffer[i]]);
	end

	for i in len_file_1...fileLength
		fd_output_2.write(inputBuffer[indexBuffer[i]]);
	end

end