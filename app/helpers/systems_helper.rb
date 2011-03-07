module SystemsHelper
  
  def a_to_z_links
    str = '<li>' + link_to("All", "/systems/#{@system.slug}/games") + '</li>'
    str += '<li>' + link_to("#", "/systems/#{@system.slug}/games/0-9") + '</li>'
    ("A".."Z").map { |l| str += '<li>' + link_to(l, "/systems/#{@system.slug}/games/#{l.downcase}") + '</li>' }
    raw str
  end
  
  
end
