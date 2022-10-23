class TweetsController < ApplicationController
  def create
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    if session
      user = session.user
      @tweet = user.tweets.new(task_params)
      if @tweet.save!
        render json: {
          tweet: {
            username: user.username,
            message: @tweet.message
          }
        }
      else
        render json: {
          success: false
        }
      end
    end
  end

  def destroy
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    if session
      @tweet = Tweet.find_by(id: params[:id])

      if @tweet and @tweet.destroy!
        render json: { success: true }
      else
        render json: { success: false }
      end

    else
      render json: { success: false }
    end

  end

  def index
    @tweets = Tweet.all.order(created_at: :desc)
    render 'tweets/index'
  end

  def index_by_user
      user = User.find_by(username: params[:username])
      @tweets = user.tweets.all
      render 'tweets/index'
  end

  private
    def task_params
      params.require(:tweet).permit(:message)
    end

end
