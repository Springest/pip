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

          due = args.last.match /@(\w+)$/
          due = due[1] if due

          if due
            args.pop

            return unless args.any?

            wday = Time.now.wday

            due = case due
            when 'tomorrow'
              Time.now + 24*3600
            when 'week'
              Time.now + 7*24*3600
            when 'mon'
              Time.now + (7 - wday + 1)*24*3600
            when 'tue'
              Time.now + (7 - wday + 2)*24*3600
            when 'wed'
              Time.now + (7 - wday + 3)*24*3600
            when 'thu'
              Time.now + (7 - wday + 4)*24*3600
            when 'fri'
              Time.now + (7 - wday + 5)*24*3600
            when 'sat'
              Time.now + (7 - wday + 6)*24*3600
            when 'sun'
              Time.now + (7 - wday + 7)*24*3600
            else
              nil
            end

            due = due.strftime "%Y-%m-%d" if due
          end

          opts = {
            :calendar_entry => {
              :type             => 'CalendarTask',
              :name             => args.join(' '),
              :association_type => type.capitalize,
              :association_id   => type_id,
          }}

          opts[:calendar_entry][:due_date] = due if due

          $stderr.puts opts

          begin
            req = Request.new "/calendar_entries"
            result = req.post(opts)
            $stderr.puts result
            status = "Task created!"
          rescue => e
            status = "Task creation FAILED!"
          ensure
            puts status
          end
        end
      end
    end
  end
end