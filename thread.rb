def tarefa_sequencial
  10.times do |i|
    sleep(0.1) # Simulando uma tarefa demorada
    puts "Tarefa #{i}"
  end
end

tarefa_sequencial
