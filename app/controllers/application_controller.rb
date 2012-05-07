class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :detect_browser
  
  MOBILE_BROWSERS = ["android", "iphone", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]
  
  def detect_browser
    if params[:view]
      if params[:view] == 'mobile'
        session[:view] = 'mobile'
        session[:browser] = nil
      elsif params[:view] == 'standard'
        session[:view] = 'standard'
        session[:browser] = nil
      end
      session[:view_force] = true
    else
      unless session[:view_force]
        if request.headers["HTTP_USER_AGENT"]
          agent = request.headers["HTTP_USER_AGENT"].downcase

          session[:view] = nil
          MOBILE_BROWSERS.each do |m|
            if agent.match(m)
              session[:view] = 'mobile'
              session[:browser] = m
            break
            end
          end

          #안드로이드 모바일웹 검출
          if session[:browser] == 'android'
            if ( request.headers["HTTP_USER_AGENT"].include?('CMAndroid') == false )
              session[:browser] = 'android-web'
            end
          end

          if agent.match('ipad')
            session[:view] = 'standard'
            session[:browser] = 'ipad'
          end
        end
        unless session[:view]
          session[:view] = 'standard'
          session[:browser] = nil
        end
      end
    end
  end
  
end
