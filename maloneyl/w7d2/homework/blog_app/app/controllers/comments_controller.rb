class CommentsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]
  load_and_authorize_resource

  #     post_comments GET    /posts/:post_id/comments(.:format)          comments#index
  #                   POST   /posts/:post_id/comments(.:format)          comments#create
  #  new_post_comment GET    /posts/:post_id/comments/new(.:format)      comments#new
  # edit_post_comment GET    /posts/:post_id/comments/:id/edit(.:format) comments#edit
  #      post_comment GET    /posts/:post_id/comments/:id(.:format)      comments#show
  #                   PUT    /posts/:post_id/comments/:id(.:format)      comments#update
  #                   DELETE /posts/:post_id/comments/:id(.:format)      comments#destroy

  # GET /comments
  # GET /comments.json
  # def index
  #   @post = Post.find(params[:post_id])
  #   @comments = @post.comments

  #   # respond_to do |format|
  #   #   format.html # index.html.erb
  #   #   format.json { render json: @comments }
  #   # end
  # end

  # GET /comments/1
  # GET /comments/1.json
  # def show
  #   @post = Post.find(params[:post_id])
  #   @comment = Comment.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @post }
  #   end
  # end

  # GET /comments/new
  # GET /comments/new.json
  # def new
  #   @comment = Comment.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @comment }
  #   end
  # end

  # # GET /comments/1/edit
  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params[:comment])
    @comment.post_id = @post.id
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' } # showing twice...why??
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @post, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(params[:post_id]) }
      format.json { head :no_content }
    end
  end
end
