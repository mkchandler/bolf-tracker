class Game < ActiveRecord::Base
	has_many :scores
    
    attr_reader :winning_score, :winner
    
    def calculate_fields
        @winning_score = Score.where(:game_id => id).maximum("points")
        @winner = Score.where(:game_id => id).where(:points => winning_score).first
    end
end