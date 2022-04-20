class UsersController < ApplicationController
    #getting the users data from the backend into state when the page first loads 
    # skip_before_action :authorized, only: [:create]
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity


    #GET '/user'
    def index 
      render json: User.all
    end


    def show
      current_user = User.find(session[:user_id])
      render json: current_user
    end


    def create 
      user = User.create!(user_params)
      render json: user
    end

    private 


    def render_unprocessable_entity(invalid)
      render json: {error: invlaid.record.errors}, status: :unprocessable_entity
    end

    def user_params 
      params.permit(:username, :password)
    end


    #strong param to authorize certain users to acess the page 
    def authorized
      return render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
    end



  end