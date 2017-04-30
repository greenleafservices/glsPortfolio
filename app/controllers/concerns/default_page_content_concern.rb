module DefaultPageContentConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_page_defaults
  end

  def set_page_defaults
    @page_title = "SQL Portfolio | My Portfolio Website"
    #@seo_keywords = "Green Leaf Services portfolio"
  end
end