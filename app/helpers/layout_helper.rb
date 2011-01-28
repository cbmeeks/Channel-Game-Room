module LayoutHelper
  
  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end
  
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = h(show_title)
  end
  
end