class PostsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create]

  def new
  	@post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
  	if @post.save
  		flash[:success] = "Your post has been created successfully."
  		redirect_to root_url
  	else
  		flash[:danger] = "Something went wrong."
  		render 'new'
  	end
  end

  def index
  	@posts = Post.all
  end

  private

  def logged_in_user
  	unless logged_in?
  		flash[:danger] = "Please log in."
  		redirect_to login_url
  	end
  end

  private

  def post_params
  	params.require(:post).permit(:title, :content)
  end
end
