class TopicsController < ApplicationController
  layout "topic_layout"
  def index
    if logged_in?(:site_admin)
      @topics = Topic.all.page(params[:page]).per(5)
    else
      redirect_to blogs_path, notice: "You are not authorized to access that page"
    end
    @page_title = "Blog Topics"
  end
 
  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_path, notice: 'Your topic is now available for use with blog posts.' }
      else
        format.html { render :new }
      end
    end
  end
  
  def update
    @topic = Topic.find(params[:id])
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topics_path, notice: 'Topic was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
    # Get the blogs associated with this topic using logged in status
    if logged_in?(:site_admin)
      @blogs = @topic.blogs.by_updated.page(params[:page]).per(5)
    else
      @blogs = @topic.blogs.published.by_updated.page(params[:page]).per(5)
    end
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_path, notice: 'Blog topic was removed.' }
    end
  end
  
    private
    def topic_params
      params.require(:topic).permit(:title)
    end
end
