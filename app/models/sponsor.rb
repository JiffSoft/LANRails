class Sponsor < ActiveRecord::Base
  has_many :prizes

  def image=(upload)
    @uploaded_file = upload
    @filename = sanitize_filename(@uploaded_file.original_filename)
    write_attribute("image","/uploads/sponsors/#{@filename}")
  end

  def after_create
    # make the uploads/sponsors folder if it doesn't exist
    if !File.exists?(File.dirname(image_file_path))
      Dir.mkdir(File.dirname(image_file_path))
    end
    if @uploaded_file.instance_of?(Tempfile)
      FileUtils.copy(@uploaded_file.local_path, image_file_path)
    else
      File.open(self.image_file_path, "wb") { |f| f.write(@uploaded_file.read) }
    end
  end

  def after_destroy
    if File.exists?(self.image)
      File.delete(self.image)
      Dir.rmdir(File.dirname(self.file))
    end
  end

  def public_image_tag
    "<img src=\"#{self.image}\" border=\"0\" alt=\"#{self.name}\"/>" rescue ""
  end

  def image_file_path
    File.expand_path("#{RAILS_ROOT}/public/uploads/sponsors/#{@filename}")
  end

private
  def sanitize_filename(file_name)
    # get only the filename, not the whole path (from IE)
    just_filename = File.basename(file_name)
    # replace all none alphanumeric, underscore or perioids with underscore
    just_filename.gsub(/[^\w\.\_]/,'_')
  end
end
