class Articlefile < ActiveRecord::Base
  belongs_to :article
  validates :article_id, presence: true
  #validates :filecontents, presence: true
  #validate  :file_size_under_one_mb
  
  def initialize(params = {})
    @file = params.delete(:filecontents)
    super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.filetype = @file.content_type
      self.filecontents = @file.read
    end
  end
  
  #def uploaded_file=(new_file)
  #   self.filename = sanitize_filename(new_file.original_filename)
  #   self.filetype = new_file.content_type
  #   self.filecontents = new_file.read  
  #end
  
  private
    NUM_BYTES_IN_MEGABYTE = 1048576
    
    def sanitize_filename(filename)
      return File.basename(filename)
    end
    
    def file_size_under_one_mb
      if (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 1
        errors.add(:file, 'File size cannot be over one megabyte.')
      end
    end
end
