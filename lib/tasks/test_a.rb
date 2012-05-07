# encoding: utf-8
require "#{File.dirname(__FILE__)}/../../config/environment.rb"

time = Time.now
excel_file = Spreadsheet::ParseExcel.parse(Rails.root.join('lib', 'tasks', 'aaa.xls'))
#time_loop = 1
excel_file.worksheet(0).each do |row|
  category_id = title = a = b = c = d = nil
  category_id = Category.find_by_name(row.at(0).to_s('utf-8')).id if row.at(0)
  title = row.at(1).to_s('utf-8') if row.at(1)
  a = row.at(2).to_s('utf-8') if row.at(2) 
  b = row.at(3).to_s('utf-8') if row.at(3) 
  c = row.at(4).to_s('utf-8') if row.at(4) 
  d = row.at(5).to_s('utf-8') if row.at(5) 
  report_type = 'nude'
  @nude_report = NudeReport.new(:category_id => category_id, :title => title, :a => a, :b => b, :c => c, :d => d, :report_type => report_type)
  start_at = NudeReport.where('report_type = ?', 'nude').order("end_at desc").first.start_at
  @nude_report.start_at = start_at + 3.hour
  @nude_report.end_at = @nude_report.start_at + 1.day
  @nude_report.save
#  time_loop = time_loop + 1
end

puts Time.now - time
