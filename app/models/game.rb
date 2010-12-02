class Game < ActiveRecord::Base
	has_many :scores
  
  def winning_score
    Score.where(:game_id => id).maximum("points")
  end
  
  def winner
    Score.where(:game_id => id).where(:points => winning_score).first
  end
end
