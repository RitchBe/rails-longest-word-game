require "open-uri"
class WordsControllerController < ApplicationController
  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    array = ('A'..'Z').to_a
    grid_size.times.map { array.sample }
  end
  def game
    $start_time = Time.now
    @grid = generate_grid(9)
    $grid = @grid


  end

  def run_game(attempt, grid, start_time, end_time)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    if user["found"] == false
      pre_message = "Not an english word"
      pre_score = 0
    elsif attempt.upcase!.split("").all? { |e| grid.include?(e) & grid.delete(e) } == false
      pre_message = "Not in the grid"
      pre_score = 0
    else
      pre_time = (start_time - end_time).abs
      pre_message = "Well done!"
      pre_score = (user["length"] - (pre_time / 10)) * 1000
    end
      { time: pre_time, score: pre_score, message: pre_message }
end


  def score
    @attempt = params[:answer]

    $end_time = Time.now
    if @attempt == ''
      return false
    else
      @finalscore = run_game(@attempt, $grid, $start_time, $end_time)
      # details(@finalscore[:score])
      detail
    end
end

  private

  def detail
    if session[:average_score] != nil
  session[:average_score] += @finalscore[:score]
else
  session[:average_score] = 0
end

if session[:number_of_game] != nil
  session[:number_of_game] += 1
else
  session[:number_of_game] = 1
end

  # session[:total_score] += @finalscore[:score]
  @average = (session[:average_score] / session[:number_of_game]).to_i
  end
end
