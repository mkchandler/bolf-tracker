class PlayersController < ApplicationController
    # GET /players  
    def index
        @players = Player.all
    end

    # GET /players/1  
    def show
        @player = Player.find(params[:id])
    end

    # GET /players/new  
    def new
        @player = Player.new
    end

    # GET /players/1/edit
    def edit
        @player = Player.find(params[:id])
    end

    # POST /players  
    def create
        @player = Player.new(params[:player])

        if @player.save
            redirect_to(@player, :notice => 'Player was successfully created.')
        else
            render :action => "new"
        end
    end

    # PUT /players/1  
    def update
        @player = Player.find(params[:id])

        if @player.update_attributes(params[:player])
            redirect_to(@player, :notice => 'Player was successfully updated.')
        else
            render :action => "edit"
        end
    end

    # DELETE /players/1  
    def destroy
        @player = Player.find(params[:id])
        @player.destroy

        redirect_to(players_url)      
    end
end
