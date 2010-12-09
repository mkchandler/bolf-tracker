class Player < ActiveRecord::Base
	has_many :scores
  
  @games_won = 0
  
  def games_won
    @games_won = 0
    
    Game.all.each do |g|
      if g.winner.player.id == id
        @games_won += 1
      end
    end
    
    return @games_won
  end
  
  def games_lost
    num_of_games - games_won
  end
  
  def num_of_games
    Score.where(:player_id => id).count
  end
  
  def eligible?
    
  end
  
  def points
    Score.where(:player_id => id).sum("points")
  end
  
  def points_per_game
    if (num_of_games.nil? or num_of_games.zero?)
      return 0
    else
      return (points.to_f / num_of_games.to_f).ceil
    end
  end
  
  def winning_pct
    if (num_of_games.nil? or num_of_games.zero?)
      return 0
    else
      return games_won.to_f / num_of_games.to_f
    end
  end
end