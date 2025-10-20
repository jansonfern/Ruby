class QuizController < ApplicationController
  def take
    id = params[:id].to_i

    questionnaires_data = {
      1 => { title: "Quiz de Ruby on Rails", code: "ROR001", description: "Teste seus conhecimentos em Ruby on Rails", duration_minutes: 30 },
      2 => { title: "Quiz de JavaScript", code: "JS001", description: "Avalie seu conhecimento em JavaScript", duration_minutes: 20 },
      3 => { title: "Quiz de Python", code: "PY001", description: "Teste seus conhecimentos em Python", duration_minutes: 25 },
      4 => { title: "Quiz de React", code: "REACT001", description: "Avalie seu conhecimento em React", duration_minutes: 35 }
    }

    data = questionnaires_data[id] || questionnaires_data[1]

    @questionnaire = Struct.new(:id, :title, :code, :description, :duration_minutes, :total_questions).new(
      id, data[:title], data[:code], data[:description], data[:duration_minutes], 5
    )

    @questions = case id
    when 1 # Ruby on Rails
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual comando gera um model no Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "rails generate model", true),
            Struct.new(:id, :title, :correct?).new(2, "rails new model", false),
            Struct.new(:id, :title, :correct?).new(3, "rails create model", false),
            Struct.new(:id, :title, :correct?).new(4, "rails make model", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Qual é o padrão de arquitetura do Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "MVC", true),
            Struct.new(:id, :title, :correct?).new(2, "MVVM", false),
            Struct.new(:id, :title, :correct?).new(3, "MVP", false),
            Struct.new(:id, :title, :correct?).new(4, "Clean", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Onde você define as rotas no Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "config/routes.rb", true),
            Struct.new(:id, :title, :correct?).new(2, "app/routes.rb", false),
            Struct.new(:id, :title, :correct?).new(3, "lib/routes.rb", false),
            Struct.new(:id, :title, :correct?).new(4, "routes/config.rb", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual comando inicia o servidor Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "bin/rails server", true),
            Struct.new(:id, :title, :correct?).new(2, "rails start", false),
            Struct.new(:id, :title, :correct?).new(3, "rails run", false),
            Struct.new(:id, :title, :correct?).new(4, "ruby server.rb", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "Qual é a função do ActiveRecord?",
          [
            Struct.new(:id, :title, :correct?).new(1, "Mapear objetos para tabelas do banco", true),
            Struct.new(:id, :title, :correct?).new(2, "Gerenciar assets front-end", false),
            Struct.new(:id, :title, :correct?).new(3, "Servir arquivos estáticos", false),
            Struct.new(:id, :title, :correct?).new(4, "Enviar emails", false)
          ]
        )
      ]
    when 2 # JavaScript
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual palavra-chave declara uma variável mutável com escopo de bloco?",
          [
            Struct.new(:id, :title, :correct?).new(1, "let", true),
            Struct.new(:id, :title, :correct?).new(2, "const", false),
            Struct.new(:id, :title, :correct?).new(3, "var", false),
            Struct.new(:id, :title, :correct?).new(4, "mutable", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Qual método do Array cria um novo array com elementos que atendem a uma condição?",
          [
            Struct.new(:id, :title, :correct?).new(1, "filter", true),
            Struct.new(:id, :title, :correct?).new(2, "map", false),
            Struct.new(:id, :title, :correct?).new(3, "forEach", false),
            Struct.new(:id, :title, :correct?).new(4, "reduce", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Qual é o resultado de typeof null?",
          [
            Struct.new(:id, :title, :correct?).new(1, "object", true),
            Struct.new(:id, :title, :correct?).new(2, "null", false),
            Struct.new(:id, :title, :correct?).new(3, "undefined", false),
            Struct.new(:id, :title, :correct?).new(4, "number", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual operador espalha os elementos de um array?",
          [
            Struct.new(:id, :title, :correct?).new(1, "...", true),
            Struct.new(:id, :title, :correct?).new(2, "??", false),
            Struct.new(:id, :title, :correct?).new(3, "+", false),
            Struct.new(:id, :title, :correct?).new(4, "*", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "Qual método converte uma string JSON para objeto?",
          [
            Struct.new(:id, :title, :correct?).new(1, "JSON.parse", true),
            Struct.new(:id, :title, :correct?).new(2, "JSON.stringify", false),
            Struct.new(:id, :title, :correct?).new(3, "Object.parse", false),
            Struct.new(:id, :title, :correct?).new(4, "toJSON", false)
          ]
        )
      ]
    when 3 # Python
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual função retorna o tamanho de uma lista?",
          [
            Struct.new(:id, :title, :correct?).new(1, "len()", true),
            Struct.new(:id, :title, :correct?).new(2, "size()", false),
            Struct.new(:id, :title, :correct?).new(3, "count()", false),
            Struct.new(:id, :title, :correct?).new(4, "length()", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Como criar um ambiente virtual com a biblioteca padrão?",
          [
            Struct.new(:id, :title, :correct?).new(1, "python -m venv venv", true),
            Struct.new(:id, :title, :correct?).new(2, "pip install venv", false),
            Struct.new(:id, :title, :correct?).new(3, "conda create -n venv", false),
            Struct.new(:id, :title, :correct?).new(4, "virtualenv venv (sem biblioteca externa)", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Qual tipo é imutável em Python?",
          [
            Struct.new(:id, :title, :correct?).new(1, "tuple", true),
            Struct.new(:id, :title, :correct?).new(2, "list", false),
            Struct.new(:id, :title, :correct?).new(3, "dict", false),
            Struct.new(:id, :title, :correct?).new(4, "set", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual sintaxe cria uma lista com quadrados de 0 a 4?",
          [
            Struct.new(:id, :title, :correct?).new(1, "[x**2 for x in range(5)]", true),
            Struct.new(:id, :title, :correct?).new(2, "list(range(5**2))", false),
            Struct.new(:id, :title, :correct?).new(3, "map(lambda x: x**2, range(5))", false),
            Struct.new(:id, :title, :correct?).new(4, "{x**2 for x in range(5)}", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "O que é o PEP 8?",
          [
            Struct.new(:id, :title, :correct?).new(1, "Guia de estilo de código Python", true),
            Struct.new(:id, :title, :correct?).new(2, "Biblioteca de teste unitário", false),
            Struct.new(:id, :title, :correct?).new(3, "Gerenciador de pacotes", false),
            Struct.new(:id, :title, :correct?).new(4, "Compilador", false)
          ]
        )
      ]
    when 4 # React
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Como declarar um componente funcional em React?",
          [
            Struct.new(:id, :title, :correct?).new(1, "function Button() { return <button/> }", true),
            Struct.new(:id, :title, :correct?).new(2, "class Button extends Component { render() { return <button/> } }", false),
            Struct.new(:id, :title, :correct?).new(3, "component Button => <button/>", false),
            Struct.new(:id, :title, :correct?).new(4, "new Component(Button)", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Qual hook substitui componentDidMount em componentes funcionais?",
          [
            Struct.new(:id, :title, :correct?).new(1, "useEffect", true),
            Struct.new(:id, :title, :correct?).new(2, "useState", false),
            Struct.new(:id, :title, :correct?).new(3, "useMemo", false),
            Struct.new(:id, :title, :correct?).new(4, "useRef", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Qual atributo JSX é usado para adicionar classes CSS?",
          [
            Struct.new(:id, :title, :correct?).new(1, "className", true),
            Struct.new(:id, :title, :correct?).new(2, "class", false),
            Struct.new(:id, :title, :correct?).new(3, "classes", false),
            Struct.new(:id, :title, :correct?).new(4, "cssClass", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual ferramenta geralmente é usada para criar apps React rapidamente?",
          [
            Struct.new(:id, :title, :correct?).new(1, "Create React App", true),
            Struct.new(:id, :title, :correct?).new(2, "React Maker", false),
            Struct.new(:id, :title, :correct?).new(3, "Next Builder", false),
            Struct.new(:id, :title, :correct?).new(4, "CRA Builder", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "Qual hook é usado para estado em componentes funcionais?",
          [
            Struct.new(:id, :title, :correct?).new(1, "useState", true),
            Struct.new(:id, :title, :correct?).new(2, "useEffect", false),
            Struct.new(:id, :title, :correct?).new(3, "useReducer", false),
            Struct.new(:id, :title, :correct?).new(4, "useContext", false)
          ]
        )
      ]
    else
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual comando gera um model no Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "rails generate model", true),
            Struct.new(:id, :title, :correct?).new(2, "rails new model", false),
            Struct.new(:id, :title, :correct?).new(3, "rails create model", false),
            Struct.new(:id, :title, :correct?).new(4, "rails make model", false)
          ]
        )
      ]
    end
  end

  def submit
    id = params[:id].to_i

    # Reconstrói o conjunto de perguntas conforme o tema (mesma lógica do take)
    questions = case id
    when 1 # Ruby on Rails
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual comando gera um model no Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "rails generate model", true),
            Struct.new(:id, :title, :correct?).new(2, "rails new model", false),
            Struct.new(:id, :title, :correct?).new(3, "rails create model", false),
            Struct.new(:id, :title, :correct?).new(4, "rails make model", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Qual é o padrão de arquitetura do Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "MVC", true),
            Struct.new(:id, :title, :correct?).new(2, "MVVM", false),
            Struct.new(:id, :title, :correct?).new(3, "MVP", false),
            Struct.new(:id, :title, :correct?).new(4, "Clean", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Onde você define as rotas no Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "config/routes.rb", true),
            Struct.new(:id, :title, :correct?).new(2, "app/routes.rb", false),
            Struct.new(:id, :title, :correct?).new(3, "lib/routes.rb", false),
            Struct.new(:id, :title, :correct?).new(4, "routes/config.rb", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual comando inicia o servidor Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "bin/rails server", true),
            Struct.new(:id, :title, :correct?).new(2, "rails start", false),
            Struct.new(:id, :title, :correct?).new(3, "rails run", false),
            Struct.new(:id, :title, :correct?).new(4, "ruby server.rb", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "Qual é a função do ActiveRecord?",
          [
            Struct.new(:id, :title, :correct?).new(1, "Mapear objetos para tabelas do banco", true),
            Struct.new(:id, :title, :correct?).new(2, "Gerenciar assets front-end", false),
            Struct.new(:id, :title, :correct?).new(3, "Servir arquivos estáticos", false),
            Struct.new(:id, :title, :correct?).new(4, "Enviar emails", false)
          ]
        )
      ]
    when 2 # JavaScript
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual palavra-chave declara uma variável mutável com escopo de bloco?",
          [
            Struct.new(:id, :title, :correct?).new(1, "let", true),
            Struct.new(:id, :title, :correct?).new(2, "const", false),
            Struct.new(:id, :title, :correct?).new(3, "var", false),
            Struct.new(:id, :title, :correct?).new(4, "mutable", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Qual método do Array cria um novo array com elementos que atendem a uma condição?",
          [
            Struct.new(:id, :title, :correct?).new(1, "filter", true),
            Struct.new(:id, :title, :correct?).new(2, "map", false),
            Struct.new(:id, :title, :correct?).new(3, "forEach", false),
            Struct.new(:id, :title, :correct?).new(4, "reduce", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Qual é o resultado de typeof null?",
          [
            Struct.new(:id, :title, :correct?).new(1, "object", true),
            Struct.new(:id, :title, :correct?).new(2, "null", false),
            Struct.new(:id, :title, :correct?).new(3, "undefined", false),
            Struct.new(:id, :title, :correct?).new(4, "number", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual operador espalha os elementos de um array?",
          [
            Struct.new(:id, :title, :correct?).new(1, "...", true),
            Struct.new(:id, :title, :correct?).new(2, "??", false),
            Struct.new(:id, :title, :correct?).new(3, "+", false),
            Struct.new(:id, :title, :correct?).new(4, "*", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "Qual método converte uma string JSON para objeto?",
          [
            Struct.new(:id, :title, :correct?).new(1, "JSON.parse", true),
            Struct.new(:id, :title, :correct?).new(2, "JSON.stringify", false),
            Struct.new(:id, :title, :correct?).new(3, "Object.parse", false),
            Struct.new(:id, :title, :correct?).new(4, "toJSON", false)
          ]
        )
      ]
    when 3 # Python
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual função retorna o tamanho de uma lista?",
          [
            Struct.new(:id, :title, :correct?).new(1, "len()", true),
            Struct.new(:id, :title, :correct?).new(2, "size()", false),
            Struct.new(:id, :title, :correct?).new(3, "count()", false),
            Struct.new(:id, :title, :correct?).new(4, "length()", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Como criar um ambiente virtual com a biblioteca padrão?",
          [
            Struct.new(:id, :title, :correct?).new(1, "python -m venv venv", true),
            Struct.new(:id, :title, :correct?).new(2, "pip install venv", false),
            Struct.new(:id, :title, :correct?).new(3, "conda create -n venv", false),
            Struct.new(:id, :title, :correct?).new(4, "virtualenv venv (sem biblioteca externa)", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Qual tipo é imutável em Python?",
          [
            Struct.new(:id, :title, :correct?).new(1, "tuple", true),
            Struct.new(:id, :title, :correct?).new(2, "list", false),
            Struct.new(:id, :title, :correct?).new(3, "dict", false),
            Struct.new(:id, :title, :correct?).new(4, "set", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual sintaxe cria uma lista com quadrados de 0 a 4?",
          [
            Struct.new(:id, :title, :correct?).new(1, "[x**2 for x in range(5)]", true),
            Struct.new(:id, :title, :correct?).new(2, "list(range(5**2))", false),
            Struct.new(:id, :title, :correct?).new(3, "map(lambda x: x**2, range(5))", false),
            Struct.new(:id, :title, :correct?).new(4, "{x**2 for x in range(5)}", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "O que é o PEP 8?",
          [
            Struct.new(:id, :title, :correct?).new(1, "Guia de estilo de código Python", true),
            Struct.new(:id, :title, :correct?).new(2, "Biblioteca de teste unitário", false),
            Struct.new(:id, :title, :correct?).new(3, "Gerenciador de pacotes", false),
            Struct.new(:id, :title, :correct?).new(4, "Compilador", false)
          ]
        )
      ]
    when 4 # React
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Como declarar um componente funcional em React?",
          [
            Struct.new(:id, :title, :correct?).new(1, "function Button() { return <button/> }", true),
            Struct.new(:id, :title, :correct?).new(2, "class Button extends Component { render() { return <button/> } }", false),
            Struct.new(:id, :title, :correct?).new(3, "component Button => <button/>", false),
            Struct.new(:id, :title, :correct?).new(4, "new Component(Button)", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Qual hook substitui componentDidMount em componentes funcionais?",
          [
            Struct.new(:id, :title, :correct?).new(1, "useEffect", true),
            Struct.new(:id, :title, :correct?).new(2, "useState", false),
            Struct.new(:id, :title, :correct?).new(3, "useMemo", false),
            Struct.new(:id, :title, :correct?).new(4, "useRef", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Qual atributo JSX é usado para adicionar classes CSS?",
          [
            Struct.new(:id, :title, :correct?).new(1, "className", true),
            Struct.new(:id, :title, :correct?).new(2, "class", false),
            Struct.new(:id, :title, :correct?).new(3, "classes", false),
            Struct.new(:id, :title, :correct?).new(4, "cssClass", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual ferramenta geralmente é usada para criar apps React rapidamente?",
          [
            Struct.new(:id, :title, :correct?).new(1, "Create React App", true),
            Struct.new(:id, :title, :correct?).new(2, "React Maker", false),
            Struct.new(:id, :title, :correct?).new(3, "Next Builder", false),
            Struct.new(:id, :title, :correct?).new(4, "CRA Builder", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "Qual hook é usado para estado em componentes funcionais?",
          [
            Struct.new(:id, :title, :correct?).new(1, "useState", true),
            Struct.new(:id, :title, :correct?).new(2, "useEffect", false),
            Struct.new(:id, :title, :correct?).new(3, "useReducer", false),
            Struct.new(:id, :title, :correct?).new(4, "useContext", false)
          ]
        )
      ]
    else
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual comando gera um model no Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "rails generate model", true),
            Struct.new(:id, :title, :correct?).new(2, "rails new model", false),
            Struct.new(:id, :title, :correct?).new(3, "rails create model", false),
            Struct.new(:id, :title, :correct?).new(4, "rails make model", false)
          ]
        )
      ]
    end

    answers = params[:answers] || {}
    
    # Debug para identificar o problema
    Rails.logger.info "=== QUIZ SUBMIT DEBUG ==="
    Rails.logger.info "Full params: #{params.inspect}"
    Rails.logger.info "Answers: #{answers.inspect}"
    Rails.logger.info "Answers class: #{answers.class}"
    Rails.logger.info "Answers keys: #{answers.keys.inspect}"
    Rails.logger.info "Answers values: #{answers.values.inspect}"
    
    history_struct = Struct.new(:question_enunciation, :selected_option_title, :correct, :correct_option_title)

    histories = questions.map do |q|
      # Acessar a resposta de forma mais robusta
      selected_id = nil
      
      # Tentar diferentes formas de acessar a resposta
      if answers[q.id.to_s].present?
        selected_id = answers[q.id.to_s].to_i
        Rails.logger.info "Question #{q.id}: Found answer via string key: #{selected_id}"
      elsif answers[q.id].present?
        selected_id = answers[q.id].to_i
        Rails.logger.info "Question #{q.id}: Found answer via integer key: #{selected_id}"
      else
        Rails.logger.info "Question #{q.id}: No answer found"
      end
      
      selected_opt = q.question_options.find { |opt| opt.id == selected_id }
      correct_opt = q.question_options.find { |opt| opt.correct? }

      # Verificar se a resposta está correta
      is_correct = selected_opt && correct_opt && selected_opt.id == correct_opt.id

      Rails.logger.info "Question #{q.id}: Selected: #{selected_opt&.title}, Correct: #{correct_opt&.title}, Is Correct: #{is_correct}"

      history_struct.new(
        q.enunciation,
        selected_opt&.title || "(não respondida)",
        is_correct,
        correct_opt&.title
      )
    end

    correct_count = histories.count { |h| h.correct }
    total = questions.length
    score = ((correct_count.to_f / total) * 100).round

    grade = if score >= 90
      "A"
    elsif score >= 80
      "B"
    elsif score >= 60
      "C"
    elsif score >= 40
      "D"
    else
      "F"
    end

    session[:last_quiz_results] = {
      questionnaire_id: id,
      user_result: { score: score, grade: grade, submitted_at: Time.current },
      user_answer_histories: histories.map { |h| { question_enunciation: h.question_enunciation, selected_option_title: h.selected_option_title, correct: h.correct, correct_option_title: h.correct_option_title } }
    }

    # Debug: mostrar resultados antes do redirecionamento
    Rails.logger.info "=== RESULTADOS FINAIS ==="
    Rails.logger.info "Correct Count: #{correct_count}"
    Rails.logger.info "Total: #{total}"
    Rails.logger.info "Score: #{score}"
    Rails.logger.info "Grade: #{grade}"
    
    redirect_to quiz_results_path(id), notice: 'Quiz enviado com sucesso!'
  end

  def results
    id = params[:id].to_i

    questionnaires_data = {
      1 => { title: 'Ruby on Rails', code: 'ROR' },
      2 => { title: 'JavaScript', code: 'JS' },
      3 => { title: 'Python', code: 'PY' },
      4 => { title: 'React', code: 'REACT' }
    }

    data = questionnaires_data[id] || { title: 'Ruby on Rails', code: 'ROR' }

    # Duração e total refletem o questionário atual (5 questões)
    @questionnaire = Struct.new(:id, :title, :code, :duration, :total_questions).new(id, data[:title], data[:code], '10 min', 5)

    # Carrega resultados completos da sessão, montados em submit
    if session[:last_quiz_results]&.dig(:questionnaire_id) == id
      user_result = session[:last_quiz_results][:user_result]
      histories = session[:last_quiz_results][:user_answer_histories]

      @user_result = Struct.new(:score, :grade, :submitted_at).new(user_result[:score], user_result[:grade], user_result[:submitted_at])

      answer_history_struct = Struct.new(:question_enunciation, :selected_option_title, :correct, :correct_option_title)
      @user_answer_histories = histories.map do |h|
        answer_history_struct.new(h[:question_enunciation], h[:selected_option_title], h[:correct], h[:correct_option_title])
      end
    else
      # fallback mock simples quando não há dados na sessão
      @user_result = Struct.new(:score, :grade, :submitted_at).new(0, 'F', Time.current)
      @user_answer_histories = []
    end
  end

  # Método de teste para simular submissão real
  def test_submit
    # Simular exatamente o que acontece no método submit real
    id = 1
    answers = { "1" => "1", "2" => "1", "3" => "1", "4" => "1", "5" => "1" }
    
    # Usar a mesma lógica do método submit real
    questions = case id
    when 1 # Ruby on Rails
      [
        Struct.new(:id, :enunciation, :question_options).new(
          1, "Qual comando gera um model no Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "rails generate model", true),
            Struct.new(:id, :title, :correct?).new(2, "rails new model", false),
            Struct.new(:id, :title, :correct?).new(3, "rails create model", false),
            Struct.new(:id, :title, :correct?).new(4, "rails make model", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          2, "Qual é o padrão de arquitetura do Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "MVC", true),
            Struct.new(:id, :title, :correct?).new(2, "MVVM", false),
            Struct.new(:id, :title, :correct?).new(3, "MVP", false),
            Struct.new(:id, :title, :correct?).new(4, "Clean", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          3, "Onde você define as rotas no Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "config/routes.rb", true),
            Struct.new(:id, :title, :correct?).new(2, "app/routes.rb", false),
            Struct.new(:id, :title, :correct?).new(3, "lib/routes.rb", false),
            Struct.new(:id, :title, :correct?).new(4, "routes/config.rb", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          4, "Qual comando inicia o servidor Rails?",
          [
            Struct.new(:id, :title, :correct?).new(1, "bin/rails server", true),
            Struct.new(:id, :title, :correct?).new(2, "rails start", false),
            Struct.new(:id, :title, :correct?).new(3, "rails run", false),
            Struct.new(:id, :title, :correct?).new(4, "ruby server.rb", false)
          ]
        ),
        Struct.new(:id, :enunciation, :question_options).new(
          5, "Qual é a função do ActiveRecord?",
          [
            Struct.new(:id, :title, :correct?).new(1, "Mapear objetos para tabelas do banco", true),
            Struct.new(:id, :title, :correct?).new(2, "Gerenciar assets front-end", false),
            Struct.new(:id, :title, :correct?).new(3, "Servir arquivos estáticos", false),
            Struct.new(:id, :title, :correct?).new(4, "Enviar emails", false)
          ]
        )
      ]
    end

    history_struct = Struct.new(:question_enunciation, :selected_option_title, :correct, :correct_option_title)

    histories = questions.map do |q|
      # Acessar a resposta de forma mais robusta
      selected_id = nil
      
      # Tentar diferentes formas de acessar a resposta
      if answers[q.id.to_s].present?
        selected_id = answers[q.id.to_s].to_i
      elsif answers[q.id].present?
        selected_id = answers[q.id].to_i
      end
      
      selected_opt = q.question_options.find { |opt| opt.id == selected_id }
      correct_opt = q.question_options.find { |opt| opt.correct? }

      # Verificar se a resposta está correta
      is_correct = selected_opt && correct_opt && selected_opt.id == correct_opt.id

      history_struct.new(
        q.enunciation,
        selected_opt&.title || "(não respondida)",
        is_correct,
        correct_opt&.title
      )
    end

    correct_count = histories.count { |h| h.correct }
    total = questions.length
    score = ((correct_count.to_f / total) * 100).round

    grade = if score >= 90
      "A"
    elsif score >= 80
      "B"
    elsif score >= 60
      "C"
    elsif score >= 40
      "D"
    else
      "F"
    end

    render json: {
      correct_count: correct_count,
      total: total,
      score: score,
      grade: grade,
      histories: histories.map { |h| { 
        correct: h.correct, 
        selected: h.selected_option_title,
        correct_answer: h.correct_option_title
      } }
    }
  end

  # Método de teste para debug
  def test_debug
    # Simular dados de teste com múltiplas perguntas
    test_answers = { "1" => "1", "2" => "1", "3" => "1", "4" => "1", "5" => "1" }
    
    # Simular 5 perguntas (como no quiz real)
    questions = [
      Struct.new(:id, :enunciation, :question_options).new(
        1, "Qual comando gera um model no Rails?",
        [
          Struct.new(:id, :title, :correct?).new(1, "rails generate model", true),
          Struct.new(:id, :title, :correct?).new(2, "rails new model", false),
          Struct.new(:id, :title, :correct?).new(3, "rails create model", false),
          Struct.new(:id, :title, :correct?).new(4, "rails make model", false)
        ]
      ),
      Struct.new(:id, :enunciation, :question_options).new(
        2, "Qual é o padrão de arquitetura do Rails?",
        [
          Struct.new(:id, :title, :correct?).new(1, "MVC", true),
          Struct.new(:id, :title, :correct?).new(2, "MVVM", false),
          Struct.new(:id, :title, :correct?).new(3, "MVP", false),
          Struct.new(:id, :title, :correct?).new(4, "Clean", false)
        ]
      ),
      Struct.new(:id, :enunciation, :question_options).new(
        3, "Onde você define as rotas no Rails?",
        [
          Struct.new(:id, :title, :correct?).new(1, "config/routes.rb", true),
          Struct.new(:id, :title, :correct?).new(2, "app/routes.rb", false),
          Struct.new(:id, :title, :correct?).new(3, "lib/routes.rb", false),
          Struct.new(:id, :title, :correct?).new(4, "routes/config.rb", false)
        ]
      ),
      Struct.new(:id, :enunciation, :question_options).new(
        4, "Qual comando inicia o servidor Rails?",
        [
          Struct.new(:id, :title, :correct?).new(1, "bin/rails server", true),
          Struct.new(:id, :title, :correct?).new(2, "rails start", false),
          Struct.new(:id, :title, :correct?).new(3, "rails run", false),
          Struct.new(:id, :title, :correct?).new(4, "ruby server.rb", false)
        ]
      ),
      Struct.new(:id, :enunciation, :question_options).new(
        5, "Qual é a função do ActiveRecord?",
        [
          Struct.new(:id, :title, :correct?).new(1, "Mapear objetos para tabelas do banco", true),
          Struct.new(:id, :title, :correct?).new(2, "Gerenciar assets front-end", false),
          Struct.new(:id, :title, :correct?).new(3, "Servir arquivos estáticos", false),
          Struct.new(:id, :title, :correct?).new(4, "Enviar emails", false)
        ]
      )
    ]
    
    history_struct = Struct.new(:question_enunciation, :selected_option_title, :correct, :correct_option_title)
    
    histories = questions.map do |q|
      selected_id = test_answers[q.id.to_s]&.to_i
      selected_opt = q.question_options.find { |opt| opt.id == selected_id }
      correct_opt = q.question_options.find { |opt| opt.correct? }
      
      # Verificar se a resposta está correta
      is_correct = selected_opt && correct_opt && selected_opt.id == correct_opt.id
      
      history_struct.new(
        q.enunciation,
        selected_opt&.title || "(não respondida)",
        is_correct,
        correct_opt&.title
      )
    end
    
    correct_count = histories.count { |h| h.correct }
    total = questions.length
    score = ((correct_count.to_f / total) * 100).round
    
    grade = if score >= 90
      "A"
    elsif score >= 80
      "B"
    elsif score >= 60
      "C"
    elsif score >= 40
      "D"
    else
      "F"
    end
    
    render json: {
      correct_count: correct_count,
      total: total,
      score: score,
      grade: grade,
      histories: histories.map { |h| { 
        correct: h.correct, 
        selected: h.selected_option_title,
        correct_answer: h.correct_option_title
      } }
    }
  end
end