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

        def dl(*args)
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
      end
    end
  end
end