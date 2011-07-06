# coding: utf-8
module <%= gamobile_class %>Helper
  # mobile用のanalyticsタグ
  def ga_url
    return mobile_ga_path(
      :utmac => <%= tracker_code %>,
      :utmn => rand(0x7fffffff),
      :utmr => request.referer.blank? ? '-' : u(request.referer),
      :utmp => u(request.fullpath),
      :guid => 'ON'
    )
  end
end
