class MinhaTarefa
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def run
    sleep(0.1)
    puts "Tarefa #{id}"
  end
end

def tarefa_com_classe
  10.times do |i|
    Thread.new(MinhaTarefa.new(i)) do |tarefa|
      tarefa.run
    end
  end
end

tarefa_com_classe
