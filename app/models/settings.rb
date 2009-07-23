class Settings < ActiveRecord::Base
  validates_uniqueness_of :name

  @settings_cache = {}
  @cache_age = Time.now

  def self.[](name)
    v = @settings_cache[name]
    v ? v : (@settings_cache[name] = fetch_setting(name).value)
  end
  
  def self.[]=(name, v)
    setting = fetch_setting(name)
    setting.value = (v ? v : "")
    @settings_cache[name] = nil
    setting.save
    setting.value
  end

  def self.check_cache
    settings_updated_on = Settings.maximum(:updated_on)
    if settings_updated_on && @cache_age <= settings_updated_on
      @settings_cache.clear
      @cache_age = Time.now
    end
  end

  private
  def self.fetch_setting(name)
    name = name.to_s
    setting = find_by_name(name)
    setting ||= new(:name => name, :value => '')
  end
end
