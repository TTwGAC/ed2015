LETTERS = {
  "A" => %w{k1,p1,k1 p1,k1,p1 p1,k1,p1 p3 p1,k1,p1 p1,k1,p1},
  "B" => %w{p2,k1 p1,k1,p1 p3 p1,k1,p1 p1,k1,p1 p2,k1},
  "C" => %w{p3 p1,k2 p1,k2 p1,k2 p1,k1 p3},
  "D" => %w{p2,k1 p1,k1,p1 p1,k1,p1 p1,k1,p1 p1,k1,p1 p2,k1},
  "E" => %w{p3 p1,k2 p3 p1,k2 p1,k2 p3},
  "F" => %w{p3 p1,k2 p3 p1,k2 p1,k2 p1,k2},
  "G" => %w{k1,p3 p1,k3 p1,k3 p1,k1,p2 p1,k2,p1 k1,p3},
  "H" => %w{p1,k1,p1 p1,k1,p1 p3 p1,k1,p1 p1,k1,p1 p1,k1,p1},
  "I" => %w{p3 k1,p1,k1 k1,p1,k1 k1,p1,k1 k1,p1,k1 p3},
  "J" => %w{p3 k2,p1 k2,p1 k2,p1 k2,p1 p2,k1},
  "K" => %w{p1,k1,p1 p1,k1,p1 p2,k1 p1,k1,p1 p1,k1,p1 p1,k1,p1},
  "L" => %w{p1,k2 p1,k2 p1,k2 p1,k2 p1,k2 p3},
  "M" => %w{p1,k3,p1 p2,k1,p2 p1,k1,p1,k1,p1 p1,k1,p1 p1,k1,p1 p1,k1,p1},
  "N" => %w{p1,k2,p1 p2,k1,p1 p1,k1,p2 p1,k2,p1 p1,k2,p1 p1,k2,p1},
  "O" => %w{k1,p2,k1 p1,k2,p1 p1,k2,p1 p1,k2,p1 p1,k2,p1 k1,p2,k1},
  "P" => %w{p3 p1,k1,p1 p3 p1,k2 p1,k2 p1,k2},
  "Q" => %w{k1,p2,k1 p1,k2,p1 p1,k2,p1 p1,k2,p1 p1,k1,p1,k1 k1,p2,k1,p1},
  "R" => %w{p2,k1 p1,k1,p1 p1,k1,p1 p2,k1 p1,k1,p1 p1,k1,p1},
  "S" => %w{k1,p2 p1,k2 p2,k1 k2,p1 k2,p1 p2,k1},
  "T" => %w{p3 k1,p1,k1 k1,p1,k1 k1,p1,k1 k1,p1,k1 k1,p1,k1},
  "U" => %w{p1,k2,p1 p1,k2,p1 p1,k2,p1 p1,k2,p1 p1,k2,p1 k1,p2,k1},
  "V" => %w{p1,k1,p1 p1,k1,p1 p1,k1,p1 p1,k1,p1 p1,k1,p1 k1,p1,k1},
  "W" => %w{p1,k3,p1 p1,k3,p1 p1,k3,p1 p1,k1,p1,k1,p1 p2,k1,p2 p1,k3,p1},
  "X" => %w{p1,k1,p1 p1,k1,p1 k1,p1,k1 k1,p1,k1 p1,k1,p1 p1,k1,p1},
  "Y" => %w{p1,k1,p1 p1,k1,p1 p1,k1,p1 k1,p1,k1 k1,p1,k1 k1,p1,k1},
  "Z" => %w{p4 k3,p1 k2,p1,k1 k1,p1,k2 p1,k3 p4},
  "1" => %w{k1,p1,k1 p2,k1 k1,p1,k1 k1,p1,k1 k1,p1,k1 p3},
  "2" => %w{k1,p2,k1 p1,k2,p1 k2,p1,k1 k1,p1,k2 p1,k3 p4},
  "3" => %w{k1,p2,k1 p1,k2,p1 k2,p1,k1 k3,p1 p1,k2,p1 k1,p2,k1},
  "4" => %w{p1,k2,p1 p1,k2,p1 p4 k3,p1 k3,p1 k3,p1},
  "5" => %w{p3 p1,k2 p2,k1 k2,p1 k2,p1 p2,k1},
  "6" => %w{k1,p2 p1,k2 p1,k2 p3 p1,k1,p1 p3},
  "7" => %w{p3 k2,p1 k2,p1 k2,p1 k2,p1 k2,p1},
  "8" => %w{k1,p2,k1 p1,k2,p1 k1,p2,k1 p1,k2,p1 p1,k2,p1 k1,p2,k1},
  "9" => %w{p3 p1,k1,p1 p3 k2,p1 k2,p1 k2,p1},
  "0" => %w{k1,p2,1 p1,k2,p1 p1,k1,p2 p2,k1,p1 p1,k2,p1 k1,p2,k1},
  " " => %w{k1 k1 k1 k1 k1 k1},
  "&" => %w{k3,p5,k3 k2,p7,k2 k1,p9,k1 p2,k2,p7 p1,k1,p2,k1,p3,k1,p2 p1,k1,p2,k1,p2,k3,p1 p1,k3,p3,k3,p1 p2,k1,p2,k1,p2,k1,p2 p4,k3,p4 p5,k1,p5 k1,p9,k1 k2,p1,k1,p1,k1,p1,k1,p1,k2 k2,p1,k1,p1,k1,p1,k1,p1,k2 k2,p2,k1,p1,k1,p2,k2 k3,p1,k1,p1,k1,p1,k3 k3,p5,k3}, # SKULL
}


 


msg = ARGV[0].upcase || "GO TO THE SKULL AT L FIVE P"

rows = []
msg.split('').each do |letter|
  raise "ERROR: No font data found for \"#{letter}\"" unless LETTERS.has_key?(letter)
  LETTERS[letter].each_with_index do |row, i|
    rows[i] ||= ''
    rows[i] << row
    rows[i] << ',k1,'
  end
end

puts "co 120"
puts "k120"
rows.each_with_index do |row, i|
  puts "Row #{i+1}: #{row}"
end
puts "k120"

