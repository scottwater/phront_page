module DropHelpers
  def drop_file_div(file_name, element_selector)
    file_path = Rails.root.join("test", "support", file_name)
    file = File.open(file_path)
    content = file.read
    file.close

    # Create a temporary file object
    temp_file = Tempfile.new("temp_file")
    temp_file.write(content)
    temp_file.rewind

    # Execute JavaScript to simulate file drop
    page.execute_script(<<-JS, element_selector, temp_file.path)
      function createFile(path) {
        const file = new File([''], path.split('/').pop(), { type: '#{content_type_for(file_path)}' });
        return file;
      }

      const dropZone = document.querySelector(arguments[0]);
      const file = createFile(arguments[1]);
      const dt = new DataTransfer();
      dt.items.add(file);

      // Create and dispatch dragover event
      const dragOverEvent = new Event('dragover', { bubbles: true });
      dragOverEvent.preventDefault = () => {};
      dropZone.dispatchEvent(dragOverEvent);

      // Create and dispatch drop event
      const dropEvent = new Event('drop', { bubbles: true });
      dropEvent.preventDefault = () => {};
      dropEvent.dataTransfer = dt;

      dropZone.dispatchEvent(dropEvent);
    JS

    temp_file.unlink
  end

  def drop_file(file_name, element_selector)
    file_path = Rails.root.join("test", "support", file_name)
    file = File.open(file_path)
    content = file.read
    file.close

    # Create a temporary file object
    temp_file = Tempfile.new(file_name)
    temp_file.write(content)
    temp_file.rewind

    # Execute JavaScript to simulate file drop
    page.execute_script(<<-JS, element_selector, temp_file.path)
      function createFile(path) {
        const file = new File([''], path.split('/').pop(), { type: '#{content_type_for(file_path)}' });
        return file;
      }

      const element = document.querySelector(arguments[0]);
      const file = createFile(arguments[1]);
      const dt = new DataTransfer();
      dt.items.add(file);

      const event = new Event('drop', { bubbles: true });
      event.dataTransfer = dt;

      element.dispatchEvent(event);
    JS

    temp_file.unlink
    # Sleep for a bit to allow the file to be processed
    sleep 2 if ENV["CI"]
  end

  def content_type_for(file_path)
    extension = File.extname(file_path).delete(".")
    MIME::Types.type_for(extension).first.content_type
  end
end
