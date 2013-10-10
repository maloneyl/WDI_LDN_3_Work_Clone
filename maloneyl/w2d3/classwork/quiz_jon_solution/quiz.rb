require 'pry'
require 'sinatra'
require 'sinatra/contrib/all'

enable :sessions

set :questions, {
  1 => ["Ruby is an 'interpreted' language?", true],
  2 => ["Everything in ruby is an object?", true],
  3 => ["The code <pre><code>2+2</code></pre> gives the result <pre><code>5</code></pre>", false]
}

set :num_questions, settings.questions.length

get '/' do
  session['answers'] = {} # initialize the session storage
  erb :welcome
end

get '/questions/:question_id' do
  record_answer
  @question_id = params[:question_id].to_i
  @question = settings.questions[@question_id].first
  next_page = if @question_id >= settings.num_questions
    @next_path = "/result"
  else
    @next_path = "/questions/#{@question_id + 1}"
  end
  erb :question
end

get "/result" do
  record_answer
  @score = calculate_score
  @num_questions = settings.num_questions
  erb :result
end

private

def record_answer
  answered_question_id = params[:answered_question_id].to_i
  answer = params[:answer]
  if answered_question_id && answer
    session['answers'][answered_question_id] = answer
  end
end

def calculate_score
  session['answers'].reduce(0) do |score, (qid, ans)| #NOTE use of array assignment via (qid, ans)
    if ans == settings.questions[qid].last.to_s
      score += 1
    else
      score
    end
  end
end
