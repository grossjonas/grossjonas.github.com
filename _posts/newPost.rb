#!/usr/bin/env ruby

require "time"
require "readline"

title = ARGV[0] if !(ARGV[0].nil? || ARGV[0].empty?)

if !title.nil?
	title=ARGV[0]
else
	title = Readline.readline("Title: ", true)
	while title.empty?
		title = Readline.readline("Title: ", true)
	end	
end

title=title.gsub(/\ /, "-")
myTime=Time.new.iso8601.gsub(/T.*$/, "")

cmd="vim #{myTime}-#{title}.markdown"
exec(cmd)

