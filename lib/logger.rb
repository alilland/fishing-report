# frozen_string_literal: true

##
module Logger2
  ## console
  def self.console(level, message)
    logger = Logger.new(STDOUT)
    logger.progname = ENV['APP_NAME']
    case level
    when :fatal
      logger.fatal { message }
    when :warn
      logger.warn { message }
    when :info
      logger.info { message }
    when :debug
      logger.debug { message }
    end
  end

  ## file
  def self.file(level, message)
    time = Time.now.in_time_zone('Pacific Time (US & Canada)')
    filepath = File.join(File.dirname(__FILE__), '../log/application.log')
    file = File.open(filepath, File::WRONLY | File::APPEND | File::CREAT)

    ## if the file was created in the last 5 seconds
    if (Time.now - File.ctime(file)) < 5
      folder = File.join(File.dirname(__FILE__), '../log')
      File.chmod(0o644, filepath)
      env_user = ENV['RACK_ENV'] == 'production' ? ENV['OS_USER'] : ENV['USER']
      env_group = ENV['RACK_ENV'] == 'production' ? ENV['OS_USER'] : 'staff'
      FileUtils.chown(env_user, env_group, folder)
    end

    logger = Logger.new(file, 'weekly')
    logger.progname = ENV['APP_NAME']
    case level
    when :fatal
      logger.fatal { message }
    when :warn
      logger.warn { message }
    when :info
      logger.info { message }
    when :debug
      logger.debug { message }
    end
  end

  ## level [timestamp] process - message
  def self.log(level, message)
    console(level, message) if ENV['RACK_ENV'] == 'development'
    file(level, message)
  end
end
