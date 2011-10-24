module MailFilter
  class IMAP

    # Does the heavy lifting when it comes to IMAP
    # 
    # Connects to the IMAP server and moves mail.
    # Only supports moving mail atm.
    #
    # Returns nothing
    def move(search_array, opts)

      imap = Net::IMAP.new(
        MailFilter.config.value['host'], 
        MailFilter.config.value['port'], 
        false)
      imap.login(MailFilter.config.value['username'], MailFilter.config.value['password'])

      imap.select(opts[:from])

      imap.uid_search(search_array).each do |uid|
        imap.uid_copy(uid, opts[:to])
        imap.uid_store(uid, "+FLAGS", [:Deleted])

        MailFilter.log.send("#{MailFilter.config.value['host']}_#{opts[:to]}_#{uid}",
          MailFilter.config.value['log_dest'])
      end
      
      imap.expunge
      imap.logout
      #imap.disconnect # Could be Errno:NOTCON

    # NoResponseError and ByResponseError happen often when imap'ing
    rescue Net::IMAP::NoResponseError => e
      MailFilter.log.send(e, {'level' => "warn"})
    rescue Net::IMAP::ByeResponseError => e
      MailFilter.log.send(e, {'level' => "warn"})
    rescue StandardError => e
      MailFilter.log.send(e, {'level' => "warn"})
      puts e
      exit 500
    end

  end
end

