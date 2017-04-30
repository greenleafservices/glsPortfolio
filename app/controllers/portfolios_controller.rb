class PortfoliosController < ApplicationController
before_action :set_portfolio_item, only: [:edit, :show, :update, :destroy]
layout "portfolio_layout"
access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit, :sort] }, site_admin: :all

  def index
    @portfolio_items = Portfolio.by_position
    @page_title = "Portfolios"
  end

  def sort
    # using the sort array from the coffeescript file
    params[:order].each do |key, value|
      # rewrite each record in the database using the params from the new sort order
      # 0"=>{"id"=>"“5“", "newposition"=>"1"},
      # "1"=>{"id"=>"“2“", "newposition"=>"2"}, and so on
      Portfolio.find(value[:id]).update(position: value[:newposition])
    end

    # render nothing: true (deprecated)
    # render plain: 'OK'
    # Rails 5.1 way of rendering nothing
    head :created
  end

  def angular
      @angular_portfolio_items = Portfolio.angular
  end

  def new
    @portfolio_item = Portfolio.new
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: 'Your portfolio item is now live.' }
      else
        format.html { render :new }
      end
    end
  end
  def show
    #binding.pry
    #@portfolio_item = Portfolio.find(params[:id])
  end

  def edit
    #@portfolio_item = Portfolio.find(params[:id])
    # 3.times { @portfolio_item.technologies.build }
  end

  def update
    #@portfolio_item = Portfolio.find(params[:id])

    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html { redirect_to portfolios_path, notice: 'The record successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    # Perform the lookup
    #@portfolio_item = Portfolio.find(params[:id])


    # Destroy/delete the record
    @portfolio_item.destroy

    # Redirect
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Record was removed.' }
    end
  end

private

  def portfolio_params
    params.require(:portfolio).permit(:title,
                                      :subtitle,
                                      :main_image,
                                      :thumb_image,
                                      :body,
                                      technologies_attributes: [:id, :name, :_destroy]
                                      )
  end

  def set_portfolio_item
     @portfolio_item = Portfolio.find(params[:id])
  end
end

