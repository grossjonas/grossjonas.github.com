#!/usr/bin/env ruby

require "time"

title=ARGV[0].gsub(/\ /, "-")
myTime=Time.new.iso8601.gsub(/T.*$/, "")

cmd="vim #{myTime}-#{title}.markdown"
#exec(cmd)

