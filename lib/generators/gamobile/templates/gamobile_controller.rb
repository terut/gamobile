# coding: utf-8
require 'net/http'
Net::HTTP.version_1_2
class <%= class_name %>Controller < ApplicationController

  # Trackerのバージョン
  G_VERSION = '4.4sh'
  G_COOKIE_NAME = :__utmmobile

  # 利用するCookieのパス
  # 編集して使ってもいい
  G_COOKIE_PATH = '/'

  # 2年間
  G_COOKIE_USER_PERSISTENCE = 63072000

  # 1x1 透過GIF
  GIF_DATA = [ 0x47, 0x49, 0x46, 0x38, 0x39, 0x61,
               0x01, 0x00, 0x01, 0x00, 0x80, 0xff,
               0x00, 0xff, 0xff, 0xff, 0x00, 0x00,
               0x00, 0x2c, 0x00, 0x00, 0x00, 0x00,
               0x01, 0x00, 0x01, 0x00, 0x00, 0x02,
               0x02, 0x44, 0x01, 0x00, 0x3b ].pack('C*')
  
  # トラッキング 
  # サーバサイドでGoogle Analyticsへのリクエストを作る
  # responseは透過GIFのbyte data
  def ga
    time_stamp = Time.now.to_i
    domain_name = request.domain.blank? ?
      '' : request.domain
    
    # リファラーをutmrから取得
    document_referer = params[:utmr].blank? ?
      '-' : delete_trans_sid(URI.decode(params[:utmr]))
    document_path = params[:utmp].blank? ?
      '' : delete_trans_sid(URI.decode(params[:utmp]))
    account = params[:utmac]
    user_agent = request.user_agent.blank? ?
      '' : request.user_agent


    # visitorのcookieを取得
    cookie = cookies[G_COOKIE_NAME]
    guid_header = (request.mobile && request.mobile.ident) ?
      request.mobile.ident : ''

    # replace getVisitorId() of ga.php
    visitor_id = visitor_id(guid_header, account, user_agent, cookie) 
    
    # replace setrawcookie() of ga.php
    cookies[G_COOKIE_NAME] = {
      :value => visitor_id,
      :expire_after => time_stamp + G_COOKIE_USER_PERSISTENCE,
      :path => "/",
      :domain => domain_name
    } 
    
    utm_gif_location = "http://www.google-analytics.com/__utm.gif"

    queries = { :utmwv => G_VERSION,
                :utmn => random_num,
                :utmhn => ERB::Util.u(domain_name),
                :utmr => ERB::Util.u(document_referer),
                :utmp => ERB::Util.u(document_path),
                :utmac => account,
                :utmcc => "__utma%3D999.999.999.999.999.1%3B",
                :utmvid => visitor_id,
                :utmip => ip_add(request.remote_addr) } 
     
    uri = "#{utm_gif_location}?#{queries.to_query}"
    ext_headers = { "User-Agent" => user_agent,
                    "Accepts-Language" => request.accept_language }
    request_to_ga(uri, ext_headers)

    headers["X-GA-MOBILE-URL"] = uri unless params[:utmdebug].blank?

    headers["Cache-Control"] = "private, no-cache, no-cache=Set-Cookie, proxy-revalidate"
    headers["Pragma"] = "no-cache"
    headers["Expires"] = "Wed, 17 Sep 1975 21:32:10 GMT"
    send_data(GIF_DATA, :type => "image/gif", :disposition => "inline")
  end

  private
  
  # トラッキングリクエストを生成
  def request_to_ga(uri, opt)
    u = URI.parse(uri)
    begin
      Net::HTTP.start(u.host, u.port) do |http|
        http.read_timeout = 3
        http.get(u.request_uri, opt)
      end
    rescue Timeout::Error, StandardError =>e
      logger.debug "-----Send Request To Google Analytics-----"
      logger.debug uri.to_s
      logger.debug "------------------------------------------"
    end
  end

  # trans_sidを削除する
  def delete_trans_sid(str)
    if session_key.blank?
      return str.to_s
    else
      return str.to_s.gsub(/#{session_key}=[^&]*&?/, '')
    end
  end

  # visitor_idを生成する
  def visitor_id(guid, account, user_agent, cookie)
    
    return cookie unless cookie.blank?
     
    message = ''
  
    if guid.blank?
      message = "#{user_agent}#{Digest::SHA1.hexdigest(random_num)}#{Time.now.to_i}"
    else
      message = "#{guid}#{account}"
    end

    md5string = Digest::MD5.hexdigest(message)
    visitor_id = "0x#{md5string[0,16]}"
  end
 
  # ipアドレスを取得 
  def ip_add(address)
    
    return '' if address.blank?

    if address =~ /^([^.]+\.[^.]+\.[^.]+\.).*/
      return "#{$1}0"
    else
      return ''
    end
  end
  
  # randomな数字文字列を作成
  def random_num
    rand(0x7fffffff).to_s
  end
end
