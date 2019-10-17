class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action :not_user_block, only: [:new]

  def index
    @feeds = Feed.all
  end

  def show
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    render :new if @feed.invalid?
  end

  def edit
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    if @feed.save
        redirect_to feeds_path, notice: '投稿を作成しました！'
    else
      render :new
    end
    @feed.user_id = current_user.id
  end

  def update
    if @feed.update(feed_params)
      redirect_to feeds_path, notice: '投稿を編集しました.'
    else
      render :edit
    end
  end

  def destroy
    @feed.destroy
    redirect_to feeds_path, notice: '投稿を削除しました。'
  end

  private
  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:image, :image_cache, :content)
  end

  def not_user_block
    if logged_in? == false
     redirect_to new_session_path
   end
 end
end
