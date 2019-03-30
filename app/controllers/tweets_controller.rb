class TweetsController < ApplicationController

  before_action :move_to_index, except: [:index, :show]

  def index
    @tweets = Tweet.all.order("id DESC")
  end

  def create
    @tweet = Tweet.new(create_params)
    if @tweet.save
      flash[:notice] = "ツイートを投稿しました。"
      redirect_to(root_path)
    else
      render(new_tweet_path)
    end
  end

  def new
    @tweet = Tweet.new
  end

  def edit
    @tweet = Tweet.find_by(id: params[:id])
  end

  def show
    @tweet = Tweet.find_by(id: params[:id])
  end

  def update
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.text = create_params[:text]
    if @tweet.save
      flash[:notice] = "ツイートを編集しました。"
      redirect_to(root_path)
    else
      render(edit_tweet)
    end
  end

  def destroy
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.destroy
    flash[:notice] = "ツイートを削除しました。"
    redirect_to(root_path)
  end

  private
  def create_params
    params.require(:tweet).permit(:text).merge(user_id: 1)
  end

  def move_to_index
    unless user_signed_in?
      flash[:notice] = "ログインしてください"
      redirect_to(root_path)
    end
  end

end
