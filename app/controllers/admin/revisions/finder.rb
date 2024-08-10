module Admin::Revisions::Finder
  extend ActiveSupport::Concern

  def new_instance_with_revision(model_class)
    @revision = Revision.find(params[:revision])
    raise "Invalid revision" unless @revision.record_type == model_class.name
    raise "Invalid revision" if @revision.record
    @revision_model_id = @revision.uid
    instance_variable_set(:"@#{model_class.name.underscore}", model_class.new(@revision.data))
  end

  def exsting_instance_with_revision(model_class)
    @revision = Revision.find(params[:revision])
    raise "Invalid revision" unless @revision.record&.class == model_class
    raise "Invalid revision" unless @revision.record.id == params[:id].to_i
    record = @revision.record
    @revision.data.each do |key, value|
      record.send(:"#{key}=", value)
    end
    instance_variable_set(:"@#{model_class.name.underscore}", record)
  end
end
