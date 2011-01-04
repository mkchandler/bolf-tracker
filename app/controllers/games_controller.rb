class GamesController < ApplicationController
    # GET /games  
    def index
        @games = Game.where(:created_at => (Date.new(2011,01,01)..Date.new(2011,02,01)))
        #Game.find(:all, :order => "id desc", :limit => 10)

        @games.each do |g|
            g.calculate_fields
        end
    end

    # GET /games/1  
    def show
        @game = Game.find(params[:id])
        @game.calculate_fields

        @players = Player.all
        @players.sort! { |a,b| a.name <=> b.name }
    end

    # GET /games/new  
    def new
        @game = Game.new
    end

    # GET /games/1/edit
    def edit
        @game = Game.find(params[:id])
    end

    # POST /games  
    def create
        @game = Game.new(params[:game])

        if @game.save
            redirect_to(@game, :notice => 'Game was successfully created.')        
        else
            render :action => "new"        
        end      
    end

    # PUT /games/1  
    def update
        @game = Game.find(params[:id])

        if @game.update_attributes(params[:game])
            redirect_to(@game, :notice => 'Game was successfully updated.')        
        else
            render :action => "edit"        
        end
    end

    # DELETE /games/1  
    def destroy
        @game = Game.find(params[:id])
        @game.destroy

        @scores = Score.where(:game_id => params[:id])

        @scores.each do |score|
            score.destroy
        end

        redirect_to(games_url)
    end
end
