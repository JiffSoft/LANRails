class Settings < ActiveRecord::Base
  @@avail_settings = YAML::load(File.open("#{RAILS_ROOT}/config/settings.yml"))

  validates_uniqueness_of :name
  validates_inclusion_of :name, :in => @@avail_settings.keys  

  @settings_cache = {}
  @cache_age = Time.now

  # convert it all to strings
  def value=(v)
    write_attribute(:value, v.to_s)
  end

  def self.[](name)
    if (!@settings_cache.has_key? name)
      @settings_cache[name] = fetch_setting(name).value
    end
    @settings_cache[name]  
  end
  
  def self.[]=(name, v)
    s = fetch_setting(name)
    s.value = (v ? v : "")
    @settings_cache[name] = nil
    s.save
    s.value
  end

  def self.check_cache
    settings_updated_on = Settings.maximum(:updated_at)
    if settings_updated_on && @cache_age <= settings_updated_on
      @settings_cache.clear
      @cache_age = Time.now
    end
  end

  private
  def self.fetch_setting(name)
    name = name.to_s
    raise "Invalid setting named #{name}" unless @@avail_settings.has_key?(name)
    s = find_by_name(name)
    s ||= new(:name => name, :value => @@avail_settings[name]['default']) if @@avail_settings.has_key? name
  end
end
