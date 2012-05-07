# -*- coding: utf-8 -*-
module NudeReportsHelper
  def gchart_legend_url(nude_report)
    gchart_url = nil
    legend = [nude_report.a, nude_report.b]
    legend = legend + [nude_report.c] unless nude_report.c.blank?
    legend = legend + [nude_report.d] unless nude_report.d.blank?
    colors = ["FF8E8E",",E697E6",",9999FF",",FFC848"]
    if nude_report.d.blank?
      colors.pop
      if nude_report.c.blank?
        colors.pop
      end
    end
    colors_string = ''
    colors.each do |color|
      colors_string = colors_string + color 
    end
    legend_size = 0
    legend.each do |seg_legend|
      legend_size = legend_size + seg_legend.length
      legend_size = legend_size + 2
    end
    if legend_size > 50
      size ='400x60'
    elsif legend_size > 28
      size ='400x40'
    else
      size ='400x20'  
    end
    gchart_url = Gchart.pie(:size => size,  :legend => legend, :bar_colors => colors_string)
    gchart_url = gchart_url + '&chdls=333333,15&chdlp=b'
    image_tag(gchart_url)
  end
  
  def gchart_url(report_analysis, type, nude_report)
    gchart_url = nil 
    # tmp_analysis = [] 
    # tmp_analysis = tmp_analysis + report_analysis
    tmp_analysis = report_analysis
    if type =='big'
      size = '300x200'
    elsif type =='middle'
      size = '200x140'
    elsif type == 'short'
      size = '180x100'
    else
      size = '150x100'
    end
    legend = [nude_report.a, nude_report.b]
    legend = legend + [nude_report.c] unless nude_report.c.blank?
    legend = legend + [nude_report.d] unless nude_report.d.blank?  
    if type =='short'
      legend = nil
    end
    colors = ["FF8E8E",",E697E6",",9999FF",",FFC848"]
    if nude_report.d.blank?
      tmp_analysis.pop
      colors.pop
      if nude_report.c.blank?
        tmp_analysis.pop
        colors.pop
      end
    end
    colors_string = ''
    colors.each do |color|
      colors_string = colors_string + color 
    end
    labels = []
    ratios = NudeReport.ratio_compute(tmp_analysis)
    ratios.each do |ratio|
      labels.push(ratio.to_s+'%')
    end
    gchart_url = Gchart.pie(:data => tmp_analysis,:size => size, :labels => labels,  :legend => legend, :bar_colors => colors_string)
    if type == 'big'
      gchart_url = gchart_url + '&chdls=333333,15&chp=4.7&chdlp=b'
    else
      gchart_url = gchart_url + '&chdls=333333,12&chp=4.7&chdlp=b'
    end
    
    total_count = NudeReport.total_count(tmp_analysis)
    if total_count >= 3 || type == 'big'
      image_tag(gchart_url) 
    else
      "응답수가 부족합니다"
    end  
  end
  
  def sns_q_string(nude_report)
    if nude_report.category
      mention = "[#{nude_report.category.name}] " + nude_report.title + "  ||  "
      mention = mention + sns_a_string(nude_report)  
    end
  end
  
  def sns_a_string(nude_report)
    ret = ''
    short_answer = short_answer(nude_report)
    unless short_answer.blank?
      ret = "#{short_answer.first} '#{short_answer.second.to_s}%', '#{short_answer.third}' 선택"
    end
    ret
  end
  
  def show_report_analysis(nude_report)
    @user_complete = (nude_report.man_vote_count >= 1000 && ActiveSupport::JSON.decode(cookies["tmp_user"])["gender"] == '남자') || (nude_report.woman_vote_count >= 1000 && ActiveSupport::JSON.decode(cookies["tmp_user"])["gender"] == '여자') if cookies["tmp_user"]
    if !(Vote.where("uniq_key = ? AND nude_report_id = ?", cookies["uniq_key"], nude_report.id).first.blank?) || @user_complete
      report_analysis = nude_report.report_analysis_count 
      render :partial => '/nude_reports/report_analysis', :locals => {:report_analysis => report_analysis, :nude_report => nude_report } 
    end 
  end
  
  def short_answer(nude_report)
    analysis = nude_report.report_analysis_count
    top_ratio = 0
    return_array = []
    if 3 <= NudeReport.total_count(analysis['total'])
      target = "전체"
      final_top_ratio = nil
      answer = nil
      top_ratio = NudeReport.top_ratio(NudeReport.ratio_compute(analysis['total']))
      final_top_ratio = top_ratio.first
      answer = nude_report.return_answer(top_ratio.second)
      
      inner_short_answer = inner_short_answer('남자', nude_report, final_top_ratio, analysis['gender']['man'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer  
      
      inner_short_answer = inner_short_answer('여자', nude_report, final_top_ratio, analysis['gender']['woman'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('10대', nude_report, final_top_ratio, analysis['age']['10'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('20대', nude_report, final_top_ratio, analysis['age']['20'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('30대', nude_report, final_top_ratio, analysis['age']['30'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('40대', nude_report, final_top_ratio, analysis['age']['40'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('10대 남자', nude_report, final_top_ratio, analysis['gender_age']['man']['10'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('20대 남자', nude_report, final_top_ratio, analysis['gender_age']['man']['20'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('30대 남자', nude_report, final_top_ratio, analysis['gender_age']['man']['30'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('40대 남자', nude_report, final_top_ratio, analysis['gender_age']['man']['40'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('10대 여자', nude_report, final_top_ratio, analysis['gender_age']['woman']['10'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('20대 여자', nude_report, final_top_ratio, analysis['gender_age']['woman']['20'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('30대 여자', nude_report, final_top_ratio, analysis['gender_age']['woman']['30'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      inner_short_answer = inner_short_answer('40대 여자', nude_report, final_top_ratio, analysis['gender_age']['woman']['40'] )
      target, final_top_ratio, answer = inner_short_answer.first, inner_short_answer.second, inner_short_answer.third if inner_short_answer
      
      return_array = [target, final_top_ratio, answer]
    end 
    return_array
  end
  
  def inner_short_answer(target_string,nude_report,final_top_ratio, anaylsis_array)
    ret = nil
    if 3 <= NudeReport.total_count(anaylsis_array)
      top_ratio = NudeReport.top_ratio(NudeReport.ratio_compute(anaylsis_array))
      if final_top_ratio < top_ratio.first
        target = target_string
        final_top_ratio = top_ratio.first
        answer = nude_report.return_answer(top_ratio.second)
        ret = [target, final_top_ratio, answer]
      end
    end
    ret
  end
  
end