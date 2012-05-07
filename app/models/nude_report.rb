# -*- coding: utf-8 -*-
class NudeReport < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  has_many :votes
  has_many :nude_report_likes
  has_many :report_images
  
  
  
  attr_accessor :image_1, :image_2, :image_3, :image_4, :image_5
  
  scope :today, where("start_at < '#{Time.now}' and '#{Time.now}'< end_at")
  
  scope :past, where("nude_reports.end_at < '#{Time.now}'")
  scope :report_type , lambda { |report_type| where("report_type = ?", report_type)}
  
  
  def today?
    ret = false
    ret  = true if (self.end_at > Time.now)
    ret
  end
  
  def type_nude?
    ret = false
    ret  = true if (self.report_type == 'nude')
    ret
  end
  
  def total_analysis_count
    votes = self.votes
    a_total = b_total = c_total = d_total = 0
    votes.each do |vote|
      a_total = a_total + 1 if vote.answer == 'a'
      b_total = b_total + 1 if vote.answer == 'b'
      c_total = c_total + 1 if vote.answer == 'c'
      d_total = d_total + 1 if vote.answer == 'd'
    end
    return_hash = { "total" => [a_total, b_total, c_total, d_total]}
    return_hash
  end
  
  def short_report_analysis_count
    votes = self.votes
    a_total = a_man = a_woman = b_total = b_man = b_woman = c_total = c_man = c_woman = d_total = d_man = d_woman =  0
    votes.each do |vote|
      if vote.answer == 'a'
        a_total = a_total + 1
        vote.gender == '남자' ? a_man = a_man + 1 : a_woman = a_woman + 1 
      end
      if vote.answer == 'b'
        b_total = b_total + 1
        vote.gender == '남자' ? b_man = b_man + 1 : b_woman = b_woman + 1 
      end
      
      if vote.answer == 'c'
        c_total = c_total + 1
        vote.gender == '남자' ? c_man = c_man + 1 : c_woman = c_woman + 1 
      end
      
      if vote.answer == 'd'
        d_total = d_total + 1
        vote.gender == '남자' ? d_man = d_man + 1 : d_woman = d_woman + 1 
      end
    end
    return_hash = {
      "total" => [a_total, b_total, c_total, d_total],
      "gender" => {"man" => [a_man, b_man, c_man, d_man], "woman" => [a_woman, b_woman,  c_woman, d_woman] }
    }
    return_hash
  end
  
  def report_analysis_count
    votes = self.votes
    
    a_total = a_man = a_woman = a_10 = a_20 = a_30 = a_40 = a_man_10 = a_man_20 = a_man_30 = a_man_40 = a_woman_10 = a_woman_20 = a_woman_30 = a_woman_40 = 0
    b_total = b_man = b_woman = b_10 = b_20 = b_30 = b_40 = b_man_10 = b_man_20 = b_man_30 = b_man_40 = b_woman_10 = b_woman_20 = b_woman_30 = b_woman_40 = 0
    c_total = c_man = c_woman = c_10 = c_20 = c_30 = c_40 = c_man_10 = c_man_20 = c_man_30 = c_man_40 = c_woman_10 = c_woman_20 = c_woman_30 = c_woman_40 = 0
    d_total = d_man = d_woman = d_10 = d_20 = d_30 = d_40 = d_man_10 = d_man_20 = d_man_30 = d_man_40 = d_woman_10 = d_woman_20 = d_woman_30 = d_woman_40 = 0

    votes.each do |vote|
      if vote.answer == 'a'
        a_total = a_total + 1
        vote.gender == '남자' ? a_man = a_man + 1 : a_woman = a_woman + 1 
        if vote.age == 10
          a_10 = a_10 + 1
          vote.gender == '남자' ? a_man_10 = a_man_10 + 1 : a_woman_10 = a_woman_10 + 1
        end
        if vote.age == 20
          a_20 = a_20 + 1
          vote.gender == '남자' ? a_man_20 = a_man_20 + 1 : a_woman_20 = a_woman_20 + 1
        end
        if vote.age == 30
          a_30 = a_30 + 1
          vote.gender == '남자' ? a_man_30 = a_man_30 + 1 : a_woman_30 = a_woman_30 + 1
        end
        if vote.age == 40
          a_40 = a_40 + 1
          vote.gender == '남자' ? a_man_40 = a_man_40 + 1 : a_woman_40 = a_woman_40 + 1
        end 
      end
      
      if vote.answer == 'b'
        b_total = b_total + 1
        vote.gender == '남자' ? b_man = b_man + 1 : b_woman = b_woman + 1 
        if vote.age == 10
          b_10 = b_10 + 1
          vote.gender == '남자' ? b_man_10 = b_man_10 + 1 : b_woman_10 = b_woman_10 + 1
        end
        if vote.age == 20
          b_20 = b_20 + 1
          vote.gender == '남자' ? b_man_20 = b_man_20 + 1 : b_woman_20 = b_woman_20 + 1
        end
        if vote.age == 30
          b_30 = b_30 + 1
          vote.gender == '남자' ? b_man_30 = b_man_30 + 1 : b_woman_30 = b_woman_30 + 1
        end
        if vote.age == 40
          b_40 = b_40 + 1
          vote.gender == '남자' ? b_man_40 = b_man_40 + 1 : b_woman_40 = b_woman_40 + 1
        end 
      end
      
      if vote.answer == 'c'
        c_total = c_total + 1
        vote.gender == '남자' ? c_man = c_man + 1 : c_woman = c_woman + 1 
        if vote.age == 10
          c_10 = c_10 + 1
          vote.gender == '남자' ? c_man_10 = c_man_10 + 1 : c_woman_10 = c_woman_10 + 1
        end
        if vote.age == 20
          c_20 = c_20 + 1
          vote.gender == '남자' ? c_man_20 = c_man_20 + 1 : c_woman_20 = c_woman_20 + 1
        end
        if vote.age == 30
          c_30 = c_30 + 1
          vote.gender == '남자' ? c_man_30 = c_man_30 + 1 : c_woman_30 = c_woman_30 + 1
        end
        if vote.age == 40
          c_40 = c_40 + 1
          vote.gender == '남자' ? c_man_40 = c_man_40 + 1 : c_woman_40 = c_woman_40 + 1
        end 
      end
      
      if vote.answer == 'd'
        d_total = d_total + 1
        vote.gender == '남자' ? d_man = d_man + 1 : d_woman = d_woman + 1 
        if vote.age == 10
          d_10 = d_10 + 1
          vote.gender == '남자' ? d_man_10 = d_man_10 + 1 : d_woman_10 = d_woman_10 + 1
        end
        if vote.age == 20
          d_20 = d_20 + 1
          vote.gender == '남자' ? d_man_20 = d_man_20 + 1 : d_woman_20 = d_woman_20 + 1
        end
        if vote.age == 30
          d_30 = d_30 + 1
          vote.gender == '남자' ? d_man_30 = d_man_30 + 1 : d_woman_30 = d_woman_30 + 1
        end
        if vote.age == 40
          d_40 = d_40 + 1
          vote.gender == '남자' ? d_man_40 = d_man_40 + 1 : d_woman_40 = d_woman_40 + 1
        end 
      end
    end

    return_hash = {
      "total" => [a_total, b_total, c_total, d_total],
      "gender" => {"man" => [a_man, b_man, c_man, d_man], "woman" => [a_woman, b_woman,  c_woman, d_woman] },
      "age" => {"10" => [a_10, b_10, c_10, d_10], "20" => [a_20, b_20, c_20, d_20], "30" => [a_30, b_30, c_30, d_30], "40" => [a_40, b_40, c_40, d_40]  },
      "gender_age" => {
        "man" => {
          "10" => [a_man_10, b_man_10, c_man_10, d_man_10], 
          "20" => [a_man_20, b_man_20, c_man_20, d_man_20], 
          "30" => [a_man_30, b_man_30, c_man_30, d_man_30], 
          "40" => [a_man_40, b_man_40, c_man_40, d_man_40] 
          },
        "woman" => {
          "10" => [a_woman_10, b_woman_10, c_woman_10, d_woman_10], 
          "20" => [a_woman_20, b_woman_20, c_woman_20, d_woman_20], 
          "30" => [a_woman_30, b_woman_30, c_woman_30, d_woman_30], 
          "40" => [a_woman_40, b_woman_40, c_woman_40, d_woman_40] 
          }
       }
    }
  end
  
  def return_answer(index)
    answer = nil
    if index == 1
      answer = self.a
    elsif index == 2
      answer = self.b
    elsif index == 3
      answer = self.c
    else  
      answer = self.d
    end
    answer
  end
  
  def self.ratio_compute(target_array)
    total_count = NudeReport.total_count(target_array)
    return_array = []
    unless total_count == 0 
      target_array.each do |target|
        return_array.push(((target.to_f / total_count.to_f) * 100).round(1))  
      end
    end
    return_array
  end
  
  def self.total_count(target_array)
    total_count = 0
    target_array.each do |target|
      total_count = total_count + target
    end
    total_count
  end
  
  def self.top_ratio(target_array)
    top_ratio = 0
    top_ratio_index = 0
    target_array.each_with_index do |target, index|
      if top_ratio < target
        top_ratio = target 
        top_ratio_index = index + 1
      end
    end
    [top_ratio, top_ratio_index]
  end
  
  
end