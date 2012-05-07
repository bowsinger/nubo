# -*- coding: utf-8 -*-
class FreeBoardsController < ApplicationController
  # GET /free_boards
  # GET /free_boards.json
  def index
    @free_boards = FreeBoard.order("created_at desc").all
    @side_nude_reports = NudeReport.today.report_type('nude').order("created_at desc").limit(10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @free_boards }
    end
  end

  # GET /free_boards/1
  # GET /free_boards/1.json
  def show
    @free_board = FreeBoard.find(params[:id])
    FreeBoard.increment_counter(:check_count, @free_board.id)
    @side_nude_reports = NudeReport.today.report_type('nude').order("created_at desc").limit(10)
    @comments = FreeBoardComment.where(:free_board_id => @free_board.id, :parent_id => nil).order("created_at")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @free_board }
    end
  end

  # GET /free_boards/new
  # GET /free_boards/new.json
  def new
    @free_board = FreeBoard.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @free_board }
    end
  end

  # GET /free_boards/1/edit
  def edit
    @free_board = FreeBoard.find(params[:id])
  end

  # POST /free_boards
  # POST /free_boards.json
  def create
    @free_board = FreeBoard.new(params[:free_board])
    tmp_user = ActiveSupport::JSON.decode(cookies["tmp_user"])
    @free_board.gender = tmp_user["gender"]
    @free_board.age = tmp_user["age"].to_i
    respond_to do |format|
      if @free_board.save
        format.html { redirect_to @free_board, notice: 'Free board was successfully created.' }
        format.json { render json: @free_board, status: :created, location: @free_board }
      else
        format.html { render action: "new" }
        format.json { render json: @free_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /free_boards/1
  # PUT /free_boards/1.json
  def update
    @free_board = FreeBoard.find(params[:id])

    respond_to do |format|
      if @free_board.update_attributes(params[:free_board])
        format.html { redirect_to @free_board, notice: 'Free board was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @free_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /free_boards/1
  # DELETE /free_boards/1.json
  def destroy
    @free_board = FreeBoard.find(params[:id])
    @free_board.destroy

    respond_to do |format|
      format.html { redirect_to free_boards_url }
      format.json { head :ok }
    end
  end
  
  def like
    remote_ip = request.env["HTTP_X_REAL_IP"] != nil ? request.env["HTTP_X_REAL_IP"] : request.env["REMOTE_ADDR"] 
    
    free_board_id = params[:free_board_id].to_i
    like = FreeBoardLike.where("uniq_key = ? AND free_board_id = ?", cookies["uniq_key"] , free_board_id )
    if like.blank?
      FreeBoardLike.create(:remote_ip => remote_ip , :free_board_id => free_board_id, :uniq_key => cookies["uniq_key"] )
      message = '추천완료'
    else
      message = '이미 추천하셨습니다.'
    end
    json_message = {"message"=> message, "count"=> FreeBoardLike.where("free_board_id = ?", free_board_id).count}
    
    respond_to do |format|
      format.json { render json: json_message }
    end
  end
  
  def add_comment
    comment = params[:comment]
    parent_id = params[:parent_id] == 'undefined' ? nil : params[:parent_id].to_i
    free_board_id = params[:free_board_id].to_i
    remote_ip = request.env["HTTP_X_REAL_IP"] != nil ? request.env["HTTP_X_REAL_IP"] : request.env["REMOTE_ADDR"]
    tmp_user = ActiveSupport::JSON.decode(cookies["tmp_user"])
    FreeBoardComment.create(:free_board_id => free_board_id, :comment => comment, :gender => tmp_user["gender"], :age => tmp_user["age"][0..1].to_i, :remote_ip => remote_ip, :parent_id => parent_id, :uniq_key => cookies["uniq_key"] )
    FreeBoard.increment_counter(:comment_count, free_board_id)
    @free_board = FreeBoard.find(free_board_id)
    @comments = FreeBoardComment.where(:free_board_id => @free_board.id, :parent_id => nil).order("created_at")
    message = '등록 되었습니다'
    content = render_to_string :partial => '/free_boards/comment'
    respond_to do |format|
        format.json { render json: { "message"=> message, "content"=> content } }
    end
  end
  
  def delete_comment
    
    comment = FreeBoardComment.find(params[:comment_id])
    message = nil
    if comment.uniq_key == cookies["uniq_key"] 
      comment.destroy
      free_board_id = params[:free_board_id].to_i
      FreeBoard.decrement_counter(:comment_count, free_board_id)
      message = '삭제 되었습니다'
    else
      message = '자신의 의견만 삭제가능합니다'
    end
    
    @free_board = FreeBoard.find(free_board_id)
    @comments = FreeBoardComment.where(:free_board_id => @free_board.id, :parent_id => nil).order("created_at")
    content = render_to_string :partial => '/free_boards/comment'
    
    respond_to do |format|
      format.json { render json: { "message"=> message, "content"=> content } }
    end
  end
  
  
  
end