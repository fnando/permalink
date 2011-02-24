class String
  def to_permalink
    str = ActiveSupport::Multibyte::Chars.new(self)
    str = str.normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s
    str.gsub!(/[^-\w\d]+/sim, "-")
    str.gsub!(/-+/sm, "-")
    str.gsub!(/^-?(.*?)-?$/, '\1')
    str.downcase!
    str
  end

  def identify
    begin
      if Mongoid.parameterize_keys
        gsub(/[^a-z0-9]+/, ' ').strip.gsub(' ', '-')
      else
        self
      end
    rescue
      self
    end
  end
end
