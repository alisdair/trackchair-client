module Token
  class << self
    def path
      File.join(Dir.home, '.trackchair-client')
    end

    def load
      File.read(path).chomp
    end

    def store(token)
      File.write(path, token)
    end
  end
end
