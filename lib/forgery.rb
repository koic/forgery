class Forgery
  def self.dictionaries(*dictionaries)
    dictionaries.each do |dictionary|
      const_set(dictionary.to_s.upcase, read_dictionary(dictionary))
    end
  end

  def self.formats(*formats)
    formats.each do |format|
      const_set(format.to_s.upcase + "_FORMATS", read_format(format))
    end
  end

protected

  def self.read_file(file)
    lines = []
    IO.foreach(file) do |line|
      lines << line.chomp unless line.chomp == ''
    end
    lines
  end

  def self.read_dictionary(dictionary)
    read_file(path_to_dictionary(dictionary))
  end

  def self.read_format(format)
    read_file(path_to_format(format))
  end

  def self.path_to_format(format)
    File.dirname(__FILE__) + '/formats/' + format.to_s
  end

  def self.path_to_dictionary(dictionary)
    File.dirname(__FILE__) + '/dictionaries/' + dictionary.to_s
  end

end

Dir[File.expand_path(File.dirname(__FILE__) + '/**/*.rb')].uniq.each do |file|
  require file
end