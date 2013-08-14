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

          if command == 'pn'
            return people_search(command, major, minor) if major
            return overview
          end
        end

        def overview
          commands = {
            'cn'    => {
              :subtitle => 'Create a note on a company',
              :icon     => 'company.png' },
            'pn'    => {
              :subtitle => 'Create a note on a person',
              :icon     => 'person.png' }
          }

          commands.each do |name,opts|
            @feedback.add_item({
              :uid          => "#{Alfred.bundle_id} #{name}",
              :title        => "pip #{name}",
              :subtitle     => opts[:subtitle],
              :arg          => "#{name}",
              :valid        => "no",
              :autocomplete => "#{name}",
              :icon         => {:type => "default", :name => (opts[:icon] || "icon.png")}
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
            :icon         => {:type => "default", :name => "company.png"}
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
              :autocomplete => "#{command} #{company['id']}",
              :icon         => {:type => "default", :name => "company.png"}
            })
          end
        end

        def pn
          @feedback.add_item({
            :uid          => "#{Alfred.bundle_id} cn",
            :title        => "pip cn",
            :subtitle     => subtitle,
            :arg          => "cn",
            :valid        => "yes ",
            :autocomplete => "cn",
            :icon         => {:type => "default", :name => "person.png"}
          })
        end

        def people_search(command, major, minor)
          req = Request.new "/people"
          companies = req.get( { 'conditions[person_name]' => major } )['entries']

          companies.each do |person|
            @feedback.add_item({
              :uid          => "#{Alfred.bundle_id} cn",
              :title        => "Create note on #{person['first_name']} #{person['last_name']}",
              :subtitle     => person['company_name'],
              :arg          => "#{command} #{person['id']} #{minor}",
              :valid        => (minor ? "yes" : "no"),
              :autocomplete => "#{command} #{person['id']}",
              :icon         => {:type => "default", :name => "person.png"}
            })
          end
        end
      end
    end
  end
end