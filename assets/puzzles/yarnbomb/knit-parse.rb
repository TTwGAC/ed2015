#!/usr/bin/env ruby
# encoding: utf-8

pattern = File.read(ARGV[0])
@rowcount = 0

def stitch(type, count = 1)
  count = count.to_i
  count.times { puts %Q{<td class="#{type}"></td>} }
  @rowcount += count
end

puts <<HEAD
<html>
<head>
<style type="text/css">
table { border-spacing: 0; border-bottom: 1px solid #999; border-left: 1px solid #999; }
tr { height: 10px; padding: 0; margin: 0; }
td { width: 10px; border-top: 1px solid #999; border-right: 1px solid #999; padding: 0; margin: 0; }

.knit { background-color: #fff; }
.purl { background-color: #000; }
.slip { background-color: #c00; }
.sskp { background-color: #0c0; }
.yarnover { background-color: #00c; }
</style>
</head>
<body>
<table>
HEAD


@width = nil
pattern.each_line do |line|
  unless @width
    break unless line =~ /^co\s*(\d+)/
    @width = $1.to_i
    next
  end

  puts "<tr>"
  @rowcount = 0
  steps = line.split ','
  steps.each do |step|
    case step
    when /^co\s*(\d+)/
      @width = $1.to_i
    when /^sl\s*(\d+)/
      stitch 'slip', $1
    when /^(k|p)\s*(\d+)\s*(tog)?/
      type = $1 == 'k' ? 'knit' : 'purl'
      if $3
        stitch type
      else
        stitch type, $2
      end
    when /^sskp/
      stitch 'sskp'
    when /^yo/
      stitch 'yarnover'
    when /rep/
      raise NotImplementedError
      #until @rowcount == @width
    end
  end
  unless @rowcount == @width
    $stderr.puts "WARNING: Insufficienct stitches (#{@rowcount}) for this row (#{@width})! Filling with knits"
    stitch 'knit', @width - @rowcount
  end
  puts "</tr>"
end

puts <<TAIL
</table>
</body>
</html>
TAIL
