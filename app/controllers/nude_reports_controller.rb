# -*- coding: utf-8 -*-
class NudeReportsController < ApplicationController
  # GET /nude_reports
  # GET /nude_reports.json
  @@DEFAULT_SCREEN = 'past'
  
  def index
    @screen = @@DEFAULT_SCREEN
    @screen = params[:screen] if params[:screen] 
    
    if @screen == 'today'
      @nude_reports = NudeReport.today.report_type('nude').order("end_at desc")
      @side_nude_reports = NudeReport.past.report_type('nude').order("woman_vote_count desc").limit(10)
    elsif @screen == 'past'
      @nude_reports = NudeReport.past.report_type('nude').order("woman_vote_count desc").limit(20)
      @side_nude_reports = NudeReport.today.report_type('nude').order("end_at desc").limit(10)
    elsif @screen == 'complete'
      @nude_reports = NudeReport.report_type('complete')
      @side_nude_reports = NudeReport.today.report_type('nude').order("end_at desc").limit(10)
    elsif @screen == 'request'
      @nude_reports = NudeReport.report_type('request').order("created_at desc")
      @side_nude_reports = NudeReport.today.report_type('nude').order("end_at desc").limit(10)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nude_reports }
    end
  end

  # GET /nude_reports/1
  # GET /nude_reports/1.json
  def show
    @nude_report = NudeReport.find(params[:id])
    if @nude_report.report_type == 'request'
      @screen = 'request'
      @side_nude_reports = NudeReport.today.report_type('nude').order("end_at desc").limit(10)
    elsif @nude_report.today?
      @screen = 'today'
      @side_nude_reports = NudeReport.past.report_type('nude').order("woman_vote_count desc").limit(10)
    else
      @screen = 'past'
      @side_nude_reports = NudeReport.today.report_type('nude').order("end_at desc").limit(10)
    end
    NudeReport.increment_counter(:check_count, @nude_report.id)
    @comments = Comment.where(:nude_report_id => @nude_report.id, :parent_id => nil).order("created_at")
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nude_report }
    end
  end

  # GET /nude_reports/new
  # GET /nude_reports/new.json
  def new
    if cookies["tmp_user"].blank?
      redirect_to '/nude_reports?screen=request', notice: '필수정보를 입력해 주세요' 
    else
      @nude_report = NudeReport.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @nude_report }
      end
    end
  end

  # GET /nude_reports/1/edit
  def edit
    @nude_report = NudeReport.find(params[:id])
    redirect_to @nude_report, notice: '잘못된 접근입니다' if @nude_report.type_nude? && current_user.blank?
  end

  # POST /nude_reports
  # POST /nude_reports.json
  def create
    @nude_report = NudeReport.new(params[:nude_report])
    @nude_report.report_type = 'request' if @nude_report.report_type.blank? || current_user.blank?
    tmp_user = ActiveSupport::JSON.decode(cookies["tmp_user"])
    @nude_report.gender = tmp_user['gender']
    @nude_report.age = tmp_user['age']
    @nude_report.save
    ReportImage.create(:image => params[:nude_report][:image_1], :position => 1 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_1]
    ReportImage.create(:image => params[:nude_report][:image_2], :position => 2 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_2]
    ReportImage.create(:image => params[:nude_report][:image_3], :position => 3 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_3]
    ReportImage.create(:image => params[:nude_report][:image_4], :position => 4 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_4]
    ReportImage.create(:image => params[:nude_report][:image_5], :position => 5 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_5]
    
    respond_to do |format|
      format.html { redirect_to @nude_report, notice: '완료되었습니다 ^^' }
      format.json { render json: @nude_report, status: :created, location: @nude_report }
    end
  end

  # PUT /nude_reports/1
  # PUT /nude_reports/1.json
  def update
    @nude_report = NudeReport.find(params[:id])
    
    if (report_image = @nude_report.report_images.first) && params[:nude_report][:image_1]
      report_image.update_attribute(:image, params[:nude_report][:image_1]) 
    elsif params[:nude_report][:image_1]
      ReportImage.create(:image => params[:nude_report][:image_1], :position => 1 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_1]
    end
    
    if (report_image = @nude_report.report_images.second) && params[:nude_report][:image_2]
      report_image.update_attribute(:image, params[:nude_report][:image_2]) 
    elsif params[:nude_report][:image_2]
      ReportImage.create(:image => params[:nude_report][:image_2], :position => 2 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_2]
    end
    
    if (report_image = @nude_report.report_images.third) && params[:nude_report][:image_3]
      report_image.update_attribute(:image, params[:nude_report][:image_3]) 
    elsif params[:nude_report][:image_3]
      ReportImage.create(:image => params[:nude_report][:image_3], :position => 3 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_3]
    end
    
    if (report_image = @nude_report.report_images.fourth) && params[:nude_report][:image_4]
      report_image.update_attribute(:image, params[:nude_report][:image_4]) 
    elsif params[:nude_report][:image_4]
      ReportImage.create(:image => params[:nude_report][:image_4], :position => 4 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_4]
    end
    
    if (report_image = @nude_report.report_images.fifth) && params[:nude_report][:image_5] 
      report_image.update_attribute(:image, params[:nude_report][:image_5])
    elsif params[:nude_report][:image_5]
      ReportImage.create(:image => params[:nude_report][:image_5], :position => 5 , :nude_report_id => @nude_report.id ) if params[:nude_report][:image_5]
    end
    
    respond_to do |format|
      if @nude_report.update_attributes(params[:nude_report])
        format.html { redirect_to @nude_report, notice: 'Nude report was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @nude_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nude_reports/1
  # DELETE /nude_reports/1.json
  def destroy
    @nude_report = NudeReport.find(params[:id])
    @nude_report.destroy

    respond_to do |format|
      format.html { redirect_to nude_reports_url }
      format.json { head :ok }
    end
  end
  
  def help
    respond_to do |format| 
      format.html
    end
  end
  
  def vote
    answer = params[:answer]
    nude_report_id = params[:nude_report_id].to_i
    remote_ip = request.env["HTTP_X_REAL_IP"] != nil ? request.env["HTTP_X_REAL_IP"] : request.env["REMOTE_ADDR"]
    tmp_user = ActiveSupport::JSON.decode(cookies["tmp_user"])
    nude_report = NudeReport.find(nude_report_id)
    
    message = nil
    if vote = Vote.where("uniq_key = ? AND nude_report_id = ?", cookies["uniq_key"], nude_report_id ).first
      lagacy_gender = vote.gender
      vote.update_attributes(:answer => answer, :gender => tmp_user["gender"], :age => tmp_user["age"][0..1].to_i)
      if lagacy_gender != vote.gender
        if lagacy_gender == '남자'
          nude_report.man_vote_count = nude_report.man_vote_count - 1;
          nude_report.woman_vote_count = nude_report.woman_vote_count + 1;
        else
          nude_report.man_vote_count = nude_report.man_vote_count + 1;
          nude_report.woman_vote_count = nude_report.woman_vote_count - 1;
        end
        nude_report.save
      end
      message = '다시 투표 되었습니다'
    else
      if tmp_user["gender"] == '남자'
        if nude_report.man_vote_count >= 1000
          message = '투표 마감'
        else
          Vote.create(:nude_report_id => nude_report_id, :answer => answer, :gender => tmp_user["gender"], :age => tmp_user["age"][0..1].to_i, :remote_ip => remote_ip, :uniq_key => cookies["uniq_key"] )
          NudeReport.increment_counter(:man_vote_count, nude_report_id)
          message = '투표가 정상 처리되었습니다. <br />질문을 공유해보는것은 어떨까요? ^^'  
        end
      else
        if nude_report.woman_vote_count >= 1000
          message = '투표 마감'
        else
          Vote.create(:nude_report_id => nude_report_id, :answer => answer, :gender => tmp_user["gender"], :age => tmp_user["age"][0..1].to_i, :remote_ip => remote_ip, :uniq_key => cookies["uniq_key"] )
          NudeReport.increment_counter(:woman_vote_count, nude_report_id)
          message = '투표가 정상 처리되었습니다. <br />질문을 공유해보는것은 어떨까요? ^^'  
        end
      end
    end
    
    report_analysis = nude_report.report_analysis_count
    content = render_to_string :partial => '/nude_reports/report_analysis', :locals => {:report_analysis => report_analysis, :nude_report => nude_report }
    
    respond_to do |format|
      format.json { render json: { "message"=> message, "content"=> content } } 
    end
  end
  
  def index_vote
    answer = params[:answer]
    nude_report_id = params[:nude_report_id].to_i
    remote_ip = request.env["HTTP_X_REAL_IP"] != nil ? request.env["HTTP_X_REAL_IP"] : request.env["REMOTE_ADDR"]
    tmp_user = ActiveSupport::JSON.decode(cookies["tmp_user"])
    nude_report = NudeReport.find(nude_report_id)
    
    message = nil
    if vote = Vote.where("uniq_key = ? AND nude_report_id = ?", cookies["uniq_key"], nude_report_id ).first
      lagacy_gender = vote.gender
      vote.update_attributes(:answer => answer, :gender => tmp_user["gender"], :age => tmp_user["age"][0..1].to_i)
      if lagacy_gender != vote.gender
        if lagacy_gender == '남자'
          nude_report.man_vote_count = nude_report.man_vote_count - 1;
          nude_report.woman_vote_count = nude_report.woman_vote_count + 1;
        else
          nude_report.man_vote_count = nude_report.man_vote_count + 1;
          nude_report.woman_vote_count = nude_report.woman_vote_count - 1;
        end
        nude_report.save
      end
      message = '다시 투표 되었습니다'
    else
      if tmp_user["gender"] == '남자'
        if nude_report.man_vote_count >= 1000
          message = '투표 마감'
        else
          Vote.create(:nude_report_id => nude_report_id, :answer => answer, :gender => tmp_user["gender"], :age => tmp_user["age"][0..1].to_i, :remote_ip => remote_ip, :uniq_key => cookies["uniq_key"] )
          NudeReport.increment_counter(:man_vote_count, nude_report_id)
          message = '투표가 정상 처리되었습니다. <br />질문을 공유해보는것은 어떨까요? ^^'  
        end
      else
        if nude_report.woman_vote_count >= 1000
          message = '투표 마감'
        else
          Vote.create(:nude_report_id => nude_report_id, :answer => answer, :gender => tmp_user["gender"], :age => tmp_user["age"][0..1].to_i, :remote_ip => remote_ip, :uniq_key => cookies["uniq_key"] )
          NudeReport.increment_counter(:woman_vote_count, nude_report_id)
          message = '투표가 정상 처리되었습니다. <br />질문을 공유해보는것은 어떨까요? ^^'  
        end
      end
    end

    report_analysis = nude_report.short_report_analysis_count
    content = render_to_string :partial => '/nude_reports/short_report_analysis', :locals => {:report_analysis => report_analysis, :nude_report => nude_report }
    respond_to do |format|
      format.json { render json: { "message"=> message, "content"=> content } } 
    end
  
  end
  
  def add_comment
    comment = params[:comment]
    parent_id = params[:parent_id] == 'undefined' ? nil : params[:parent_id].to_i
    nude_report_id = params[:nude_report_id].to_i
    remote_ip = request.env["HTTP_X_REAL_IP"] != nil ? request.env["HTTP_X_REAL_IP"] : request.env["REMOTE_ADDR"]
    tmp_user = ActiveSupport::JSON.decode(cookies["tmp_user"])
    
    Comment.create(:nude_report_id => nude_report_id, :comment => comment, :gender => tmp_user["gender"], :age => tmp_user["age"][0..1].to_i, :remote_ip => remote_ip, :parent_id => parent_id, :uniq_key => cookies["uniq_key"] )
    NudeReport.increment_counter(:comment_count, nude_report_id)
    @nude_report = NudeReport.find(nude_report_id)
    @comments = Comment.where(:nude_report_id => nude_report_id, :parent_id => nil).order("created_at")
    message = '등록 되었습니다'
    content = render_to_string :partial => '/nude_reports/comment'
    respond_to do |format|
        format.json { render json: { "message"=> message, "content"=> content } }
    end
  end
  
  def delete_comment
    
    comment = Comment.find(params[:comment_id])
    message = nil
    if comment.uniq_key == cookies["uniq_key"] 
      comment.destroy
      nude_report_id = params[:nude_report_id].to_i
      NudeReport.decrement_counter(:comment_count, nude_report_id)
      message = '삭제 되었습니다'
    else
      message = '자신의 의견만 삭제가능합니다'
    end
    
    @nude_report = NudeReport.find(nude_report_id)
    @comments = Comment.where(:nude_report_id => nude_report_id, :parent_id => nil).order("created_at")
    content = render_to_string :partial => '/nude_reports/comment'
    
    respond_to do |format|
      format.json { render json: { "message"=> message, "content"=> content } }
    end
  end
  
  def like
    remote_ip = request.env["HTTP_X_REAL_IP"] != nil ? request.env["HTTP_X_REAL_IP"] : request.env["REMOTE_ADDR"] 
    
    nude_report_id = params[:nude_report_id].to_i
    like = NudeReportLike.where("uniq_key = ? AND nude_report_id = ?", cookies["uniq_key"] , nude_report_id )
    if like.blank?
      NudeReportLike.create(:remote_ip => remote_ip , :nude_report_id => nude_report_id, :uniq_key => cookies["uniq_key"] )
      message = '추천완료'
    else
      message = '이미 추천하셨습니다.'
    end
    json_message = {"message"=> message, "count"=> NudeReportLike.where("nude_report_id = ?", nude_report_id).count}
    
    respond_to do |format|
      format.json { render json: json_message }
    end
  end
  
  def widget_api
    num = params[:number].blank? ? 0 : params[:number].to_i
    nude_report = NudeReport.today.report_type('nude').offset(num).limit(1).first
    unless nude_report
      nude_report = NudeReport.report_type('nude').order("man_vote_count desc").offset(num).limit(1).first
    end
    analysis_count = nude_report.total_analysis_count
    
    question = nude_report.title
    
    chart_url = gchart_total_url(analysis_count["total"], nude_report)
    legend_url = total_legend_url(nude_report)
    
    json_message = {"question"=> question, "chart_url"=> chart_url, "legend_url" => legend_url, "link" => "http://nu-bo.com/nude_reports/#{nude_report.id}" }
    respond_to do |format|
      format.json { render json: json_message }
    end
  end
  
  def gchart_total_url(report_analysis, nude_report)
    gchart_url = nil 
    tmp_analysis = report_analysis
    size = '160x80'
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
    gchart_url = Gchart.pie(:data => tmp_analysis,:size => size, :labels => labels, :bar_colors => colors_string)
    gchart_url 
  end
  
  def total_legend_url(nude_report)
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
    if legend_size > 30
      size ='160x75'
    elsif legend_size > 20
      size ='160x57'
    elsif legend_size > 10
      size ='160x40'
    else
      size ='160x23'
    end
    gchart_url = Gchart.pie(:size => size,  :legend => legend, :bar_colors => colors_string)
    gchart_url = gchart_url + '&chdls=333333,11&chdlp=b'
    gchart_url
  end
  
  
end