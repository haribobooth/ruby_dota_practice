__path = File.expand_path(File.dirname(__FILE__))

system("psql -d dota_2 -f #{__path}/dota_2.sql")
system("psql -d dota_2 -f #{__path}/seeds.sql")
