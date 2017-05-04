module ApplicationHelper
  #before_action:set_copyright
  #before_action:set_repeatcopyright

  def login_helper style = ''
    if current_user.is_a?(GuestUser)
      #we have to put these together in one string because Ruby will only act on the last item is a logic arguments and,
      # without the concatenation of these two arguments, we'll never see the Register option
       (link_to "Register ", new_user_registration_path, class: style) + " ".html_safe + (link_to " Login", new_user_session_path, class: style)
    else
      link_to "Logout", destroy_user_session_path, method: :delete, class: style
    end
  end

  def source_helper(layout_name)
      if session[:source]
        greeting = "Thanks for visiting me from #{session[:source]} and you are on the #{layout_name} layout"
        content_tag(:p, greeting, class: "source-greeting")
      end
  end

  def copyright
    GlsViewTool::Renderer.copyright 'GreenLeafServices', 'All rights reserved'
  end


 def nav_items
      [
        {
          url: root_path,
          title: 'Home'
        },

        {
          url: about_me_path,
          title: 'About Me'
        },
        {
          url: contact_path,
          title: 'Contact'
        },
        {
          url: blogs_path,
          title: 'Blog'
        },
        {
          url: portfolios_path,
          title: 'Portfolio'
        },
        {
        url: tech_news_path,
        title: 'Tech News'
        },
      ]
  end
  def nav_helper style, tag_type
    nav_links = ''

    nav_items.each do |item|
      nav_links << "<#{tag_type}><a href='#{item[:url]}' class='#{style} #{active? item[:url]}'>#{item[:title]}</a></#{tag_type}>"
    end

    nav_links.html_safe
# nav_links = <<NAV
# <#{tag_type}><a href="#{root_path}" class="#{style} #{active? root_path}">Home</a></#{tag_type}>
# <#{tag_type}><a href="#{about_me_path}" class="#{style} #{active? about_me_path}">About</a></#{tag_type}>
# <#{tag_type}><a href="#{contact_path}" class="#{style} #{active? contact_path}">Contact</a></#{tag_type}>
# <#{tag_type}><a href="#{blogs_path}" class="#{style} #{active? blogs_path}">Blog</a></#{tag_type}>
# <#{tag_type}><a href="#{portfolios_path}" class="#{style} #{active? portfolios_path}">Portfolio</a></#{tag_type}>
# NAV
#   nav_links.html_safe
  end
end

def active? path
    "active" if current_page? path
end

def alerts
   alert = (flash[:alert] || flash[:error] || flash[:notice])

   if alert
     alert_generator alert
   end
 end

 def alert_generator msg
   js add_gritter(msg, title: "GLS Portfolio", sticky: false, time: 2000), extend_gritter(position: 'bottom_left')
   
   
   
end

