class ScoresController < ApplicationController
    # GET /scores  
    def index
        @scores = Score.all
    end

    # GET /scores/1  
    def show
        @score = Score.find(params[:id])
    end

    # GET /scores/new  
    def new
        @score = Score.new
    end

    # GET /scores/edit
    def edit
        @score = Score.find(params[:id])
    end

    # POST /scores  
    def create
        @game = Game.find(params[:game_id])
        @score = @game.scores.create!(params[:score])

        if @score.save
            redirect_to(game_url(params[:game_id]))
        else
            render :new
        end
    end

    # PUT /scores/1  
    def update
        @score = Score.find(params[:id])
        @score.points = params[:points]
    
        if @score.save
            redirect_to(game_url(params[:game_id]))
        else
            render :edit
        end
    end

    # DELETE /scores/1  
    def destroy
        @score = Score.find(params[:id])
        @score.destroy
    
        redirect_to(game_url(params[:game_id]))
    end
end