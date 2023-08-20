class InputOutput

    attr_reader :player_one_name, :player_two_name

    def displayGame(game)
        game.board.each do |row|
            puts row.inspect
        end
    end

    def getInput(game, player, player_name)  

        puts "Enter a Row"
        @row = gets.chomp
        puts "Enter a Column"
        @col = gets.chomp

        if checkInput?(game, @row.to_i, @col.to_i, player, player_name)
            game.updateBoard(game, @row.to_i, @col.to_i, player, player_name)
        else
            getInput(game, player, player_name)
        end
    end

    def checkInput?(game, row, column, player, player_name)

        unless row.between?(1,3) && column.between?(1,3)
            puts "Improper input, please enter a valid input"
            return false
        end

        unless game.board[row - 1][column - 1] == "/"
            puts "That location is taken!"
            return false
        end
        return true
    end

    def outputTurn(player)
        puts "#{player} it's your turn!"
    end

    def newPlayers()
        puts "Player 1, enter your name. You are x's"
        @player_one_name = gets.chomp

        puts "Player 2, enter your name. You are o's"
        @player_two_name = gets.chomp
        while @player_two_name == @player_one_name
            puts "Can't have the same name!\nPlease pick a new name!"
            @player_two_name = gets.chomp
        end

    end

end


class PlayGame

    attr_reader :board
   
    def createBoard()
        @board = Array.new(3) {Array.new(3, "/")}
        
    end
        
    def checkFill()
        if @turn == 9
            @winner = "draw"
        end
    end

    def updateBoard(game, row, column, player, player_name)
        if player_name == player.player_one_name
            game.board[row - 1][column - 1] = "x"
        else 
            game.board[row - 1][column - 1] = "o"
        end 
    end

    def checkWin

        @board.each do |row|
            @board.each do |col|
                if col.count("x") == 3
                    @winner = "x"
                elsif col.count("o") == 3
                    @winner = "o"
                end
            end
        end 
    
    
        @board.each_with_index do |row, row_index|
            row.each_with_index do |col, col_index|
                unless @board[row_index][col_index] == "/"
                        if ((@board[0][col_index] == @board[1][col_index]) && (@board[1][col_index] == @board[2][col_index]))
                        winning_col = col_index
                        if @board[0][winning_col] == "x"
                            @winner = "x"
                        elsif @board[0][winning_col] == "o"
                            @winner = "o"
                        end
                    end
                end
            end
        end
        


        unless @board[1][1] == "/" 
            if ((@board[0][0] == @board[1][1]) && (@board[1][1] == @board[2][2])) || ((@board[2][0] == @board[1][1]) && (@board[1][1] == @board[00][2]))
                if @board[1][1] == "x"
                    @winner = "x"
                elsif @board[1][1] == "o"
                    @winner = "o"
                end
            end            
        end  

    end  

    def startGame(gameobj, inputoutputobj)
        createBoard()
        inputoutputobj.newPlayers
        @turn = 0
        while @winner == nil 
            @turn +=1
            inputoutputobj.outputTurn(inputoutputobj.player_one_name)
            inputoutputobj.displayGame(gameobj)
            inputoutputobj.getInput(gameobj, inputoutputobj, inputoutputobj.player_one_name)
            checkFill()
            checkWin()

            if @winner == nil
                @turn +=1
                inputoutputobj.outputTurn(inputoutputobj.player_two_name)
                inputoutputobj.displayGame(gameobj)
                inputoutputobj.getInput(gameobj, inputoutputobj, inputoutputobj.player_two_name)
                checkFill()
                checkWin()
            end
        end
        inputoutputobj.displayGame(gameobj)
        unless @winner == "draw"
            puts "#{@winner}'s have won!\n"
        else
            puts "It's a draw!"
        end
    end
end

inputoutput = InputOutput.new
game = PlayGame.new
game.startGame(game, inputoutput)















