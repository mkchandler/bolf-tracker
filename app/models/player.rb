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
  
    def calculate_fields(year, month)
        @games_won = 0
        
        date_range = (Date.new(year, month, 01) - 1.day)..(Date.new(year, month, 01) + 1.month)
        
        @games = Game.where(:created_at => date_range)
        @games.each do |g|
            g.calculate_fields
            if g.winner.player.id == id
                @games_won += 1
            end
        end
        
        @num_of_games = 0
        @points = 0
        
        @num_of_games = Game.joins(:scores).where(:scores => { :player_id => id }, :created_at => date_range).count
        @points = Game.joins(:scores).where(:scores => { :player_id => id }, :created_at => date_range).sum("points")
    end
end