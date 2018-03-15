
t = <<EOF
hello {{x}} {{y}}
EOF

p t

args = { "x" => "YYY", "y" => "XXX"}

p args

z = t.gsub(/{{.*?}}/) {|v| p v; v.gsub!(/[{}]/,""); args[v] }

p z

