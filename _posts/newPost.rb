#!/usr/bin/env ruby

require "time"

title = ARGV[0] if !(ARGV[0].nil? || ARGV[0].empty?)

if !title.nil?
	title=ARGV[0].gsub(/\ /, "-")
	myTime=Time.new.iso8601.gsub(/T.*$/, "")

	cmd="vim #{myTime}-#{title}.markdown"
	#exec(cmd)
else
	puts "no arg"
end




