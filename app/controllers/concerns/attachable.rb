module Attachable

  def build_attachment(file)
    attachment = Attachment.new :attachment => file, :name => file.original_filename
    attachment.content_type = attachment.attachment.file.content_type
    attachment
  end

  def send_attachment(attachment)
    data = read(attachment.attachment.identifier)
    send_data data, :disposition => "attachment", :type => attachment.content_type, :filename => attachment.name
  end

  def read(oid)
    size = size(oid)
    open(oid) { |lo| connection.lo_read(lo, size) }
  end

  def size(oid)
    open(oid) { |lo| connection.lo_lseek(lo, 0, 2) }
  end

  def open(oid)
    connection.transaction do
      lo = connection.lo_open(oid)
      result = yield lo
      connection.lo_close(lo)
      result
    end
  end

  def connection
    @con ||= ActiveRecord::Base.connection.raw_connection
  end

end