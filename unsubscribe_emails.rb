require 'csv'

users = User.joins(:job_intention).merge(Job::Intention.on)

unsubscribe_emails = []
CSV.read('/Users/zhangshuo/Desktop/unsubscribe_emails.csv').each do |line|
  unsubscribe_emails << line[0]
end
