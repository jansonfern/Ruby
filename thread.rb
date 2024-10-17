class MinhaTarefa
  attr_reader :id, :data

  def initialize(id, data)
    @id = id
    @data = data
  end

  def call
    sleep(0.1)
    puts "Tarefa #{id} com dados: #{@data}"
  end
end

# Executa uma única tarefa
def tarefa_unica
  MinhaTarefa.new(1, 'Dados da tarefa única').call
end

# Executa 10 tarefas em threads separadas
def tarefa_multi_thread_simples
  10.times do |i|
    Thread.new { sleep(0.1); puts "Tarefa #{i}" }
  end
end

# Executa 10 tarefas em threads separadas, utilizando a classe MinhaTarefa
def tarefa_multi_thread_com_classe
  threads = 10.times.map do |i|
    Thread.new(MinhaTarefa.new(i, "Dados da tarefa #{i}")) do |tarefa|
      begin
        tarefa.call
      rescue StandardError => e
        puts "Erro na tarefa #{i}: #{e.message}"
      end
    end
  end
  threads.each(&:join) 
end


tarefa_unica
tarefa_multi_thread_simples
tarefa_multi_thread_com_classe
