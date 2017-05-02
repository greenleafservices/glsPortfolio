class BlogsController < ApplicationController
layout "blog_layout"
access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit, :toggle_status] }, site_admin: :all

  # GET /blogs
  # GET /blogs.json
  def index
    #binding.pry
    #@blogs = Blog.new_first
    @blogs = Blog.new_first.page(params[:page]).per(5)
    #byebug
    #@blogs = Blog.featured_blogs
    #binding.pry
    @page_title = "Blogs"
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.friendly.find(params[:id])
    @comment = Comment.new
    @page_title = @blog.title
    @seo_keywords = @blog.body
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.friendly.find(params[:id])
  end
  # POST /blogs

  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params) #these are the allowable fields - set below

    respond_to do |format|
      if @blog.save
        # any reference to @blog will mean the same as blog_path(@blog)
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        #format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        #format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    @blog = Blog.friendly.find(params[:id])
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        #format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        #format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog = Blog.friendly.find(params[:id])
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Entry was deleted' }
      format.json { head :no_content }
    end
  end

  def toggle_status
    @blog = Blog.friendly.find(params[:id])
    if @blog.published?
      @blog.draft!
    elsif @blog.draft?
      @blog.published!
    end
    redirect_to blogs_url, notice: 'Post status has been updated'
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body)
    end
end
