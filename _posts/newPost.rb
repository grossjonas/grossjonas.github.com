#!/usr/bin/env ruby

require "time"

title=ARGV[0].gsub(/\ /, "-")
myTime=Time.new.iso8601.gsub(/T.*$/, "")

puts "#{myTime}-#{title}.markdown"


#exec()
