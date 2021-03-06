require_relative "../skeleton/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder
    attr_reader :root_node, :board

    def initialize(pos)
        @pos = pos
        @board = Array.new(8){Array.new(8)} # poly tree
        @root_node = PolyTreeNode.new(pos)
        # self.build_move_tree
        @considered_positions = [pos]
    end

    def [](pos)
        x,y = pos
        @board[x][y]
    end

    def []=(pos,val)
        x,y = pos
        @board[x][y] = val
    end

    def self.valid_moves(pos)
        row, col = pos
        valids_filtered = []
    
        valids = [[row + 2, col - 1], [row + 2, col + 1], [row - 1, col + 2], [row - 1, col -2],         #limited rows: # 0, 1, 6, 7
        [row - 2, col + 1], [row - 2, col - 1], [row + 1, col - 2], [row + 1, col + 2]]             #limited cols   # 0, 1, 6, 7

        valids.each do |position|
            if !(position[0] < 0 || position[1] < 0) && !(position[0] > 7 || position[1] > 7)
             valids_filtered << position 
            end
        end
      valids_filtered
    end

    def new_move_positions(pos)
        valids = self.class.valid_moves(pos)
        new_positions = []

        valids.each do |position|
            if !@considered_positions.include?(position)
                @considered_positions << position
                new_positions << position
            end
        end
        new_positions

    end

    def build_move_tree
        pos = @root_node.value 
        until new_move_positions(pos).nil?
        children = new_move_positions(pos).map {|position| PolyTreeNode.new(position)}
        children.each do |child|
            pos.add_child(child)
        end
            pos = children.first
            children.shift

    end

    # def find_path

    # end


         
    

end

# # valid_moves = []
        # # (1..2).each do |row|
        # #     2.down_to(1).each do |col|
        # #         valid_moves << [row,col]

        #     end 
        # end
        
        # if (@root_node.value[0] + 2 == row || @root_node.value[0] - 2 == row) && (@root_node.value[1] + 1 == col || @root_node.value[1] - 1 == col)
        #     return row, col
            
        # elsif (@root_node.value[1] + 2 == row || @root_node.value[1] - 2 == row) && (@root_node.value[0] + 1 == col || @root_node.value[0] - 1 == col)
            
        #     return true
        # else
        #     return false
        # end   
