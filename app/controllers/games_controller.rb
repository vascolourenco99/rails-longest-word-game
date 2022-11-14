# frozen_string_literal: true

require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = generate_grid(10)
  end

  def score
    @user_input = params[:letter]
    @result = params[:grid]
    @english = check_if_word(@user_input)
    @onthegrid = on_the_grid(@user_input, @result)
  end

  def check_if_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized = URI.open(url).read
    parse = JSON.parse(serialized)
    parse['found']
  end

  def on_the_grid(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  private

  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    chars = ('a'..'z').to_a
    grid_size.times.map { chars.sample }.join
  end
end
