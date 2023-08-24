require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def clean_phone_number(phone_number)
  phone_number.gsub!(/[!\D]/, '')
  if phone_number.length == 11 && phone_number[0] == '1'
    phone_number.sub('1', '')
  elsif phone_number.length == 10
    phone_number
  else
    'Bad number!'
  end
end

def most_frequent(array)
  array.max_by { |element| array.count(element) }
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)
hour_registered = []
day_registered = []
i = 0

days_of_week = {0 => 'Sunday',
                1 => 'Monday',
                2 => 'Tuesday',
                3 => 'Wednesday',
                4 => 'Thursday',
                5 => 'Friday',
                6 => 'Saturday' }

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  legislators = legislators_by_zipcode(zipcode)
  date = row[:regdate]


  date_to_string = DateTime.strptime(date, '%m/%d/%y %H:%M')
  hour_registered[i] = date_to_string.hour
  day_registered[i] = date_to_string.wday
  i += 1

  puts "#{name}, #{zipcode}, #{phone_number}, #{date}"
  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end
puts "Most active hour is : #{most_frequent(hour_registered)}"
puts "Most active day is : #{days_of_week[most_frequent(day_registered)]}"
