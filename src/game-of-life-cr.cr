module Game::Of::Life::Cr
  VERSION = "0.1.0"

  class GameOfLife
    @board : Array(Array(Bool))
    def initialize(@width : Int32, @height : Int32)
        @board = Array.new(@height) { Array.new(@width, false) }
    end

    def init_board
        @board[2][2] = true
        @board[3][2] = true
        @board[4][2] = true
    end

    def make_turn
        new_board = Array.new(@height) { Array.new(@width, false) }
    
        @height.times do |y|
          @width.times do |x|
            alive_neighbors = count_alive_neighbors(x, y)
    
            if @board[y][x]
              new_board[y][x] = alive_neighbors == 2 || alive_neighbors == 3
            else
              new_board[y][x] = alive_neighbors == 3
            end
          end
        end
    
        @board = new_board
    end
    
    def get_board_str
        @board.map { |row| row.map { |cell| cell ? "■ " : "□ " }.join }.join("\n")
    end

    private def count_alive_neighbors(x : Int32, y : Int32)
        offsets = [-1, 0, 1]
        offsets.product(offsets).count do |dx, dy|
        next if dx == 0 && dy == 0
    
        neighbor_x = x + dx
        neighbor_y = y + dy
    
        if neighbor_x >= 0 && neighbor_x <= @width - 1 && 
            neighbor_y >= 0 && neighbor_y <= @height - 1
            @board[neighbor_y][neighbor_x]
        else
            false
        end
        end
    end
end

  game = GameOfLife.new(20, 20)
  game.init_board

  while true
      print "\e[2J" # Clear screen
      puts game.get_board_str
      game.make_turn
      sleep 0.5
  end
end
