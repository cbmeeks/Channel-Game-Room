module ApplicationHelper
  
  def url_id
    if params[:id].present?
      "http://#{request.env['HTTP_HOST']}/#{params[:controller]}/#{params[:id]}"
    else
      "http://#{request.env['HTTP_HOST']}/#{params[:controller]}"
    end
  end
  
end
