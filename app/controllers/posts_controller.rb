class PostsController < ApplicationController
  before_action :authenticate_user!, :except=>[:search]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(**post_params, user_id: current_user.id)
    if @post.save
      flash[:notice] = "新しいルームを登録をしました"
      redirect_to ("/reservations/#{@post.id}/rooms")
    else
      flash[:alert] = "ルームを登録できませんでした"
      render 'new'
    end
  end

  def show
    @posts = Post.where(user_id:current_user.id)
  end

  def kari
    @reservation = Reservation.find(params[:id])
  end

  def search
    if params[:area].present?
      @posts = Post.where('address LIKE ?', "%#{params[:area]}%")
      @area = params[:area]
    elsif params[:keyword].present?
      @posts = Post.where('syoukai LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
    @count = @posts.count
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to ('/posts/show')
  end

  private
   def post_params
     params.require(:post).permit(:name, :syoukai, :price, :address, :image)
   end
end


