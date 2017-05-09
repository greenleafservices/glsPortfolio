class PagesController < ApplicationController
  def home
    @posts = Blog.all
  end

  def about
    #about page will run from here
    @skills = Skill.all
  end

  def contact
  end
  
  def tech_news
    @tweets = SocialTool.twitter_search
  end
  
end
