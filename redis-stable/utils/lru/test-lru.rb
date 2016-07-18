require 'rubygems'
require 'redis'

r = Redis.new
r.config('SET', 'maxmemory', '2000000')
r.config('SET', 'maxmemory-policy', 'allkeys-lru')
r.config('SET', 'maxmemory-samples', 5)
r.config('RESETSTAT')
r.flushall

puts <<EOF
<html>
<body>
<style>
.box {
    width:5px;
    height:5px;
    float:left;
    margin: 1px;
}

.old {
    border: 1px black solid;
}

.new {
    border: 1px green solid;
}

.ex {
    background-color: #666;
}
</style>
<pre>
EOF

# Fill
oldsize = r.dbsize
id = 0
loop do
  id += 1
  r.set(id, 'foo')
  newsize = r.dbsize
  break if newsize == oldsize
  oldsize = newsize
end

inserted = r.dbsize
first_set_max_id = id
puts "#{r.dbsize} keys inserted"

# Access keys sequentially

puts 'Access keys sequentially'
(1..first_set_max_id).each do |id|
  r.get(id)
  #    sleep 0.001
end

# Insert more 50% keys. We expect that the new keys
half = inserted / 2
puts 'Insert enough keys to evict half the keys we inserted'
add = 0
loop do
  add += 1
  id += 1
  r.set(id, 'foo')
  break if r.info['evicted_keys'].to_i >= half
end

puts "#{add} additional keys added."
puts "#{r.dbsize} keys in DB"

# Check if evicted keys respect LRU
# We consider errors from 1 to N progressively more serious as they violate
# more the access pattern.

errors = 0
e = 1
edecr = 1.0 / (first_set_max_id / 2)
(1..(first_set_max_id / 2)).each do |id|
  e -= edecr if e > 0
  e = 0 if e < 0
  errors += e if r.exists(id)
end

puts "#{errors} errors!"
puts '</pre>'

# Generate the graphical representation
(1..id).each do |id|
  # Mark first set and added items in a different way.
  c = 'box'
  c << if id <= first_set_max_id
         ' old'
       else
         ' new'
       end

  # Add class if exists
  c << ' ex' if r.exists(id)
  puts "<div class=\"#{c}\"></div>"
end

# Close HTML page

puts <<EOF
</body>
</html>
EOF
