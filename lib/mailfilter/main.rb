module MailFilter
  class Main

    def initialize
      @i = MailFilter::IMAP.new
      @f = MailFilter::Filters.new
    end

    # Simplify adding filters
    #
    # Returns nothing
    def add(name, filter_dsl)
      filter = @f.translate(filter_dsl)
      filter[:name] = name
      @f.add(filter)
    end

    # Run the program forever
    #
    # Returns nothing
    def foreverize
      loop do
        run
      end
    end

    # Collect all the filters and run them
    #
    # Returns nothing
    def run
      threads = []

      filters = @f.all
      filters.each do |filter|
        threads << Thread.new(filters) do |fi|
          @i.move(
            filter[:filter],
            { 
              :from => filter[:search_folder], 
              :to => filter[:destination_folder]
            }
          )
          puts "Applied filter #{filter[:name]}"
        end
      end
      threads.each { |t|  t.join }
    end

  end
end
