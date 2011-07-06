# coding: utf-8
module <%= class_name %>Helper
  # mobile用のanalyticsタグ
  def ga_url
    options = {
      :utmac => "<%= tracker_code %>",
      :utmn => rand(0x7fffffff),
      :utmr => request.referer.blank? ? '-' : u(request.referer),
      :utmp => u(request.fullpath),
      :guid => 'ON'
    }
    # TODO Rewrite url adapted to your routes.rb
    # Example:
    #   return ga_url(options)
    return "#"
  end
end
