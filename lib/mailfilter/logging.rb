module MailFilter
  class Log

    # Log what you are doing
    #
    # Returns nothing
    def send(string, opts={})

      opts['log_dest'].downcase! unless opts['log_dest'].nil? 

      if opts['log_dest'] == 'stdout'
        log = Logger.new(STDOUT)
      else
        log = Logger.new(MailFilter.config.value['logfile_path'], 'daily')
      end
      
      opts = { 'level' => 'info' } if opts['level'].nil? 

      log.info(string) if opts['level'] == 'info'
      log.warn(string) if opts['level'] == 'warn'
      log.debug(string) if opts['level'] == 'debug'
    end

  end
end
