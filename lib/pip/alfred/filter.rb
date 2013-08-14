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
            return company_search(command, major, minor, 'note') if major
            return overview
          end

          if command == 'pn'
            return people_search(command, major, minor, 'note') if major
            return overview
          end

          if command == 'dn'
            return deal_search(command, major, minor, 'note') if major
            return overview
          end

          if command == 'ct'
            task_command = "task company"
            return company_search(task_command, major, minor, 'task') if major
            return overview
          end

          if command == 'pt'
            task_command = "task person"
            return people_search(task_command, major, minor, 'task') if major
            return overview
          end

          if command == 'dt'
            task_command = "task deal"
            return deal_search(task_command, major, minor, 'task') if major
            return overview
          end
        end

        def overview
          commands = {
            'cn'    => {
              :title => 'Create a note on a company',
              :icon     => 'company.png' },
            'pn'    => {
              :title => 'Create a note on a person',
              :icon     => 'person.png' },
            'dn'    => {
              :title => 'Create a note on a deal',
              :icon     => 'deal.png' },
            'ct'    => {
              :title => 'Create a task on a company',
              :icon     => 'company.png' },
            'pt'    => {
              :title => 'Create a task on a person',
              :icon     => 'person.png' },
            'dt'    => {
              :title => 'Create a task on a deal',
              :icon     => 'deal.png' },
          }

          commands.each do |name,opts|
            @feedback.add_item({
              :uid          => "#{Alfred.bundle_id} #{name}",
              :title        => opts[:title],
              :subtitle     => "pip #{name}",
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
            :valid        => "no",
            :autocomplete => "cn",
            :icon         => {:type => "default", :name => "company.png"}
          })
        end

        def company_search(command, major, minor, create_type)
          req = Request.new "/companies"
          companies = req.get( { 'conditions[company_name]' => major } )['entries']

          companies.each do |company|
            @feedback.add_item({
              :uid          => "#{Alfred.bundle_id} cn",
              :title        => "Create #{create_type} on #{company['name']}",
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
            :uid          => "#{Alfred.bundle_id} pn",
            :title        => "pip pn",
            :subtitle     => subtitle,
            :arg          => "pn",
            :valid        => "no ",
            :autocomplete => "pn",
            :icon         => {:type => "default", :name => "person.png"}
          })
        end

        def people_search(command, major, minor, create_type)
          req = Request.new "/people"
          people = req.get( { 'conditions[person_name]' => major } )['entries']

          people.each do |person|
            @feedback.add_item({
              :uid          => "#{Alfred.bundle_id} pn",
              :title        => "Create #{create_type} on #{person['first_name']} #{person['last_name']}",
              :subtitle     => person['company_name'],
              :arg          => "#{command} #{person['id']} #{minor}",
              :valid        => (minor ? "yes" : "no"),
              :autocomplete => "#{command} #{person['id']}",
              :icon         => {:type => "default", :name => "person.png"}
            })
          end
        end

        def dn
          @feedback.add_item({
            :uid          => "#{Alfred.bundle_id} dn",
            :title        => "pip dn",
            :subtitle     => subtitle,
            :arg          => "dn",
            :valid        => "no ",
            :autocomplete => "dn",
            :icon         => {:type => "default", :name => "person.png"}
          })
        end

        def deal_search(command, major, minor, create_type)
          req = Request.new "/deals"
          deals = req.get( { 'conditions[deal_name]' => major } )['entries']

          deals.each do |deal|
            @feedback.add_item({
              :uid          => "#{Alfred.bundle_id} dn",
              :title        => "Create #{create_type} on #{deal['name']}",
              :subtitle     => deal['company']['name'],
              :arg          => "#{command} #{deal['id']} #{minor}",
              :valid        => (minor ? "yes" : "no"),
              :autocomplete => "#{command} #{deal['id']}",
              :icon         => {:type => "default", :name => "deal.png"}
            })
          end
        end

        def ct
          @feedback.add_item({
            :uid          => "#{Alfred.bundle_id} ct",
            :title        => "pip ct",
            :subtitle     => subtitle,
            :arg          => "ct",
            :valid        => "no ",
            :autocomplete => "ct",
            :icon         => {:type => "default", :name => "company.png"}
          })
        end

        def pt
          @feedback.add_item({
            :uid          => "#{Alfred.bundle_id} pt",
            :title        => "pip pt",
            :subtitle     => subtitle,
            :arg          => "pt",
            :valid        => "no ",
            :autocomplete => "pt",
            :icon         => {:type => "default", :name => "person.png"}
          })
        end

        def dt
          @feedback.add_item({
            :uid          => "#{Alfred.bundle_id} dt",
            :title        => "pip dt",
            :subtitle     => subtitle,
            :arg          => "dt",
            :valid        => "no ",
            :autocomplete => "dt",
            :icon         => {:type => "default", :name => "deal.png"}
          })
        end
      end
    end
  end
end