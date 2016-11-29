task :seed_rake => [:csv:import_customers] do
  puts "File complete!"
end
