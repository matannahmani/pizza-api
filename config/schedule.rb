# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 1.hours do # cleans all unfinshed orders from time > 1 hour
  now = Time.now
  orders = Order.where(status: false).where.not(updated_at: (now - 1.hours)..now)
  orders.destroy_all
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
