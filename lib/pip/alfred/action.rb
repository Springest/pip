# coding: utf-8

module Pip
  module Alfred
    class Action
      class << self
        def execute(*args)
          method = args.shift
          return send(method, *args) if method
        end

        def cn(*args)
          company = args.shift
          if args.any?
            begin
              req = Request.new "/notes"
              result = req.post({
                :note => {
                  :company_id => company,
                  :content    => args.join(' ')
              }})
              status = "Note created!"
            rescue => e
              status = "Note creation FAILED!"
            ensure
              puts status
            end
          end
        end

        def pn(*args)
          person = args.shift
          if args.any?
            begin
              req = Request.new "/notes"
              result = req.post({
                :note => {
                  :person_id  => person,
                  :content    => args.join(' ')
              }})
              status = "Note created!"
            rescue => e
              status = "Note creation FAILED!"
            ensure
              puts status
            end
          end
        end

        def dn(*args)
          deal = args.shift
          if args.any?
            begin
              req = Request.new "/notes"
              result = req.post({
                :note => {
                  :deal_id  => deal,
                  :content  => args.join(' ')
              }})
              status = "Note created!"
            rescue => e
              status = "Note creation FAILED!"
            ensure
              puts status
            end
          end
        end

        def task(*args)
          type    = args.shift # 'deal', 'company', 'person'
          type_id = args.shift

          return unless args.any? # No need to go on

          due = due_to_time args.last
          args.pop if due

          opts = {
            :calendar_entry => {
              :type             => 'CalendarTask',
              :name             => args.join(' '),
              :association_type => type.capitalize,
              :association_id   => type_id,
          }}

          opts[:calendar_entry][:due_date] = due if due

          begin
            req = Request.new "/calendar_entries"
            result = req.post(opts)
            status = "Task created!"
          rescue => e
            status = "Task creation FAILED!"
          ensure
            puts status
          end
        end

        def due_to_time(due)
          return unless due

          due = due.strip.downcase.chomp.match /^@(\w+)$/
          due = due[1] if due

          wday = Time.now.wday

          due = case due
          when 'today'
            Time.now + 24*3600
          when 'tomorrow'
            Time.now + 24*3600
          when 'week'
            Time.now + 7*24*3600
          when 'mon', 'monday'
            Time.now + (7 - wday + 1)*24*3600
          when 'tue', 'tuesday'
            if wday < 2
              Time.now + 24*3600
            else
              Time.now + (7 - wday + 2)*24*3600
            end
          when 'wed', 'wednesday'
            if wday < 3
              Time.now + (3-wday)*24*3600
            else
              Time.now + (7 - wday + 3)*24*3600
            end
          when 'thu', 'thursday'
            if wday < 4
              Time.now + (4-wday)*24*3600
            else
              Time.now + (7 - wday + 4)*24*3600
            end
          when 'fri', 'friday'
            if wday < 5
              Time.now + (5-wday)*24*3600
            else
              Time.now + (7 - wday + 5)*24*3600
            end
          when 'sat', 'saturday'
            if wday < 6
              Time.now + (6-wday)*24*3600
            else
              Time.now + (7 - wday + 6)*24*3600
            end
          when 'sun', 'sunday'
            if wday < 7
              Time.now + (7-wday)*24*3600
            else
              Time.now + (7 - wday + 7)*24*3600
            end
          else
            nil
          end

          due = due.strftime "%Y-%m-%d" if due

          due
        end
      end
    end
  end
end