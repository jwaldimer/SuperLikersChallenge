require 'net/http'
require 'json'
require 'securerandom'

# Base URL for the hangman API
BASE_URL = 'http://127.0.0.1:9292'

# Call the try endpoint
def try_letter(game_id, letter)
  uri = URI("#{BASE_URL}/hangman/#{game_id}/try/#{letter}")
  response = Net::HTTP.get_response(uri)

  return JSON.parse(response.body) if response.code == '200'
end

# Call the endpoint to create a new game
def create_new_game(game_id)
  uri = URI("#{BASE_URL}/hangman/#{game_id}")
  response = Net::HTTP.get_response(uri)

  return JSON.parse(response.body) if response.code == '200'

  puts 'Error creating a new game...'

  nil
end

# Print the game response
def print_response(response)
  puts `clear`
  puts '****** Welcome to Hangman! ******'
  response.each { |key, value| puts "#{key.delete(':').capitalize}: #{value}" }
  puts '*********************************'
end

# Main game
def start_game
  game_id = SecureRandom.urlsafe_base64(3)
  game = create_new_game(game_id)
  return if game.nil?
  
  print_response(game)

  loop do
    print 'Enter a letter: '
    letter = gets.chomp
    next if letter.strip.empty?

    response = try_letter(game_id, letter.strip.chr)
    print_response(response)

    next if response[':state'] == 'playing'

    puts 'Congratulations, you have won!' if response[':state'] == 'win'
    puts 'Game over, you lose!' if response[':state'] == 'lose'
    puts '*********************************'

    break
  end
end

# Call the main method to start a game
start_game
