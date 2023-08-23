require 'yaml'

class Game

    attr_reader :status, :guess_array, :incorrect_guess

    def load_dictionary()
        require 'csv'
        word_options = []
        i = 0
        CSV.foreach("google-10000-english-no-swears.csv") do |line|
            line.each do |word|
                if word.length.between?(5, 12)
                    word_options[i] = word
                    i += 1
                end
            end 
        end
        word_options
    end

    def choose_random_word(word_options)
        @chosen_word = word_options[rand(0...word_options.length)]
        puts "The word is #{@chosen_word.length} letters long!"
        @chosen_word
    end

    def initialize_variables()
        @chosen_word = choose_random_word(load_dictionary())
        @guess_array = []
        @incorrect_guess = 0
        @output_string = "_" * @chosen_word.length
        @status = ""
    end

    def output()
        i = 0
        until i == @chosen_word.length 
            if @chosen_word[i] == @guess
                @output_string[i] = @guess
            end
            i += 1
        end
        puts @output_string
    end

    def check_guess()
        if @guess.length != 1
            puts "You can't enter more than one character, try again!"
            get_guess() 
        elsif !/[a-zA-Z]/.match(@guess)
            puts "You must enter a letter, try again!"
            get_guess()
        elsif @guess_array.include? @guess
            puts "You've already guessed this letter!"
            get_guess()
        elsif @chosen_word.include? @guess
            @guess_array.push(@guess)
            puts "#{@guess} is in the word!"
            puts "List of guesses: #{@guess_array.join(", ")}"
            true
        else
            @guess_array.push(@guess)
            @incorrect_guess += 1
            puts "#{@guess} is not in the word!"
            puts "List of guesses: #{@guess_array.join(", ")}"
            puts "You have #{8 - @incorrect_guess} incorrect guess(es) remaining!"
            false
        end
    end

    def get_guess()
        puts "Enter your guess!"
        @guess = gets.chomp.downcase.strip 
        check_guess()
    end

    def save_or_guess()
        puts "Would you like to save your game or guess a letter?"
        answer = gets.chomp.downcase.strip
        if answer == 'guess'
            get_guess()
        elsif answer == 'save'
            return 'save'
        else
            puts "Improper input, enter 'guess' or 'save'"
            save_or_guess()
        end
    end

    def check_game_status()
        if @incorrect_guess == 8
            @status = "lose"
        elsif @output_string == @chosen_word
            @status = "win"
        end
        game_end()
    end

    def game_end()
        if @status == "lose"
            puts "You lost the game! The word was '#{@chosen_word}'!"
            true
        elsif @status == "win"
            puts "You won the game! The word was '#{@chosen_word}'!"
            true
        end
        false
    end
end




def save_game(current_game)
  file_name = get_file_name
  return false unless file_name
  dump = YAML.dump(current_game)
  File.open(File.join(Dir.pwd, "/saved/#{file_name}.yaml"), 'w') { |file| file.write dump }
  puts "#{file_name}.yaml saved successfully"
  true
end

def get_file_name
  begin
    file_list = Dir.glob('saved/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))]}
    puts "Enter name for saved game"
    file_name = gets.chomp
    raise "#{file_name} already exists." if file_list.include?(file_name)
    file_name
  rescue StandardError => e
    puts "#{e} Are you sure you want to rewrite the file? (Yes/No)"
    answer = gets[0].downcase
    until answer == 'y' || answer == 'n'
      puts "Invalid input. #{e} Are you sure you want to rewrite the file? (Yes/No)"
      answer = gets[0].downcase
    end
    answer == 'y' ? file_name : nil
  end
end

def load_game()
  file_name = get_file_to_load
  loaded_game = YAML.safe_load(File.read("#{file_name}"))
  game.chosen_word = file['chosen_word']
  game.incorrect_guess = file['incorrect_guess']
  game.guess_array = file['guess_array']
end

def get_file_to_load()
      puts "Here are the current saved games. Please choose which you'd like to load."
      file_list = Dir.glob('saved/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
      if file_list.empty?
        puts "There are no saved games"
      else 
        puts file_list
      end 
      file_name = gets.chomp
      raise "#{file_name} does not exist." unless file_list.include?(file_name)
      puts "#{file_name}.yaml loading..."
      "saved/#{file_name}.yaml" 
end

def give_choice()  
    puts "Hangman. Would you like to: \n1) Start a new game\n2) Load a game"
  
    user_choice = gets.chomp
    until ['1', '2'].include?(user_choice)
        puts "Invalid input. Please enter 1 or 2"
        user_choice = gets.chomp
    end
    if user_choice == "1"
        play_game(Game.new)
    else
        load_game()
    end 
end

def play_game(game)
    game.initialize_variables
    game.output
    while game.status == "" 
        if game.save_or_guess() == 'save'
            if save_game(game)
                break
            end
        end
        game.output()
        game.check_game_status
    end
end


give_choice()






