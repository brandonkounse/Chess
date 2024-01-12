# frozen_string_literal: true

require 'yaml'

# YAML methods to save and load game states
module Serialize
  def save(name)
    Dir.mkdir('./saves') unless Dir.exist?('./saves')
    File.new("./saves/#{name}.yml", 'w') unless File.exist?(name)
    File.open("./saves/#{name}.yml", 'w') { |file| file.write(state) }
  end

  def load_file(name)
    data = YAML.safe_load(File.read("./saves/#{name}"), permitted_classes: [Symbol])
    @board = data[:board]
    @player_white = data[:player_white]
    @player_black = data[:player_black]
  end

  def state
    YAML.dump(
      board: @board,
      player_white: @player_white,
      player_black: @player_black
    )
  end

  def saved_files
    files = {}
    Dir.children('./saves/').each_with_index { |file, index| files[index] = file }
    files
  end

  def choose_save
    puts "\nPlease select file by number: \n"
    saved_files.each_pair { |key, value| puts "#{key + 1}: #{value}" }
    input = gets.chomp
    @load = saved_files[input.to_i - 1]
    @load.nil? ? choose_save : @load
  end
end
