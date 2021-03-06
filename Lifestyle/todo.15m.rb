#!/usr/bin/env ruby
# coding: utf-8

# <bitbar.title>TodoColour</bitbar.title>
# <bitbar.version>v0.1</bitbar.version>
# <bitbar.author>Srdgh</bitbar.author>
# <bitbar.author.github>Srdgh</bitbar.author.github>
# <bitbar.desc>Todo list with customisable color-code. Mark tasks "done" simply by clicking on them in the menubar drop-down list.</bitbar.desc>
# <bitbar.image>http://i.imgur.com/eNl6QGh.png</bitbar.image>
# <bitbar.dependencies>ruby</bitbar.dependencies>

# Change to your todo directory path
@todo_directory = "#{Dir.home}/todo"

# Add further priority labels here
@priorityLabels = [ "+Urgent" ]

# Change priority color here
@priorityColor = "red"

# Customise label color-code here (these colors are optimised for a dark theme menubar)
@labels = { 
    "+Work"=>"orange",
    "+Play"=>"yellow",
    "+Family"=>"green",
    "+Health"=>"cadetblue",
    "+Code"=>"purple",
    "+Admin"=>"violet"
    }

@todo_file = File.open("#{@todo_directory}/todo.txt")
@todo_script = ("#{@todo_directory}/todo.sh")

lines = IO.readlines(@todo_file)
puts "Do: #{lines.length}"

puts "---"

@linenumber = 0
until @todo_file.eof() # Until end-of-file
    @linenumber += 1
    color = nil
    line = @todo_file.readline().chomp
    @priorityLabels.each do |key| # If line contains priority label, display in priority color
        color = @priorityColor if line.include?(key)
    end
    if color.nil? # If line contains no priority label, check for other label and if present display in chosen color
        @labels.each do |key, value|
        color = value if line.include?(key)
        end
    end    
    color.nil? ? puts("#{line} | bash=#{@todo_script} param1=do param2=#{@linenumber} terminal=false refresh=\n") : puts("#{line} | color=#{color} bash=#{@todo_script} param1=do param2=#{@linenumber} terminal=false refresh=\n") # If the line contains no label, display in default color
end
puts "---"
puts "Click an item to mark 'done'"
puts "Refresh | refresh="