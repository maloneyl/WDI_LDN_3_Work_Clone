class PostsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :normalize_params, only: [:create, :update] # need this to clean up stuff sent from Ember before creating/saving anything

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    authorize! :read, Post

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    authorize! :read, @post

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  # def new
  #   @post = Post.new

  #   respond_to do |format|
  #     format.html # new.html.erb
  #     format.json { render json: @post }
  #   end
  # end

  # # GET /posts/1/edit
  # def edit
  #   @post = Post.find(params[:id])
  # end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build params[:post] # push new post to current user's array of posts
    authorize! :create, @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    authorize! :update, @post

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def normalize_params
    params[:post] = params[:post].slice(:title, :body) # grab only what we want

    # ||= below to leave content as is IF there's content as a key in the API (could be someone else's API where they've named it content)
    params[:post][:content] ||= params[:post].delete(:body) # before stuff gets deleted, it gets returned first
  end

end
