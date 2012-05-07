# -*- coding: utf-8 -*-
Time::DATE_FORMATS.merge!(
 :date => '%m/%d/%Y',
 :date_time12  => "%m/%d/%Y %I:%M%p",
 :date_time24  => "%m/%d/%Y %H:%M",
 :normal_datetime => "%Y-%m-%d %H:%M:%S",
 :dot_date => "%Y.%m.%d",
 :dash_date => "%Y-%m-%d",
 :dash_day => "%m-%d",
 :dash_time => "%H:%M:%S",
 :korean_date => "%Y년 %m월 %d일",
 :korean_day => "%m월 %d일",
 :simple_day => "%m/%d",
 :datetime_without_s => "%Y-%m-%d %H:%M"
)

Date::DATE_FORMATS.merge!(
 :korean_day => "%m월 %d일",
 :korean_date => "%Y년 %m월 %d일",
 :korean_month => "%Y년 %m월" 
)
