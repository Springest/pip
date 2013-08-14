# coding: utf-8

module Pip
  module Alfred
    class Filter
      class << self
        def execute(*args)
          ::Alfred.with_friendly_error do |alfred|
            Alfred.bundle_id = alfred.bundle_id
            @feedback = alfred.feedback

            query = args.dup

            command = args.shift
            major   = args.shift
            minor   = args.empty? ? nil : args.join(' ')

            delegate(command, major, minor)

            puts "<?xml version=\"1.0\"?>\n".concat @feedback.to_alfred(query)
          end
        end

        def delegate(command, major, minor)

          return overview          unless command
          
          if command == 'cn'
            return company_search(command, major, minor) if major
            return overview
          end
        end

        def overview
          commands = {
            'cn'    => 'Create a company note',
          }

          commands.each do |name,subtitle|
            @feedback.add_item({
              :uid          => "#{Alfred.bundle_id} #{name}",
              :title        => "pip #{name}",
              :subtitle     => subtitle,
              :arg          => "#{name}",
              :valid        => "yes",
              :autocomplete => "#{name}"
            })
          end
        end

        def cn
          @feedback.add_item({
            :uid          => "#{Alfred.bundle_id} cn",
            :title        => "pip cn",
            :subtitle     => subtitle,
            :arg          => "cn",
            :valid        => "yes ",
            :autocomplete => "cn",
            # :icon         => "http://www.pipelinedeals.com/images/thumb/missing_company.png"
          })
        end

        def company_search(command, major, minor)
          req = Request.new "/companies"
          companies = req.get( { 'conditions[company_name]' => major } )['entries']

          companies.each do |company|
            @feedback.add_item({
              :uid          => "#{Alfred.bundle_id} cn",
              :title        => "Create note for #{company['name']}",
              :subtitle     => company['city'],
              :arg          => "#{command} #{company['id']} #{minor}",
              :valid        => (minor ? "yes" : "no"),
              :autocomplete => "#{command} #{company['id']}"
            })
          end
        end
      end
    end
  end
end