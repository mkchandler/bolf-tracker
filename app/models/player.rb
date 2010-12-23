class Player < ActiveRecord::Base
    has_many :scores
  
    attr_reader :games_won, :num_of_games, :points
  
    def games_lost
        num_of_games - games_won
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
  
    def calculate_fields
        @games_won = 0
        
        Game.all.each do |g|
            g.calculate_fields
            if g.winner.player.id == id
                @games_won += 1
            end
        end
        
        @num_of_games = 0
        @points = 0
        
        @num_of_games = Score.where(:player_id => id).count
        @points = Score.where(:player_id => id).sum("points")
    end
end