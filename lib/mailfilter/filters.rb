module MailFilter
  class Filters

    def initialize
      @filters = []
      load_filters
    end

    # Load filters
    #
    # Returns nothing
    def load_filters
      loaded_data = MultiJson.decode(
        File.new(MailFilter.config.value['filter_file'], 'r').read)

      loaded_data.each do |name,filter|
        data = {:name => name}.merge(translate(filter))
        add(data)
      end
    end

    # Add a new filter
    #
    # Filters look like this:
    # { 
    #   :name => "Name_of_filter",
    #   :filter => 
    #     [ 
    #       "from",
    #       "example@example.com",
    #     ],
    #   :search_folder => "INBOX",
    #   :destination_folder => "INBOX.example"
    # }
    #
    #
    # Returns nothing
    def add(filter)
      @filters.push(filter)
    end

    # Delete a filter by name
    #
    # Returns nothing
    def delete(name)
      delete = get(name)
      @filters = @filters - delete
    end

    # Get a filter by name
    #
    # Returns filter
    def get(name)
      @filters.select {|f| f[:name] == name }
    end

    #
    # This method will translate from
    # an easy to use language to the
    # array format that ruby-imap uses
    #
    # Returns array of IMAP usable search
    def translate(filter_dsl)
      filter = {}
      
      # Collect FROM and search object
      filter_dsl =~ /^(\w+)\s?=>\s?([a-z0-9_.@-]+):?(\w+)?,/i
      
      search_array = [ $1, $2 ]
      search_array.push($3) unless $3.nil?
  
      # Collect search folder and destination
      filter_dsl =~ /,\sin\s([\w.]+),\sto\s([\w.]+)$/i

      filter = {
        :filter             => search_array,
        :search_folder      => $1,
        :destination_folder => $2
      }
    end

    # Collects all filters
    #
    # Returns hash of all filters
    def all
      @filters
    end

  end
end
